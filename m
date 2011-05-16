Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 May 2011 11:37:02 +0200 (CEST)
Received: from astoria.ccjclearline.com ([64.235.106.9]:42396 "EHLO
        astoria.ccjclearline.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490990Ab1EPJg7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 May 2011 11:36:59 +0200
Received: from 173.221.84.2.nw.nuvox.net ([173.221.84.2] helo=crashcourse.ca)
        by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.69)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1QLuEM-00012v-63; Mon, 16 May 2011 05:36:50 -0400
Date:   Mon, 16 May 2011 05:36:46 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost6.localdomain6
To:     Florian Fainelli <florian@openwrt.org>
cc:     linux-mips@linux-mips.org
Subject: Re: reference to non-existent CONFIG_HAVE_GPIO_LIB variable?
In-Reply-To: <201105161023.33072.florian@openwrt.org>
Message-ID: <alpine.DEB.2.00.1105160533590.7414@localhost6.localdomain6>
References: <alpine.DEB.2.00.1105141904410.13343@localhost6.localdomain6> <201105161023.33072.florian@openwrt.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - astoria.ccjclearline.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <rpjday@crashcourse.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30034
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rpjday@crashcourse.ca
Precedence: bulk
X-list: linux-mips

On Mon, 16 May 2011, Florian Fainelli wrote:

> Hello,
>
> On Sunday 15 May 2011 01:05:58 Robert P. J. Day wrote:
> >   the current kernel source contains a Makefile reference to the above
> > Kconfig variable that does not appear to be defined anywhere.
>
> It would help if you mention which Makefile references this Kconfig
> variable along with the changeset which introduced it.

  quite so, my bad.  here's the changeset:

$ git show 9fa32c6b
commit 9fa32c6b0275ab1e8b19f74fbfa3ed8411345db6
Author: Patrick Glass <patrickglass@gmail.com>
Date:   Mon Aug 18 14:41:30 2008 -0700

    MIPS: PMC MSP71XX gpio drivers

    This new gpio driver for PMC-Sierra's MSP71xx SoC allows
    standard api calls for access to the general and extended
    gpio's.

    Signed-off-by: Patrick Glass <patrickglass@gmail.com>
    Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

     create mode 100755 arch/mips/pmc-sierra/msp71xx/gpio.c
     create mode 100755 arch/mips/pmc-sierra/msp71xx/gpio_extended.c
     create mode 100755 include/asm-mips/pmc-sierra/msp71xx/gpio.h

diff --git a/arch/mips/pmc-sierra/msp71xx/Makefile
b/arch/mips/pmc-sierra/msp71xx/Make
index 4bba79c..e107f79 100644
--- a/arch/mips/pmc-sierra/msp71xx/Makefile
+++ b/arch/mips/pmc-sierra/msp71xx/Makefile
@@ -3,6 +3,7 @@
 #
 obj-y += msp_prom.o msp_setup.o msp_irq.o \
         msp_time.o msp_serial.o msp_elb.o
+obj-$(CONFIG_HAVE_GPIO_LIB) += gpio.o gpio_extended.o
 obj-$(CONFIG_PMC_MSP7120_GW) += msp_hwbutton.o
 obj-$(CONFIG_IRQ_MSP_SLP) += msp_irq_slp.o
 obj-$(CONFIG_IRQ_MSP_CIC) += msp_irq_cic.o
... etc etc ...

  but there is no Kconfig file that defines the HAVE_GPIO_LIB variable
that i can see.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
