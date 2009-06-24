Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jun 2009 22:22:07 +0200 (CEST)
Received: from mail-bw0-f225.google.com ([209.85.218.225]:60698 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493217AbZFXUWA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 24 Jun 2009 22:22:00 +0200
Received: by bwz25 with SMTP id 25so1148246bwz.0
        for <multiple recipients>; Wed, 24 Jun 2009 13:18:25 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=vVVOc56u+bbDs1VavmDDpOH4rFIEmkKmI1MhxkOv7EI=;
        b=TClSte4wGR88vMeCjjcQZxXaOliTyIeT96ThD733CELh0baPO/bt5EZjGoxYyCAzJu
         vmufnVMruFo4ENLimVebmdjRU7ZYGWKqM5soH+dtaIns3jMTGwLtnf372P4Y3C/+S48N
         2+1nfIF9c4aABUF02L3jK7es5NEGUbnSyzC6w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=qzsafpTrOsx67KOVeboJ8jyE6H6t2jspnXZtc5T3TyxYni+1BHgVI+2KVM0ey6BYSq
         k5HtQETIdbBk3kcCzsyp36Yk0fTBT/sYVj7VtiEUMruCVh9HS2zy6sEB0hmV7Wh1BKot
         oATNaAHkq+cltv/+q/bz7hGephk85cBsRfIow=
Received: by 10.103.227.10 with SMTP id e10mr1013567mur.65.1245874705698;
        Wed, 24 Jun 2009 13:18:25 -0700 (PDT)
Received: from flowlan.maisel.int-evry.fr ([157.159.47.25])
        by mx.google.com with ESMTPS id 23sm7468370mun.46.2009.06.24.13.18.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Jun 2009 13:18:24 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 5/8] add Texas Instruments AR7 support
