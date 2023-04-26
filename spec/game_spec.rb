require_relative '../lib/game'
require_relative '../lib/board'
require_relative '../lib/user'

describe Game do
  describe '#initialize' do
    context 'when initializing the class' do

      it 'creates a new instance of the Board class' do
        expect(Board).to receive(:new).exactly(1).time
        Game.new('user1', 'user2')
      end
    end
  end

  let(:user1) { instance_double(User, name: 'user1', game_piece: 'X') }
  let(:user2) { instance_double(User, name: 'user2', game_piece: 'O') }
  subject(:game_draw) { described_class.new(user1, user2) }

  describe '#draw_board' do

    before do
      allow(game_draw.game_board).to receive(:draw_board)
    end
    
    it 'draws the game board' do
      expect(game_draw.game_board).to receive(:draw_board).exactly(1).time
      game_draw.draw_board
    end
  end

  describe '#choose_placement' do
    let(:user1) { instance_double(User, name: 'user1', game_piece: 'X') }
    let(:user2) { instance_double(User, name: 'user2', game_piece: 'O') }
    subject(:game_placement) { described_class.new(user1, user2) }

    context 'when user selects a spot that is not taken' do
      before do
        valid_spot = 1
        allow(game_placement).to receive(:gets).and_return(valid_spot).exactly(1).time
      end

      it 'stops loop and does not display error message' do
        error_message = "That spot is taken, choose again!"
        expect(game_placement).not_to receive(:puts).with(error_message)
      end
    end

    context 'when user chooses a taken spot, then an open spot' do
      before do
        game_placement.game_board.spots[4] = 'O'
        chosen_five = 5
        valid_spot = 3
        allow(game_placement).to receive(:gets).and_return(chosen_five, valid_spot)
      end

      it 'displays error message once and then stops the loop' do
        error_message = "That spot is taken, choose again!"
        expect(game_placement).to receive(:puts).with(error_message).once
        game_placement.choose_placement
      end
    end

    context 'when user chooses a taken spot twice, then an open spot' do
      before do
        game_placement.game_board.spots[6] = 'O'
        game_placement.game_board.spots[8] = 'X'
        chosen_seven = 7
        chosen_nine = 9
        valid_spot = 8
        allow(game_placement).to receive(:gets).and_return(chosen_seven, chosen_nine, valid_spot)
      end

      it 'displays error message twice and then stops the loop' do
        error_message = "That spot is taken, choose again!"
        expect(game_placement).to receive(:puts).with(error_message).twice
        game_placement.choose_placement 
      end
    end
  end

  describe '#switch_turns' do
    let(:user1) { instance_double(User, name: 'user1', game_piece: 'X') }
    let(:user2) { instance_double(User, name: 'user2', game_piece: 'O') }
    subject(:game_turn) { described_class.new(user1, user2) }

    context "when player 1's turn is finished" do
      before do
        player1 = game_turn.instance_variable_get(:@player_1)
        game_turn.instance_variable_set(:@player_turn, player1)
      end

      it "switches to player 2's turn" do
        turn = game_turn.instance_variable_get(:@player_turn)
        player2 = game_turn.instance_variable_get(:@player_2)
        expect(turn).to eq(player2)
        game_turn.switch_turns
      end
    end

    context "when player 2's turn is finished" do
      before do
        player2 = game_turn.instance_variable_get(:@player_2)
        game_turn.instance_variable_set(:@player_turn, player2)
      end

      it "switches to player 1's turn" do
        turn = game_turn.instance_variable_get(:@player_turn)
        player1 = game_turn.instance_variable_get(:@player_1)
        expect(turn).to eq(player1)
        game_turn.switch_turns
      end
    end
  end

  describe '#check_status' do
    let(:user1) { instance_double(User, name: 'user1', game_piece: 'X') }
    let(:user2) { instance_double(User, name: 'user2', game_piece: 'O') }

    context 'when a player has won' do
      subject(:game_won) { described_class.new(user1, user2) }

      before do
        allow(game_won).to receive(:player_won?).and_return(true)
      end

      it 'outputs correct phrase' do
        turn = game_won.instance_variable_get(:@player_turn)
        winner_message = "#{turn.name} is the winner!\n"
        expect{ game_won.check_status }.to output(winner_message).to_stdout
      end
    end

    context 'when there is a draw' do
      subject(:game_player_draw) { described_class.new(user1, user2) }

      before do
        allow(game_player_draw).to receive(:player_draw?).and_return(true)
      end

      it 'outputs correct phrase' do
        draw_message = "It's a draw!\n"
        expect { game_player_draw.check_status }.to output(draw_message).to_stdout  
      end
    end

    context 'when there is no winner or draw' do
      subject(:game_continue) { described_class.new(user1, user2) }

      before do
        allow(game_continue).to receive(:player_won?).and_return(false)
        allow(game_continue).to receive(:player_draw?).and_return(false)
        allow(game_continue).to receive(:play_game).once
      end

      it 'does not output a winner or draw message' do
        expect(game_continue).to receive(:play_game)
        game_continue.check_status
      end
    end
  end
end
