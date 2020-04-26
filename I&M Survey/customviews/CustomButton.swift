//
//  CustomButton.swift
//  I&M Survey
//
//  Created by Morris on 21/04/2020.
//  Copyright © 2020 Morris. All rights reserved.
//

import UIKit

@IBDesignable class CustomButton : UIButton{
    var corners : UIRectCorner = []
    var cornerRadiusValue : CGFloat = 0
    @IBInspectable public var cornerRadius : CGFloat {
        get {
            return cornerRadiusValue
        }
        set {
            cornerRadiusValue = newValue
        }
    }
    @IBInspectable public var topLeft : Bool {
        get {
            return corners.contains(.topLeft)
        }
        set {
            setCorner(newValue: newValue, for: .topLeft)
        }
    }
    
    @IBInspectable public var topRight : Bool {
        get {
            return corners.contains(.topRight)
        }
        set {
            setCorner(newValue: newValue, for: .topRight)
        }
    }
    
    @IBInspectable public var bottomLeft : Bool {
        get {
            return corners.contains(.bottomLeft)
        }
        set {
            setCorner(newValue: newValue, for: .bottomLeft)
        }
    }
    
    @IBInspectable public var bottomRight : Bool {
        get {
            return corners.contains(.bottomRight)
        }
        set {
            setCorner(newValue: newValue, for: .bottomRight)
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor = .black {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    @IBInspectable var titleLeftPadding: CGFloat = 0.0 {
        didSet {
            titleEdgeInsets.left = titleLeftPadding
        }
    }
    @IBInspectable var titleRightPadding: CGFloat = 0.0 {
        didSet {
            titleEdgeInsets.right = titleRightPadding
        }
    }
    @IBInspectable var titleTopPadding: CGFloat = 0.0 {
        didSet {
            titleEdgeInsets.top = titleTopPadding
        }
    }
    @IBInspectable var titleBottomPadding: CGFloat = 0.0 {
        didSet {
            titleEdgeInsets.bottom = titleBottomPadding
        }
    }
    @IBInspectable var imageLeftPadding: CGFloat = 0.0 {
        didSet {
            imageEdgeInsets.left = imageLeftPadding
        }
    }
    @IBInspectable var imageRightPadding: CGFloat = 0.0 {
        didSet {
            imageEdgeInsets.right = imageRightPadding
        }
    }
    @IBInspectable var imageTopPadding: CGFloat = 0.0 {
        didSet {
            imageEdgeInsets.top = imageTopPadding
        }
    }
    @IBInspectable var imageBottomPadding: CGFloat = 0.0 {
        didSet {
            imageEdgeInsets.bottom = imageBottomPadding
        }
    }
    
    @IBInspectable var enableImageRightAligned: Bool = false
    override func layoutSubviews() {
        super.layoutSubviews()
        if enableImageRightAligned,
            let imageView = imageView {
            imageEdgeInsets.left = self.bounds.width - imageView.bounds.width -
            imageRightPadding
        }
    }
    
    func setCorner(newValue: Bool, for corner: UIRectCorner) {
        if newValue {
            addRectCorner(corner: corner)
        } else {
            removeRectCorner(corner: corner)
        }
    }
    
    func addRectCorner(corner: UIRectCorner) {
        corners.insert(corner)
        updateCorners()
    }
    
    func removeRectCorner(corner: UIRectCorner) {
        if corners.contains(corner) {
            corners.remove(corner)
            updateCorners()
        }
    }
    
    func updateCorners() {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: cornerRadiusValue, height: cornerRadiusValue))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}

class UIRadioButton: UIButton {
    var alternateButton:Array<UIRadioButton>?
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 2.0
        self.layer.masksToBounds = true
    }
    
    func unselectAlternateButtons(){
        if alternateButton != nil {
            self.isSelected = true
            
            for aButton:UIRadioButton in alternateButton! {
                aButton.isSelected = false
            }
        }else{
            toggleButton()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        unselectAlternateButtons()
        super.touchesBegan(touches, with: event)
    }
    
    func toggleButton(){
        self.isSelected = !isSelected
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.layer.borderColor = GlobalVariables.colorAccent.cgColor
            } else {
                self.layer.borderColor = UIColor.gray.cgColor
            }
        }
    }
}

@IBDesignable
public class KGRadioButton: UIButton {
    
