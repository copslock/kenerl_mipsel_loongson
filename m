Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Jun 2015 12:12:03 +0200 (CEST)
Received: from mail-lb0-f174.google.com ([209.85.217.174]:33833 "EHLO
        mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007675AbbFHKMCJsw6I convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 8 Jun 2015 12:12:02 +0200
Received: by lbcmx3 with SMTP id mx3so77422503lbc.1;
        Mon, 08 Jun 2015 03:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=u4fAxx9h4dRiRSztcMb2Qju7+AL4l0kUZdhnooLTFsc=;
        b=SlBLgf455vsCeGyLJfJX//VsXwgATJZfGnh2VhB2gVK5YJ5ywsWZZ6DAmCndoOmyT+
         m9M1/3KT6u1sJJaWzVl2kbQANbk3sjnWr3uHl3ec9vWkx5l7/B2VYylRlftNKcaDEdiv
         0LDVW30jPychwJmzaAUC+jMsJ8EU4eiYh0OM0PbBCJlEtV01zdLB2CT9nJ1vT0IfO6C5
         OoRZX+9qynqaLpEVyuVzXzrcPnB7bgIComhp3j58K9DEoRgTu7Y6vuMnHnoTDfYq6GXp
         9WQTME6m9seRW7xiSPmjAkU1ImbhIMNPWDY+G1+IR+ChHjt0yLD2tsgeig4lb9d8NIb6
         81Yw==
X-Received: by 10.152.88.99 with SMTP id bf3mr15543431lab.97.1433758316693;
        Mon, 08 Jun 2015 03:11:56 -0700 (PDT)
Received: from flare (t35.niisi.ras.ru. [193.232.173.35])
        by mx.google.com with ESMTPSA id yc3sm540489lbb.6.2015.06.08.03.11.54
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jun 2015 03:11:55 -0700 (PDT)
Date:   Mon, 8 Jun 2015 13:17:58 +0300
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     Alban Bedel <albeu@free.fr>
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
Message-Id: <20150608131758.9d76be074998ea3de0e976a4@gmail.com>
In-Reply-To: <1433031506-7984-5-git-send-email-albeu@free.fr>
References: <1433029955-7346-1-git-send-email-albeu@free.fr>
        <1433031506-7984-5-git-send-email-albeu@free.fr>
X-Mailer: Sylpheed 3.5.0beta1 (GTK+ 2.24.25; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47903
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

On Sun, 31 May 2015 02:18:26 +0200
Alban Bedel <albeu@free.fr> wrote:

> Add a DTS for TL-WR1043ND version 1 and allow to have it built in the
> kernel to circumvent the broken u-boot found on these boards.
> Currently only the UART, LEDs and buttons are supported.
> 
> Signed-off-by: Alban Bedel <albeu@free.fr>

> --- /dev/null
> +++ b/arch/mips/boot/dts/qca/ar9132.dtsi


> +++ b/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
> @@ -0,0 +1,112 @@
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +
> +#include "ar9132.dtsi"
> +
> +/ {
> +	compatible = "tplink,tl-wr1043nd-v1", "qca,ar9132";
> +	model = "TP-Link TL-WR1043ND Version 1";
> +
> +	alias {
> +		serial0 = "/ahb/apb/uart@18020000";
> +	};
> +
> +	memory@0 {
> +		device_type = "memory";
> +		reg = <0x0 0x2000000>;
> +	};
> +
> +	extosc: oscillator {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <40000000>;
> +	};
> +
> +	ahb {
> +		apb {
> +			uart@18020000 {
> +				status = "okay";
> +			};
> +
> +			pll-controller@18050000 {
> +				clocks = <&extosc>;

IMHO AR9132 SoC can't work without external oscilator.

Can we just move basic extosc declaration to SoC dt file (ar9132.dtsi)?
So board dt file ar9132_tl_wr1043nd_v1.dts will contain only oscilator
clock frequency value.

E.g.

ar9132.dtsi:
============

	extosc: oscillator {
		compatible = "fixed-clock";
		#clock-cells = <0>;
		clock-frequency = <40000000>;
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
Best regards,
  Antony Pavlov