Date:	Wed, 24 Jun 2009 22:18:13 +0200
User-Agent: KMail/1.9.9
Cc:	Alexander Clouter <alex@digriz.org.uk>, linux-mips@linux-mips.org
References: <200906041619.25359.florian@openwrt.org> <o8f9h6-v4l.ln1@woodchuck.wormnet.eu> <20090624122347.GA28583@linux-mips.org>
In-Reply-To: <20090624122347.GA28583@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200906242218.13794.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23491
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Le Wednesday 24 June 2009 14:23:47 Ralf Baechle, vous avez écrit :
> On Wed, Jun 24, 2009 at 12:28:56PM +0100, Alexander Clouter wrote:
> > Florian Fainelli <florian@openwrt.org> wrote:
> > > Le Tuesday 23 June 2009 20:15:09 Ralf Baechle, vous avez écrit :
> > >> On Tue, Jun 23, 2009 at 11:28:27AM +0200, Florian Fainelli wrote:
> > >>
> > >> AR7 time again - the platform pending longest ...  Let's see:
> > >
> > > Thank you very much for your comments Ralf, please find below an
> > > updated version which addresses all of your comments. I hope this time
> > > we are going to make it ;)
> >
> > I am hoping someone can have a tackle of the lzma/bzip2 kernel/initramfs
> > generic compression code myself, but I guess one thing at a time. :)  If
> > you have a simple way for me to produce a LZMA'd image, I'll test it
> > this on my WAG54Gv2 (I need the image to be less than 700kB).
> >
> > My comments, for what they are worth, below:
> > > From: Florian Fainelli <florian@openwrt.org>
> > > Subject: Add support for Texas Instruments AR7 System-on-a-Chip
> > >
> > > This patch adds support for the Texas Instruments AR7 System-on-a-Chip.
> > > It supports the TNETD7100, 7200 and 7300 versions of the SoC.
> > >
> > > Changes from v4:
> > > [snipped]
> > >
> > > Signed-off-by: Matteo Croce <matteo@openwrt.org>
> > > Signed-off-by: Felix Fietkau <nbd@openwrt.org>
> > > Signed-off-by: Eugene Konev <ejka@openwrt.org>
> > > Signed-off-by: Nicolas Thill <nico@openwrt.org>
> > > Signed-off-by: Florian Fainelli <florian@openwrt.org>
> > > --
> > > [snipped]
> > >
> > > diff --git a/arch/mips/ar7/clock.c b/arch/mips/ar7/clock.c
> > > new file mode 100644
> > > index 0000000..7ce5f07
> > > --- /dev/null
> > > +++ b/arch/mips/ar7/clock.c
> > > @@ -0,0 +1,450 @@
> > > [snipped]
> > > +static void __init tnetd7300_init_clocks(void)
> > > +{
> > > +       u32 *bootcr = (u32 *)ioremap_nocache(AR7_REGS_DCL, 4);
> > > +       struct tnetd7300_clocks *clocks =
> > > +                                       (struct tnetd7300_clocks *)
> > > +                                       ioremap_nocache(AR7_REGS_POWER
> > > + 0x20, +                                       sizeof(struct
> > > tnetd7300_clocks)); +
> >
> > Needless cast'ing and also should you not check that NULL is not
> > returned for both of these ioremap's?
>
> That's because we "know" it can't ever fail for addresses < 0x20000000.
> Downside - sparse will bitch about it.
>
> But yes, the cast indeed is unnecessary.

Incremental patch on top of the one you already have below.
--
From: Florian Fainelli <florian@openwrt.org>
Subject: clean up AR7 code

This patch cleans up the code and is incremental to version 5
of patch previously sent which adds AR7 support.

- uneeded casts on ioremaps in clock.c
- define AR7_REGS_CLOCKS/UR8_REGS_CLOCKS for consistency
- remove useless nops and use busy-waiting on the pll status register
- remove commented out usb clock setting for TNETD7300
- simplify ar7_init_clocks
- return -ENXIO for unknown chips in ar7_has_high_cpmac
- remove forward declarations of functions in setup.c

Signed-off-by: Florian Fainelli <florian@openwrt.org>
--
diff --git a/arch/mips/ar7/clock.c b/arch/mips/ar7/clock.c
index 7ce5f07..b8c7c84 100644
--- a/arch/mips/ar7/clock.c
+++ b/arch/mips/ar7/clock.c
@@ -244,8 +244,7 @@ static void __init tnetd7300_init_clocks(void)
 {
 	u32 *bootcr = (u32 *)ioremap_nocache(AR7_REGS_DCL, 4);
 	struct tnetd7300_clocks *clocks =
-					(struct tnetd7300_clocks *)
-					ioremap_nocache(AR7_REGS_POWER + 0x20,
+					ioremap_nocache(UR8_REGS_CLOCKS,
 					sizeof(struct tnetd7300_clocks));
 
 	ar7_bus_clock = tnetd7300_get_clock(BUS_PLL_SOURCE_SHIFT,
@@ -256,10 +255,7 @@ static void __init tnetd7300_init_clocks(void)
 			&clocks->cpu, bootcr, AR7_AFE_CLOCK);
 	else
 		ar7_cpu_clock = ar7_bus_clock;
-/*
-	tnetd7300_set_clock(USB_PLL_SOURCE_SHIFT, &clocks->usb,
-		bootcr, 48000000);
-*/
+	
 	if (ar7_dsp_clock == 250000000)
 		tnetd7300_set_clock(DSP_PLL_SOURCE_SHIFT, &clocks->dsp,
 			bootcr, ar7_dsp_clock);
@@ -293,9 +289,6 @@ static void tnetd7200_set_clock(int base, struct tnetd7200_clock *clock,
 	writel(DIVISOR_ENABLE_MASK | ((prediv - 1) & 0x1F), &clock->prediv);
 	writel((mul - 1) & 0xF, &clock->mul);
 
-	for (mul = 0; mul < 2000; mul++)
-		; /* nop */
-
 	while (readl(&clock->status) & 0x1)
 		; /* nop */
 
@@ -348,8 +341,7 @@ static void __init tnetd7200_init_clocks(void)
 {
 	u32 *bootcr = (u32 *)ioremap_nocache(AR7_REGS_DCL, 4);
 	struct tnetd7200_clocks *clocks =
-					(struct tnetd7200_clocks *)
-					ioremap_nocache(AR7_REGS_POWER + 0x80,
+					ioremap_nocache(AR7_REGS_CLOCKS,
 					sizeof(struct tnetd7200_clocks));
 	int cpu_base, cpu_mul, cpu_prediv, cpu_postdiv;
 	int dsp_base, dsp_mul, dsp_prediv, dsp_postdiv;
@@ -432,8 +424,6 @@ int __init ar7_init_clocks(void)
 {
 	switch (ar7_chip_id()) {
 	case AR7_CHIP_7100:
-		tnetd7200_init_clocks();
-		break;
 	case AR7_CHIP_7200:
 		tnetd7200_init_clocks();
 		break;
diff --git a/arch/mips/ar7/setup.c b/arch/mips/ar7/setup.c
index cccb484..6ebb5f1 100644
--- a/arch/mips/ar7/setup.c
+++ b/arch/mips/ar7/setup.c
@@ -25,10 +25,6 @@
 #include <asm/mach-ar7/ar7.h>
 #include <asm/mach-ar7/prom.h>
 
-static void ar7_machine_restart(char *command);
-static void ar7_machine_halt(void);
-static void ar7_machine_power_off(void);
-
 static void ar7_machine_restart(char *command)
 {
 	u32 *softres_reg = ioremap(AR7_REGS_RESET +
diff --git a/arch/mips/include/asm/mach-ar7/ar7.h b/arch/mips/include/asm/mach-ar7/ar7.h
index 4ebe2c6..de71694 100644
--- a/arch/mips/include/asm/mach-ar7/ar7.h
+++ b/arch/mips/include/asm/mach-ar7/ar7.h
@@ -21,8 +21,10 @@
 #define __AR7_H__
 
 #include <linux/delay.h>
-#include <asm/addrspace.h>
 #include <linux/io.h>
+#include <linux/errno.h>
+
+#include <asm/addrspace.h>
 
 #define AR7_SDRAM_BASE	0x14000000
 
@@ -32,6 +34,8 @@
 #define AR7_REGS_GPIO	(AR7_REGS_BASE + 0x0900)
 /* 0x08610A00 - 0x08610BFF (512 bytes, 128 bytes / clock) */
 #define AR7_REGS_POWER	(AR7_REGS_BASE + 0x0a00)
+#define AR7_REGS_CLOCKS (AR7_REGS_POWER + 0x80)
+#define UR8_REGS_CLOCKS (AR7_REGS_POWER + 0x20)
 #define AR7_REGS_UART0	(AR7_REGS_BASE + 0x0e00)
 #define AR7_REGS_USB	(AR7_REGS_BASE + 0x1200)
 #define AR7_REGS_RESET	(AR7_REGS_BASE + 0x1600)
@@ -126,8 +130,10 @@ static inline int ar7_has_high_cpmac(void)
 	case AR7_CHIP_7100:
 	case AR7_CHIP_7200:
 		return 0;
-	default:
+	case AR7_CHIP_7300:
 		return 1;
+	default:
+		return -ENXIO;
 	}
 }
 #define ar7_has_high_vlynq ar7_has_high_cpmac
