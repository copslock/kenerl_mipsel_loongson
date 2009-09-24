Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Sep 2009 11:15:50 +0200 (CEST)
Received: from [195.41.46.236] ([195.41.46.236]:46180 "EHLO pfepb.post.tele.dk"
	rhost-flags-FAIL-FAIL-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492252AbZIXJPn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 24 Sep 2009 11:15:43 +0200
Received: from merkur.ravnborg.org (x1-6-00-1e-2a-84-ae-3e.k225.webspeed.dk [80.163.61.94])
	by pfepb.post.tele.dk (Postfix) with ESMTP id 2EF52F84054;
	Thu, 24 Sep 2009 11:15:40 +0200 (CEST)
Date:	Thu, 24 Sep 2009 11:15:40 +0200
From:	Sam Ravnborg <sam@ravnborg.org>
To:	Manuel Lauss <manuel.lauss@googlemail.com>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: MIPS: Alchemy build broken in latest linus-git
Message-ID: <20090924091539.GA929@merkur.ravnborg.org>
References: <f861ec6f0909232344s72af6bax5bd77f1a5be45b4f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f861ec6f0909232344s72af6bax5bd77f1a5be45b4f@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <sam@ravnborg.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24087
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sam@ravnborg.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 24, 2009 at 08:44:34AM +0200, Manuel Lauss wrote:
> Hi Sam!
> 
> Commit 51b563fc93c8cb5bff1d67a0a71c374e4a4ea049 breaks
> Alchemy build in vmlinux.lds:
> 
> 
> mipsel-softfloat-linux-gnu-gcc -E
> -Wp,-MD,arch/mips/kernel/.vmlinux.lds.d  -nostdinc -isystem
> /usr/lib/gcc/mipsel-softfloat-linux-gnu/4.3.4/include -Iinclude
> -Iinclude2 -I/mnt/work/au1200/kernel/linux-2.6.git/include
> -I/mnt/work/au1200/kernel/linux-2.6.git/arch/mips/include -include
> include/linux/autoconf.h -D__KERNEL__
> -D"VMLINUX_LOAD_ADDRESS=0xffffffff80100000" -D"DATAOFFSET=0" -P -C
> -Umips -D__ASSEMBLY__ -DLINKER_SCRIPT -o arch/mips/kernel/vmlinux.lds
> /mnt/work/au1200/kernel/linux-2.6.git/arch/mips/kernel/vmlinux.lds.S
> In file included from
> /mnt/work/au1200/kernel/linux-2.6.git/arch/mips/kernel/vmlinux.lds.S:2:
> /mnt/work/au1200/kernel/linux-2.6.git/arch/mips/include/asm/page.h:12:20:
> error: spaces.h: No such file or directory
> make[2]: *** [arch/mips/kernel/vmlinux.lds] Error 1
> make[1]: *** [arch/mips/kernel] Error 2
> make: *** [sub-make] Error 2
> 
> I tracked it to this part in the commit:
> diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> index c825b14..77f5021 100644
> --- a/arch/mips/Makefile
> +++ b/arch/mips/Makefile
> [...]
> -#
> -# Choosing incompatible machines durings configuration will result in
> -# error messages during linking.  Select a default linkscript if
> -# none has been choosen above.
> -#
> -
> -CPPFLAGS_vmlinux.lds := \
> -       $(KBUILD_CFLAGS) \
> -       -D"LOADADDR=$(load-y)" \
> -       -D"JIFFIES=$(JIFFIES)" \
> -       -D"DATAOFFSET=$(if $(dataoffset-y),$(dataoffset-y),0)"
> -

I'm away from my machine atm.
Could you try to add the following to arch/mips/kernel/makefile:

CPPFFLAGS_vmlinux.lds += $(KBUILD_CFLAGS)

This should fix it.

	Sam