    internal var outerCircleLayer = CAShapeLayer()
    internal var innerCircleLayer = CAShapeLayer()
    
    
    @IBInspectable public var outerCircleColor: UIColor = UIColor.black {
        didSet {
            outerCircleLayer.strokeColor = outerCircleColor.cgColor
        }
    }
    @IBInspectable public var innerCircleCircleColor: UIColor = UIColor.black{
        didSet {
            setFillState()
        }
    }
    
    @IBInspectable public var outerCircleLineWidth: CGFloat = 3.0 {
        didSet {
            setCircleLayouts()
        }
    }
    @IBInspectable public var innerCircleGap: CGFloat = 3.0 {
        didSet {
            setCircleLayouts()
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        customInitialization()
    }
    // MARK: Initialization
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customInitialization()
    }
    internal var setCircleRadius: CGFloat {
        let width = bounds.width
        let height = bounds.height
        
        let length = width > height ? height : width
        return (length - outerCircleLineWidth) / 2
    }
    
    private var setCircleFrame: CGRect {
        let width = bounds.width
        let height = bounds.height
        
        let radius = setCircleRadius
        let x: CGFloat
        let y: CGFloat
        
        if width > height {
            y = outerCircleLineWidth / 2
            x = (width / 2) - radius
        } else {
            x = outerCircleLineWidth / 2
            y = (height / 2) - radius
        }
        
        let diameter = 2 * radius
        return CGRect(x: x, y: y, width: diameter, height: diameter)
    }
    
    private var circlePath: UIBezierPath {
        return UIBezierPath(roundedRect: setCircleFrame, cornerRadius: setCircleRadius)
    }
    
    private var fillCirclePath: UIBezierPath {
        let trueGap = innerCircleGap + (outerCircleLineWidth / 2)
        return UIBezierPath(roundedRect: setCircleFrame.insetBy(dx: trueGap, dy: trueGap), cornerRadius: setCircleRadius)
        
    }
    
    private func customInitialization() {
        outerCircleLayer.frame = bounds
        outerCircleLayer.lineWidth = outerCircleLineWidth
        outerCircleLayer.fillColor = UIColor.clear.cgColor
        outerCircleLayer.strokeColor = outerCircleColor.cgColor
        layer.addSublayer(outerCircleLayer)
        
        innerCircleLayer.frame = bounds
        innerCircleLayer.lineWidth = outerCircleLineWidth
        innerCircleLayer.fillColor = UIColor.clear.cgColor
        innerCircleLayer.strokeColor = UIColor.clear.cgColor
        layer.addSublayer(innerCircleLayer)
        
        setFillState()
    }
    
    private func setCircleLayouts() {
        outerCircleLayer.frame = bounds
        outerCircleLayer.lineWidth = outerCircleLineWidth
        outerCircleLayer.path = circlePath.cgPath
        
        innerCircleLayer.frame = bounds
        innerCircleLayer.lineWidth = outerCircleLineWidth
        innerCircleLayer.path = fillCirclePath.cgPath
    }
    
    // MARK: Custom
    private func setFillState() {
        if self.isSelected {
            innerCircleLayer.fillColor = outerCircleColor.cgColor
        } else {
            innerCircleLayer.fillColor = UIColor.clear.cgColor
        }
    }
    // Overriden methods.
    override public func prepareForInterfaceBuilder() {
        customInitialization()
    }
    override public func layoutSubviews() {
        super.layoutSubviews()
        setCircleLayouts()
    }
    override public var isSelected: Bool {
        didSet {
            setFillState()
        }
    }
}


class DefaultButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        //
        //let radius: CGFloat = self.bounds.size.height / 2.0
        //self.layer.cornerRadius = radius
        self.clipsToBounds = true
        //
        let top = UIColor(red: 246/255, green: 86/255, blue: 45/255, alpha: 1.0).cgColor
        let center = UIColor(red: 249/255, green: 69/255, blue: 44/255, alpha: 1.0).cgColor
        let bottom = UIColor(red: 255/255, green: 38/255, blue: 0/255, alpha: 1).cgColor
        //
        let btnGradient = CAGradientLayer()
        btnGradient.colors = [top, center,bottom]
        btnGradient.locations = [0.0,0.5,1.0]
        //
        btnGradient.frame = self.bounds
        //
        self.layer.insertSublayer(btnGradient, at: 0)
    }
}

class ThemedButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        //
        //let radius: CGFloat = self.bounds.size.height / 2.0
        //self.layer.cornerRadius = radius
        self.clipsToBounds = true//
        //
        let top = UIColor(red: 0.95, green: 0.36, blue: 0.14, alpha: 1).cgColor
        let center = UIColor(red: 0.95, green: 0.27, blue: 0.13, alpha: 1).cgColor
        let bottom = UIColor(red: 0.98, green: 0.39, blue: 0.05, alpha: 1).cgColor
        //
        let btnGradient = CAGradientLayer()
        btnGradient.colors = [top, center,bottom]
        btnGradient.locations = [0.0,0.5,1.0]
        btnGradient.locations = [1, 0, 0]
        self.alpha = 0.8
        //
        btnGradient.frame = self.bounds
        //
        self.layer.cornerRadius = CGFloat(20)
        //
        self.layer.insertSublayer(btnGradient, at: 0)
    }
}

class RoundedButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        let radius: CGFloat = self.bounds.size.height / 2.0
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
}

class ShadowButton : UIButton{
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //
        self.layer.cornerRadius = 2;
        self.layer.borderWidth = 1;
        self.layer.borderColor = UIColor.white.cgColor
        //
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width:5, height: 5)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.8
    }
}

public class BadgeBarButtonItem: UIBarButtonItem
{
    @IBInspectable
    public var badgeValue: Int = 0 {
        didSet {
            self.updateBadge()
        }
    }
    
    private let label: UILabel
    
    required public init?(coder aDecoder: NSCoder)
    {
        let label = UILabel()
        label.font = AppFonts.getAppAttributedFont(.REGULAR, withSize: 11)
        label.backgroundColor = UIColor.red
        label.alpha = 0.9
        label.layer.cornerRadius = 6
        label.clipsToBounds = true
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        label.layer.zPosition = 1
        self.label = label
        
        super.init(coder: aDecoder)
        
        self.addObserver(self, forKeyPath: "view", options: [], context: nil)
    }
    
    override public func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?)
    {
        self.updateBadge()
    }
    
    private func updateBadge()
    {
        guard let view = self.value(forKey: "view") as? UIView else { return }
        
        self.label.text = "\(badgeValue)"
        
        if self.badgeValue > 0 && self.label.superview == nil
        {
            view.addSubview(self.label)
            
            self.label.widthAnchor.constraint(equalToConstant: 14).isActive = true
            self.label.heightAnchor.constraint(equalToConstant: 14).isActive = true
            self.label.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 9).isActive = true
            self.label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -4).isActive = true
        }
        else if self.badgeValue == 0 && self.label.superview != nil
        {
            self.label.removeFromSuperview()
        }
    }
    
    deinit {
        self.removeObserver(self, forKeyPath: "view")
    }
}


@IBDesignable
open class CheckboxButton: UIControl {
    // MARK: Public properties
    
    /// Line width for the check mark. Default value is 2.
    @IBInspectable open var checkLineWidth: CGFloat = 2.0 {
        didSet {
            layoutLayers()
        }
    }
    
    /// Color for the check mark. Default color is `UIColor.blackColor()`.
    @IBInspectable open var checkColor: UIColor = UIColor.black {
        didSet {
            colorLayers()
        }
    }
    
    /// Line width for the bounding container of the check mark.
    /// Default value is 2.
    @IBInspectable open var containerLineWidth: CGFloat = 2.0 {
        didSet {
            layoutLayers()
        }
    }
    
    /// Color for the bounding container of the check mark.
    /// Default color is `UIColor.blackColor()`.
    @IBInspectable open var containerColor: UIColor = UIColor.black {
        didSet {
            colorLayers()
        }
    }
    
    /// If set to `true`, the bounding container of the check mark will be a circle rather than a box.
    /// Default value is false
    @IBInspectable open var circular: Bool = false {
        didSet {
            layoutLayers()
        }
    }
    
    /// If set to `true`, the container gets a fill color similar to the `containerColor` property.
    /// Default value is `false`.
    @IBInspectable open var containerFillsOnToggleOn: Bool = false {
        didSet {
            colorLayers()
        }
    }
    
    /// A Boolean value that determines the off/on state of the checkbox. If `true`, the checkbox is checked.
    @IBInspectable open var on: Bool = false {
        didSet {
            colorLayers()
        }
    }
    
