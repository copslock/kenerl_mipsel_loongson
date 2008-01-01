Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Jan 2008 10:15:51 +0000 (GMT)
Received: from pasmtpa.tele.dk ([80.160.77.114]:43458 "EHLO pasmtpA.tele.dk")
	by ftp.linux-mips.org with ESMTP id S20029688AbYAAKPl (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 1 Jan 2008 10:15:41 +0000
Received: from ravnborg.org (0x535d98d8.vgnxx8.adsl-dhcp.tele.dk [83.93.152.216])
	by pasmtpA.tele.dk (Postfix) with ESMTP id 871E8800E52;
	Tue,  1 Jan 2008 11:15:38 +0100 (CET)
Received: by ravnborg.org (Postfix, from userid 500)
	id 9FB27580D2; Tue,  1 Jan 2008 11:15:40 +0100 (CET)
Date:	Tue, 1 Jan 2008 11:15:40 +0100
From:	Sam Ravnborg <sam@ravnborg.org>
To:	WANG Cong <xiyou.wangcong@gmail.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-kbuild@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	linux-mips@linux-mips.org
Subject: Re: [Patch 2/8] MIPS: Remove 'TOPDIR' from Makefiles
Message-ID: <20080101101540.GB28913@uranus.ravnborg.org>
References: <20080101071311.GA2496@hacking> <20080101072238.GC2496@hacking>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080101072238.GC2496@hacking>
User-Agent: Mutt/1.4.2.1i
Return-Path: <sam@ravnborg.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17901
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sam@ravnborg.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 01, 2008 at 03:22:38PM +0800, WANG Cong wrote:
> 
> TOPDIR is obsolete, use objtree instead.
> This patch removes TOPDIR from all Mips Makefiles.
> 
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Signed-off-by: WANG Cong <xiyou.wangcong@gmail.com>
> 
> ---
> 
> diff --git a/arch/mips/lasat/image/Makefile b/arch/mips/lasat/image/Makefile
> index 5332449..5196962 100644
> --- a/arch/mips/lasat/image/Makefile
> +++ b/arch/mips/lasat/image/Makefile
> @@ -12,7 +12,7 @@ endif
>  
>  MKLASATIMG = mklasatimg
>  MKLASATIMG_ARCH = mq2,mqpro,sp100,sp200
> -KERNEL_IMAGE = $(TOPDIR)/vmlinux
> +KERNEL_IMAGE = $(objtree)/vmlinux

Current directory when building is $(objtree) so here we should
just skip the use of TOPDIR like this:
> +KERNEL_IMAGE = vmlinux


>  KERNEL_START = $(shell $(NM) $(KERNEL_IMAGE) | grep " _text" | cut -f1 -d\ )
>  KERNEL_ENTRY = $(shell $(NM) $(KERNEL_IMAGE) | grep kernel_entry | cut -f1 -d\ )
>  
> @@ -24,7 +24,7 @@ HEAD_DEFINES := -D_kernel_start=0x$(KERNEL_START) \
>  		-D TIMESTAMP=$(shell date +%s)
>  
>  $(obj)/head.o: $(obj)/head.S $(KERNEL_IMAGE)
> -	$(CC) -fno-pic $(HEAD_DEFINES) -I$(TOPDIR)/include -c -o $@ $<
> +	$(CC) -fno-pic $(HEAD_DEFINES) -I$(objtree)/include -c -o $@ $<
This has never worked with O=.. builds.
The correct fix here is to use:
> +	$(CC) -fno-pic $(HEAD_DEFINES) -Iinclude -Iinclude2 -c -o $@ $<

The -Iinclude2 is only for O=... builds so to keep current
behaviour removing $(TOPDIR)/ would do it.

	Sam
