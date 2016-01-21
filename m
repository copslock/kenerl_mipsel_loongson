Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Jan 2016 10:52:11 +0100 (CET)
Received: from mail-lf0-f49.google.com ([209.85.215.49]:36776 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008977AbcAUJwKT2t0s convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 21 Jan 2016 10:52:10 +0100
Received: by mail-lf0-f49.google.com with SMTP id h129so23305068lfh.3
        for <linux-mips@linux-mips.org>; Thu, 21 Jan 2016 01:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=KS+9G6uLO6ALDBys3YHVBG11T4AnsPACQFeme73CN90=;
        b=GjMXWChYv0XELHzdd2DAsSVst14xCejoowBJVFKPGwhmyRtCLYE69E0tjU86iiWlkD
         TK3CW2ahZKXU3kde1uN31jiWZtL0UjHCjveoer/YlKT8P+YrwAFhVMr+UamZCvckUgrK
         CU9WxgSO4hgUEu2fmEt5GgmGQDgLXBI1MbPya7CvMpxo3Co5goVZS22zlo7NojU7oDDS
         nik3SjFuFzDpidrWJ2HZFP5BoTavj5vEEiNEbLU2jzvYU2gxOhJg4vy8QlI3GcouE6B8
         QkJkbGDbYzy9+blZecwFHr5ZCt8Eu9cvjrWbW9/NRDLfjHgQzOPKx0kKYTjq/PzIyMYh
         Ra9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=KS+9G6uLO6ALDBys3YHVBG11T4AnsPACQFeme73CN90=;
        b=UBNXQ1owgG1cmrONf1DpPyTXsIu7n9mO3lUuG1VBYNuL/svrXdQ3GazvYkM3Na0VD6
         B0G7E4rylewuKCJ5U+UOy2bolIWqG9YRN+2y1BTqMtrMjmUVRVT10BwubHeAgt/JHH7W
         aFTaVVuGtZtCRG5QiYO7D1AYwaa/8xV4fiPivl9M5Z7zOm1UkMrujUx5XwruwX6IFyTI
         d4WXOlP5ojtQDsvvbog6Y4OXi/ZIPldbWElEd0M0ZbXVQm6i2cnukYfdpare1EIcVfNc
         uGTf/ZxPTiNIySsOLvJ9ID7HpgoA8IAynkAV+34Qlu1i878rvj1fO6JpQYV8I0luyInZ
         wiNQ==
X-Gm-Message-State: ALoCoQm7SbfYjpUjPfnKpAhl+CcQdytvBFl5gkDSvYN2Rfng/F1wxLIJmK67bvYua7EMyDpEe1kzdbxnpcmyQk2LllT2jtEN3Q==
X-Received: by 10.25.18.162 with SMTP id 34mr13502058lfs.52.1453369924914;
        Thu, 21 Jan 2016 01:52:04 -0800 (PST)
Received: from flare (t35.niisi.ras.ru. [193.232.173.35])
        by smtp.gmail.com with ESMTPSA id ei4sm79206lbb.18.2016.01.21.01.52.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 21 Jan 2016 01:52:04 -0800 (PST)
Date:   Thu, 21 Jan 2016 13:17:11 +0300
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     Alban <albeu@free.fr>
Cc:     linux-mips@linux-mips.org,
        Yegor Yefremov <yegorslists@googlemail.com>,
        Gabor Juhos <juhosg@openwrt.org>, devicetree@vger.kernel.org
Subject: Re: [RFC 1/4] WIP: MIPS: ath79: make ar933x clks more
 devicetree-friendly
Message-Id: <20160121131711.a7315d3ca6233e50ec824544@gmail.com>
In-Reply-To: <20160121091217.379b6239@tock>
References: <1453074987-3356-1-git-send-email-antonynpavlov@gmail.com>
        <1453074987-3356-2-git-send-email-antonynpavlov@gmail.com>
        <20160118205725.0a16be8e@tock>
        <20160121031215.250b826347fd9c179b031288@gmail.com>
        <20160121091217.379b6239@tock>
X-Mailer: Sylpheed 3.5.0beta3 (GTK+ 2.24.25; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51267
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
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

On Thu, 21 Jan 2016 09:12:17 +0100
Alban <albeu@free.fr> wrote:

> On Thu, 21 Jan 2016 03:12:15 +0300
> Antony Pavlov <antonynpavlov@gmail.com> wrote:
> 
> > On Mon, 18 Jan 2016 20:57:25 +0100
> > Alban <albeu@free.fr> wrote:
> > 
> > > On Mon, 18 Jan 2016 02:56:24 +0300
> > > Antony Pavlov <antonynpavlov@gmail.com> wrote:
> > > 
> > > > At the moment ar933x of-enabled drivers use use clock names
> > > > (e.g. "uart" or "ahb") to get clk descriptor.
> > > > On the other hand
> > > > Documentation/devicetree/bindings/clock/clock-bindings.txt states
> > > > that the 'clocks' property is required for passing clk to clock
> > > > consumers.
> > > 
> > > This patch is not need, you should set the clock-names property in
> > > the relevant device nodes instead.
> > 
> > This patch is needed for AR9331!
> > 
> > In ar933x_clocks_init() we have
> > 
> >         ath79_add_sys_clkdev("ref", ref_rate);
> >         clks[0] = ath79_add_sys_clkdev("cpu", cpu_rate);
> >         clks[1] = ath79_add_sys_clkdev("ddr", ddr_rate);
> >         clks[2] = ath79_add_sys_clkdev("ahb", ahb_rate);
> > 
> >         clk_add_alias("wdt", NULL, "ahb", NULL);
> >         clk_add_alias("uart", NULL, "ref", NULL);
> > 
> > "uart" is an alias for "ref". But "ref" is not visible via device tree!
> > 
> > I see this error message on ar933x-uart start:
> >  
> >      ERROR: could not get clock /ahb/apb/uart@18020000:uart(0)
> 
> The ref clock should be defined in the board DTS, I now see that it is
> missing in yours. What you need to do is to define the clock-names
> property in the Soc DTS, that allow the names lookup to work. Then in
> the board DTS you can define the clock property to connect it to the
> proper parent. 
> 
> I'm also working on supporting the QCA9558 and the clock tree is similar.
> See https://github.com/AlbanBedel/linux/commit/d6c8f8adfce08972c6
> as example.

Current ath79 clock.c code does not read ref clock from devicetree!
So you can set any clock rate value in board DTS but it will has no effect
on the real clk calculation.

A more reasonable solution is used for CI20 board.
In arch/mips/boot/dts/ingenic/jz4780.dtsi we have

	ext: ext {
		compatible = "fixed-clock";
		#clock-cells = <0>;
	};

...

	cgu: jz4780-cgu@10000000 {
		compatible = "ingenic,jz4780-cgu";
		reg = <0x10000000 0x100>;

		clocks = <&ext>, <&rtc>;
		clock-names = "ext", "rtc";

		#clock-cells = <1>;
	};


In arch/mips/boot/dts/ingenic/ci20.dts we have

&ext {
	clock-frequency = <48000000>;
};

At last drivers/clk/ingenic/jz4780-cgu.c registers this "ext" clock
as a parent of most other subordianate clocks. So there is no magic
frequency constants in drivers/clk/ingenic!

In arch/mips/ath79/clocks.c we have a very different situation:
the reference clock frequences are already hardcoded in C-code so there is
no need to mention them in devicetree files.

-- 
Best regards,
  Antony Pavlov