    // MARK: Internal and private properties
    
    internal let containerLayer = CAShapeLayer()
    internal let checkLayer = CAShapeLayer()
    
    internal var containerFrame: CGRect {
        let width = bounds.width
        let height = bounds.height
        
        let x: CGFloat
        let y: CGFloat
        
        let sideLength: CGFloat
        if width > height {
            sideLength = height
            x = (width - sideLength) / 2
            y = 0
        } else {
            sideLength = width
            x = 0
            y = (height - sideLength) / 2
        }
        
        let halfLineWidth = containerLineWidth / 2
        return CGRect(x: x + halfLineWidth, y: y + halfLineWidth, width: sideLength - containerLineWidth, height: sideLength - containerLineWidth)
    }
    
    internal var containerPath: UIBezierPath {
        if circular {
            return UIBezierPath(ovalIn: containerFrame)
        } else {
            return UIBezierPath(rect: containerFrame)
        }
    }
    internal var checkPath: UIBezierPath {
        let containerFrame = self.containerFrame
        
        // Add an offset for circular checkbox
        let inset = containerLineWidth / 2
        let innerRect = containerFrame.insetBy(dx: inset, dy: inset)
        
        // Create check path
        let path = UIBezierPath()
        
        let unit = innerRect.width / 33
        let origin = innerRect.origin
        let x = origin.x
        let y = origin.y
        
        path.move(to: CGPoint(x: x + (7 * unit), y: y + (18 * unit)))
        path.addLine(to: CGPoint(x: x + (14 * unit), y: y + (25 * unit)))
        path.addLine(to: CGPoint(x: x + (27 * unit), y: y + (10 * unit)))
        
        return path
    }
    
    static internal let validBoundsOffset: CGFloat = 80
    
    // MARK: Initialization
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override func awakeFromNib() {
        customInitialization()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        customInitialization()
    }
    
    /**
     Initializes a new `CheckboxButton` with a set state.
     
     - Parameters:
     - frame: Frame of the receiver
     - on: On state of the receiver
     */
    convenience init(frame: CGRect, on: Bool) {
        self.init(frame: frame)
        self.on = on
    }
    
    func customInitialization() {
        // Initial colors
        checkLayer.fillColor = UIColor.clear.cgColor
        
        // Color and layout layers
        colorLayers()
        layoutLayers()
        
        // Add layers
        layer.addSublayer(containerLayer)
        layer.addSublayer(checkLayer)
    }
    
    // MARK: Layout
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        // Also layout the layers when laying out subviews
        layoutLayers()
    }
    
    
    
    // MARK: Layout layers
    fileprivate func layoutLayers() {
        // Set frames, line widths and paths for layers
        containerLayer.frame = bounds
        containerLayer.lineWidth = containerLineWidth
        containerLayer.path = containerPath.cgPath
        
        checkLayer.frame = bounds
        checkLayer.lineWidth = checkLineWidth
        checkLayer.path = checkPath.cgPath
    }
    
    // MARK: Color layers
    fileprivate func colorLayers() {
        containerLayer.strokeColor = containerColor.cgColor
        
        // Set colors based on 'on' property
        if on {
            containerLayer.fillColor = containerFillsOnToggleOn ? containerColor.cgColor : UIColor.clear.cgColor
            checkLayer.strokeColor = checkColor.cgColor
        } else {
            containerLayer.fillColor = UIColor.clear.cgColor
            checkLayer.strokeColor = UIColor.clear.cgColor
        }
    }
    
    // MARK: Touch tracking
    
    open override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        super.beginTracking(touch, with: event)
        
        return true
    }
    
    open override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        super.continueTracking(touch, with: event)
        
        return true
    }
    
    open override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        super.endTracking(touch, with: event)
        
        guard let touchLocationInView = touch?.location(in: self) else {
            return
        }
        
        let offset = type(of: self).validBoundsOffset
        let validBounds = CGRect(x: bounds.origin.x - offset, y: bounds.origin.y - offset, width: bounds.width + (2 * offset), height: bounds.height + (2 * offset))
        
        if validBounds.contains(touchLocationInView) {
            on = !on
            sendActions(for: [UIControl.Event.valueChanged])
        }
    }
    
    // MARK: Interface builder
    open override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        customInitialization()
    }
}

