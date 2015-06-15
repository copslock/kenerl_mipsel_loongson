Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Jun 2015 09:36:09 +0200 (CEST)
Received: from mail-la0-f42.google.com ([209.85.215.42]:34639 "EHLO
        mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007389AbbFOHgG0C70J convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 15 Jun 2015 09:36:06 +0200
Received: by labbc20 with SMTP id bc20so15812991lab.1;
        Mon, 15 Jun 2015 00:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=qTkSUj2p9gUdg6fuNVr+AC2hfNGVDOrFntGbYDSZc6M=;
        b=cJqoAHjhZugd2uBFe5LmRNhwW/Jg2su1t6dQ7dmuKtSMrDUuVigoeN2Bde6pkn3QrD
         x79J5HTINCSMhG3w5pJ3ntPQxurDL0eZwbrH59BLF4wVXdRJN7GVcOsA7ybEfliNKQt7
         jP20D5XFw7I24967Fp67S4n36teTnyXfb9UzIDbFNzI9SUxas1kuhAHVp30TJMGUNKye
         3X08c0VAgdZC2srRZK74HNIXQ7j9C96qM89BFt2Tk9d/tI4MUcbYSgfDsuWg1TpWFXI0
         47GvIIoM3sF0esRGeTr14ihFFwAfwEzoj+66siYmd1amrOUvO24WRWACWd6Uq65kNwzp
         X4Wg==
X-Received: by 10.152.7.206 with SMTP id l14mr25783197laa.3.1434353761088;
        Mon, 15 Jun 2015 00:36:01 -0700 (PDT)
Received: from flare (t35.niisi.ras.ru. [193.232.173.35])
        by mx.google.com with ESMTPSA id o8sm2516959lal.2.2015.06.15.00.35.58
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jun 2015 00:35:59 -0700 (PDT)
Date:   Mon, 15 Jun 2015 10:42:13 +0300
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     Alban <albeu@free.fr>
Cc:     linux-mips@linux-mips.org, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Gabor Juhos <juhosg@openwrt.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 12/12] MIPS: Add basic support for the TL-WR1043ND
 version 1
Message-Id: <20150615104213.92258d2d0616c12e4aa7bf1a@gmail.com>
In-Reply-To: <20150610235811.0b18af9b@tock>
References: <1433029955-7346-1-git-send-email-albeu@free.fr>
        <1433031506-7984-5-git-send-email-albeu@free.fr>
        <20150608131758.9d76be074998ea3de0e976a4@gmail.com>
        <20150610235811.0b18af9b@tock>
X-Mailer: Sylpheed 3.5.0beta1 (GTK+ 2.24.25; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47942
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

On Wed, 10 Jun 2015 23:58:11 +0200
Alban <albeu@free.fr> wrote:

> On Mon, 8 Jun 2015 13:17:58 +0300
> Antony Pavlov <antonynpavlov@gmail.com> wrote:
> 
> > IMHO AR9132 SoC can't work without external oscilator.
> > 
> > Can we just move basic extosc declaration to SoC dt file
> > (ar9132.dtsi)? So board dt file ar9132_tl_wr1043nd_v1.dts will
> > contain only oscilator clock frequency value.
> 
> I would prefer to keep the split between the files in sync with the
> hardware. I understand that most simple board designs use a fixed
> oscillator, but that might not always be the case.
> 

The AR9132 SoC __always__ use one external oscilator. So it's reasonable
to have the first mention of extosc in ar9132.dtsi not in a board file.
This description style is always sync with hardware.
On the other hand pll-controller is always part of the SoC
not a part of a board. So pll-controller on extosc dependency
have to go to SoC dts file not to a board file. In your dts description
pll-controller is a part of a dts board file.

It looks like my previous device tree structure proposal contains a small error
(extra clock-frequency field in ar9132.dtsi). I have fixed it. Please comment it.

ar9132.dtsi:
============

	extosc: oscillator {
		compatible = "fixed-clock";
		#clock-cells = <0>;
	};
...
	ahb {
		apb {

...

			pll-controller@18050000 {
...
				clocks = <&extosc>;
...



ar9132_tl_wr1043nd_v1.dts:
==========================

...
	&extosc {
		clock-frequency = <40000000>;
	};


-- 
-- 
Best regards,
  Antony Pavlov
