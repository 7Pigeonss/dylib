import UIKit

public final class CenterDotView: UIView {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        isUserInteractionEnabled = false
        isOpaque = false
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) is unsupported")
    }

    public override func draw(_ rect: CGRect) {
        UIColor.black.setFill()
        UIBezierPath(
            ovalIn: CGRect(
                x: (bounds.width - 3) / 2,
                y: (bounds.height - 3) / 2,
                width: 3,
                height: 3
            )
        ).fill()
    }
}