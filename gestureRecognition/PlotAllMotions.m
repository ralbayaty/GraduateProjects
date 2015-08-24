function [ ] = PlotAllMotions( motion1,motion2,motion3,motion4,motion5 )

        figure()
        hold on
        PlotMotion( motion1,0 )
        PlotMotion( motion2,0 )
        PlotMotion( motion3,0 )
        PlotMotion( motion4,0 )
        PlotMotion( motion5,0 )

        hold off


end