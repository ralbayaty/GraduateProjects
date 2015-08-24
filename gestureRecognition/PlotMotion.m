function [ ] = PlotMotion( motion,new,name )

    if new == 1
        figure()
    end
                subplot(1,2,1)
            hold on
            plot(motion.Ax,'r-.');
            plot(motion.Ay,'g');
            plot(motion.Az,'k--');
            hold off
            title([name ': Acceleration'])
            legend('Ax','Ay','Az')
                subplot(1,2,2)
            hold on
            plot(motion.Gx,'r-.');
            plot(motion.Gy,'g');
            plot(motion.Gz,'k--');
            hold off
            title([name ': Angular Velocity'])
            legend('Gx','Gy','Gz')
            
end