Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Mar 2004 17:49:00 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:10224 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225219AbUCORs6>;
	Mon, 15 Mar 2004 17:48:58 +0000
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id JAA22517;
	Mon, 15 Mar 2004 09:48:54 -0800
Subject: Re: zboot patch and linux_2_4 branch [was Re: Linux Boot Issue in
	Au1550]
From: Pete Popov <ppopov@mvista.com>
To: Tahoma Toelkes <tahoma@nshore.com>
Cc: Linux MIPS mailing list <linux-mips@linux-mips.org>,
	Dan Malek <dan@embeddededge.com>
In-Reply-To: <405232DB.5050902@nshore.com>
References: <20040312074402.6BE522B2B58@ws5-7.us4.outblaze.com>
	 <4051D48F.5080300@embeddededge.com>  <405232DB.5050902@nshore.com>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1079372993.10407.11.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 15 Mar 2004 09:49:53 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4538
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

On Fri, 2004-03-12 at 13:59, Tahoma Toelkes wrote:
> Dan Malek wrote:
> 
> > You will have to get the sources from linux-mips.org cvs,
> > using the linux_2_4 tag.  From 
> > ftp.linux-mips.org:/pub/linux/mips/people/ppopov/2.4
> > get and apply the usb-nonpci-2.4.24.patch and zboot-2.4.25.patch
> 
> I'm having problems applying the zboot patch to the latest and greatest 
> from the linux_2_4 branch ("cvs checkout -r linux_2_4 -D 2004-03-12 
> linux").  When I try to apply the zboot patch, it rejects the chunk for 
> 'arch/mips/Makefile'.  However, upon inspection, I am unable to 
> determine why it isn't happy with the patch.  Any suggestions?

It's not happy because the Makefile has changed since the zboot patch
was last updated. Below is the reject. You can take the "+" lines and
manually insert them in the Makefile or wait until Dan or I update the
patch.

Pete


***************
*** 724,738 ****
  endif

  MAKEBOOT = $(MAKE) -C arch/$(ARCH)/boot

  vmlinux.ecoff: vmlinux
        @$(MAKEBOOT) $@

  vmlinux.srec: vmlinux
        @$(MAKEBOOT) $@

  archclean:
        @$(MAKEBOOT) clean
        rm -f arch/$(ARCH)/ld.script
        $(MAKE) -C arch/$(ARCH)/tools clean
        $(MAKE) -C arch/mips/baget clean
--- 724,744 ----
  endif

  MAKEBOOT = $(MAKE) -C arch/$(ARCH)/boot
+ MAKEZBOOT = $(MAKE) -C arch/$(ARCH)/zboot
+ BOOT_TARGETS = zImage zImage.initrd zImage.flash

  vmlinux.ecoff: vmlinux
        @$(MAKEBOOT) $@

+  $(BOOT_TARGETS): vmlinux
+       @$(MAKEZBOOT) $@
+ 
  vmlinux.srec: vmlinux
        @$(MAKEBOOT) $@

  archclean:
        @$(MAKEBOOT) clean
+       @$(MAKEZBOOT) clean
        rm -f arch/$(ARCH)/ld.script
        $(MAKE) -C arch/$(ARCH)/tools clean
        $(MAKE) -C arch/mips/baget clean
