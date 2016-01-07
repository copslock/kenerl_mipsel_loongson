Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jan 2016 18:34:02 +0100 (CET)
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34866 "EHLO
        mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014165AbcAGReA0IMXe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Jan 2016 18:34:00 +0100
Received: by mail-pa0-f53.google.com with SMTP id ho8so2834210pac.2;
        Thu, 07 Jan 2016 09:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=9MpknYvan+13/PlZrolziZrfqDwQzwuvGj7fHIk6bNU=;
        b=f3SqA6UFBAyylmIU4lGqK4O9iSgDO3ytDDtfLz7TZkWdbHoo2/5zOEhBgOSFP/bmhX
         NII84R4RJzcoUHFzMvQRBV4faePDi0O3X2iGJOrJU9w1Kwzqr2TO/+6JLiU+tJrct1Af
         y4vHUkz4tdDbszoWzfElDovmtXzfcJx8C74Jl7qYWNQYtl+y7NL1HDDTf46NralXqxMm
         SYTHSwLaaTCwAQ9UOCJtppBrpGjCzhvhcMYnx4TdBgIkEUGQ807LddtEvkXOZdNihhQj
         0JDRHy4hpj7cuXzIyI3RCDIdP72BoXKe14AUZ3xnX709PJLiy2ox5Hf3XgD04/l71XmJ
         yP9Q==
X-Received: by 10.66.190.7 with SMTP id gm7mr93830085pac.79.1452188033360;
        Thu, 07 Jan 2016 09:33:53 -0800 (PST)
Received: from google.com ([2620:0:1000:1301:a0c7:6a2c:8427:c983])
        by smtp.gmail.com with ESMTPSA id kk5sm143649137pab.16.2016.01.07.09.33.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 07 Jan 2016 09:33:52 -0800 (PST)
Date:   Thu, 7 Jan 2016 09:33:50 -0800
From:   Brian Norris <computersforpeace@gmail.com>
To:     Harvey Hunt <harvey.hunt@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mtd@lists.infradead.org, boris.brezillon@free-electrons.com,
        alex@alex-smith.me.uk, Alex Smith <alex.smith@imgtec.com>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Paul Burton <paul.burton@imgtec.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, robh@kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v11 3/3] MIPS: dts: jz4780/ci20: Add NEMC, BCH and NAND
 device tree nodes
Message-ID: <20160107173350.GF109450@google.com>
References: <1451910884-18710-1-git-send-email-harvey.hunt@imgtec.com>
 <1451910884-18710-4-git-send-email-harvey.hunt@imgtec.com>
 <20160107012903.GX109450@google.com>
 <568E327D.8040905@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <568E327D.8040905@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <computersforpeace@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50962
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: computersforpeace@gmail.com
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

Hi Harvey + Ralf,

On Thu, Jan 07, 2016 at 09:40:13AM +0000, Harvey Hunt wrote:
> On 07/01/16 01:29, Brian Norris wrote:
> >On Mon, Jan 04, 2016 at 12:34:44PM +0000, Harvey Hunt wrote:
> >>diff --git a/arch/mips/boot/dts/ingenic/ci20.dts b/arch/mips/boot/dts/ingenic/ci20.dts
> >>index 9fcb9e7..782258c 100644
> >>--- a/arch/mips/boot/dts/ingenic/ci20.dts
> >>+++ b/arch/mips/boot/dts/ingenic/ci20.dts
> >
> >As I noted on patch 1, you need to send this to linux-mips + Ralf.
> 
> I forgot to CC Ralf on this version, but he took v9 (no change
> between v9 and v11) through linux-mips as can be seen here:
> http://patchwork.linux-mips.org/patch/11695/

OK.

> >>@@ -42,3 +42,66 @@
> >>  &uart4 {
> >>  	status = "okay";
> >>  };
> >>+
> >>+&nemc {
> >>+	status = "okay";
> >>+
> >>+	nandc: nand-controller@1 {
> >>+		compatible = "ingenic,jz4780-nand";
> >>+		reg = <1 0 0x1000000>;
> >>+
> >>+		#address-cells = <1>;
> >>+		#size-cells = <0>;
> >>+
> >>+		ingenic,bch-controller = <&bch>;
> >>+
> >>+		ingenic,nemc-tAS = <10>;
> >>+		ingenic,nemc-tAH = <5>;
> >>+		ingenic,nemc-tBP = <10>;
> >>+		ingenic,nemc-tAW = <15>;
> >>+		ingenic,nemc-tSTRV = <100>;
> >>+
> >>+		nand@1 {
> >>+			reg = <1>;
> >>+
> >>+			nand-ecc-step-size = <1024>;
> >>+			nand-ecc-strength = <24>;
> >>+			nand-ecc-mode = "hw";
> >>+			nand-on-flash-bbt;
> >>+
> >>+			partitions {
> >>+				#address-cells = <2>;
> >>+				#size-cells = <2>;
> >
> >This binding was updated, so you need:
> >
> >				compatible = "fixed-partitions";
> 
> This has been fixed in mips-linux here:
> http://patchwork.linux-mips.org/patch/11914/

Ralf: it looks like you applied the DTS changes twice, essentially.
Might want to fix that:

[From arch/mips/boot/dts/ingenic/ci20.dts]
...
&nemc {
	...
	nandc: nand-controller@1 {
		...
		nand@1 {
			...
			partitions {
				compatible = "fixed-partitions";
				...
			};
		};
	};
};

&bch {
	status = "okay";
};

&nemc {
	...
	nandc: nand-controller@1 {
		...
		nand@1 {
			...
			partitions {
				...
			};
		};
	};
};

&bch {
	status = "okay";
};


Brian
