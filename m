Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 May 2010 11:10:58 +0200 (CEST)
Received: from pfepb.post.tele.dk ([195.41.46.236]:37325 "EHLO
        pfepb.post.tele.dk" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1492050Ab0EaJKz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 31 May 2010 11:10:55 +0200
Received: from merkur.ravnborg.org (x1-6-00-1e-2a-84-ae-3e.k225.webspeed.dk [80.163.61.94])
        by pfepb.post.tele.dk (Postfix) with ESMTP id E6CB0F8404C;
        Mon, 31 May 2010 11:10:53 +0200 (CEST)
Date:   Mon, 31 May 2010 11:10:53 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Wu Zhangjin <wuzhangjin@gmail.com>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 0/6] mips: diverse Makefile updates
Message-ID: <20100531091053.GA15894@merkur.ravnborg.org>
References: <20100530141939.GA22153@merkur.ravnborg.org> <1275295531.24461.3.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1275295531.24461.3.camel@localhost>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <sam@ravnborg.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26938
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sam@ravnborg.org
Precedence: bulk
X-list: linux-mips

On Mon, May 31, 2010 at 04:45:31PM +0800, Wu Zhangjin wrote:
> Hi, Sam & Ralf
> 
> Perhaps we also need to fix the following stuff:
> 
> ...
>   LD      vmlinux
>   SYSMAP  System.map
>   SYSMAP  .tmp_System.map
> mips64el-unknown-linux-gnu-objcopy -O elf32-tradlittlemips  --remove-section=.reginfo vmlinux vmlinux.32
>   AS      arch/mips/boot/compressed/head.o
>   CC      arch/mips/boot/compressed/decompress.o
>   CC      arch/mips/boot/compressed/dbg.o
> ...
> 
> The related Makefile is arch/mips/Makefile:
> 
> > 721 #
> > 722 # Some machines like the Indy need 32-bit ELF binaries for booting purposes.
> > 723 # Other need ECOFF, so we build a 32-bit ELF binary for them which we then
> > 724 # convert to ECOFF using elf2ecoff.
> > 725 #
> > 726 vmlinux.32: vmlinux
> > 727         $(OBJCOPY) -O $(32bit-bfd) $(OBJCOPYFLAGS) $< $@
> > 728 
> > 729 #
> > 730 # The 64-bit ELF tools are pretty broken so at this time we generate 64-bit
> > 731 # ELF files from 32-bit files by conversion.
> > 732 #
> > 733 vmlinux.64: vmlinux
> > 734         $(OBJCOPY) -O $(64bit-bfd) $(OBJCOPYFLAGS) $< $@


I have looked at it but I was confused.
vmlinux.64 seems to be used by two SGI machines only.
I wonder if this is really required - but I did not look to much.

vmlinux.32 is even more strange....
When building a 64 bit kernel vmlinux.32 is used as input to
boot/Makefile. boot.Makefile uses this file for all of:
vmlinux.bin, vmlinux.srec, vmlinux.ecoff.

But boot/compressed produces an own variant of vmlinux.32 and there
it is _only_ used as input for vmlinuz.ecoff. vmlinuz.bin + vmlinuz.srec
uses the unmodified vmlinux as input?!?

So it all looked messy and I do not have the background knowledge to
clean it up.

My thinking was to do something like this:
1) move creation of vmlinux.64 to boot/Makefile (or even better to drop it)
2) let vmlinux.32 be an intermediate step used only
   for vmlinux.ecoff and thus move it to boot/Makefile
3) adjust Makefile so thay stop producing targets in the top-level directory
   Today it is inconsistent. boot/Makefile does it in one way
   boot/compressed/Makefile does it in another way.
   Always end a build with "Kernel '...' is ready so user see the path.

Step 1) is simple.
Step 2) is questionable. Is it the correct approach?
Step 3) is a visible change but more aligned with other archs.


What do you think?

I can obviously just beautify the output by using
some more kbuild like stuff.
But I prefer to understand what is going on - at least to some extent.

PS. I have not looked at the lasat specific stuff. Is it relevant to update it?

	Sam
