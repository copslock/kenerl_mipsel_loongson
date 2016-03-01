Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Mar 2016 14:09:21 +0100 (CET)
Received: from down.free-electrons.com ([37.187.137.238]:38577 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27007534AbcCANJTPXoEL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Mar 2016 14:09:19 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 899A525B; Tue,  1 Mar 2016 14:09:12 +0100 (CET)
Received: from localhost (unknown [88.191.26.124])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 401A31C2;
        Tue,  1 Mar 2016 14:09:12 +0100 (CET)
Date:   Tue, 1 Mar 2016 14:09:12 +0100
From:   Alexandre Belloni <alexandre.belloni@free-electrons.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Yoichi Yuasa <yuasa@linux-mips.org>,
        John Stultz <john.stultz@linaro.org>,
        rtc-linux@googlegroups.com, linux-mips@linux-mips.org
Subject: Re: [PATCH/RFT] rtc: rtc-vr41xx: Wire up alarm_irq_enable
Message-ID: <20160301130912.GH2627@piout.net>
References: <1456822201-12408-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1456822201-12408-1-git-send-email-geert@linux-m68k.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <alexandre.belloni@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52383
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexandre.belloni@free-electrons.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On 01/03/2016 at 09:50:01 +0100, Geert Uytterhoeven wrote :
> drivers/rtc/rtc-vr41xx.c:229: warning: ‘vr41xx_rtc_alarm_irq_enable’ defined but not used
> 
> Apparently the conversion to alarm_irq_enable forgot to wire up the
> callback.
> 
> Fixes: 16380c153a69c378 ("RTC: Convert rtc drivers to use the alarm_irq_enable method")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
