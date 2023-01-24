function save_fig(sig, m, R_START, R_INCREMENT, R_END)
  %disp(sig);
    plot(R_START : R_INCREMENT : R_END, sig, 'b-s')
    xlabel('r', 'FontSize', 12, 'FontWeight','bold')
    ylabel('SampEn', 'FontSize', 12, 'FontWeight','bold')
    title(strcat("M = ", int2str(m)))
    saveas(gcf, strcat("../results/sig_m", int2str(m) ,".png"));
end

