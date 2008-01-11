Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jan 2008 17:02:10 +0000 (GMT)
Received: from pasmtpb.tele.dk ([80.160.77.98]:56811 "EHLO pasmtpB.tele.dk")
	by ftp.linux-mips.org with ESMTP id S20024287AbYAKRCB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 11 Jan 2008 17:02:01 +0000
Received: from ravnborg.org (0x535d98d8.vgnxx8.adsl-dhcp.tele.dk [83.93.152.216])
	by pasmtpB.tele.dk (Postfix) with ESMTP id 21C50E30805;
	Fri, 11 Jan 2008 18:01:58 +0100 (CET)
Received: by ravnborg.org (Postfix, from userid 500)
	id 39476580D2; Fri, 11 Jan 2008 18:02:04 +0100 (CET)
Date:	Fri, 11 Jan 2008 18:02:04 +0100
From:	Sam Ravnborg <sam@ravnborg.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	WANG Cong <xiyou.wangcong@gmail.com>,
	Andreas Schwab <schwab@suse.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-kbuild@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	linux-mips@linux-mips.org
Subject: Re: (Try #3) [Patch 2/8] MIPS: Remove 'TOPDIR' from Makefiles
Message-ID: <20080111170204.GA28299@uranus.ravnborg.org>
References: <20080101071311.GA2496@hacking> <20080101072238.GC2496@hacking> <20080101101540.GB28913@uranus.ravnborg.org> <jefxxhlkxb.fsf@sykes.suse.de> <20080101175754.GC31575@uranus.ravnborg.org> <20080102062135.GE2493@hacking> <20080111141754.GC19900@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080111141754.GC19900@linux-mips.org>
User-Agent: Mutt/1.4.2.1i
Return-Path: <sam@ravnborg.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17991
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sam@ravnborg.org
Precedence: bulk
X-list: linux-mips

On Fri, Jan 11, 2008 at 02:17:54PM +0000, Ralf Baechle wrote:
> On Wed, Jan 02, 2008 at 02:21:36PM +0800, WANG Cong wrote:
> 
> > >> Shouldn't that use $(LINUXINCLUDE), or $(KBUILD_CPPFLAGS)?
> > >It would be better to use $(LINUXINCLUDE) as we then pull in all config
> > >symbols too and do not have to hardcode kbuild internal names (include2).
> > 
> > OK. Refine this patch.
> 
> LDSCRIPT also needed fixing to get builds in a separate object directory
> working again.
> 
> I've applied below fix.

Great - I will drop it from my tree. 

See small comment below.

	Sam


>   Ralf
> 
> From 8babf06e1265214116fb8ffc634c04df85597c52 Mon Sep 17 00:00:00 2001
> From: WANG Cong <xiyou.wangcong@gmail.com>
> Date: Wed, 2 Jan 2008 14:21:36 +0800
> Subject: [PATCH] [MIPS] Lasat: Fix built in separate object directory.
> 
> Signed-off-by: WANG Cong <xiyou.wangcong@gmail.com>
> 
> [Ralf: The LDSCRIPT script needed fixing, too]
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> 
> diff --git a/arch/mips/lasat/image/Makefile b/arch/mips/lasat/image/Makefile
> index 5332449..7ccd40d 100644
> --- a/arch/mips/lasat/image/Makefile
> +++ b/arch/mips/lasat/image/Makefile
> @@ -12,11 +12,11 @@ endif
>  
>  MKLASATIMG = mklasatimg
>  MKLASATIMG_ARCH = mq2,mqpro,sp100,sp200
> -KERNEL_IMAGE = $(TOPDIR)/vmlinux
> +KERNEL_IMAGE = vmlinux
>  KERNEL_START = $(shell $(NM) $(KERNEL_IMAGE) | grep " _text" | cut -f1 -d\ )
>  KERNEL_ENTRY = $(shell $(NM) $(KERNEL_IMAGE) | grep kernel_entry | cut -f1 -d\ )
>  
> -LDSCRIPT= -L$(obj) -Tromscript.normal
> +LDSCRIPT= -L$(srctree)/$(obj) -Tromscript.normal

This needs to read:
> +LDSCRIPT= -L$(srctree)/$(src) -Tromscript.normal


(There is no difference between src and obj in normal cases but to be consistent
it shuld be like above).

>  
>  HEAD_DEFINES := -D_kernel_start=0x$(KERNEL_START) \
>  		-D_kernel_entry=0x$(KERNEL_ENTRY) \
> @@ -24,7 +24,7 @@ HEAD_DEFINES := -D_kernel_start=0x$(KERNEL_START) \
>  		-D TIMESTAMP=$(shell date +%s)
>  
>  $(obj)/head.o: $(obj)/head.S $(KERNEL_IMAGE)
> -	$(CC) -fno-pic $(HEAD_DEFINES) -I$(TOPDIR)/include -c -o $@ $<
> +	$(CC) -fno-pic $(HEAD_DEFINES) $(LINUXINCLUDE) -c -o $@ $<
>  
>  OBJECTS = head.o kImage.o
>  
