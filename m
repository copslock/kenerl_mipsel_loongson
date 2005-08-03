Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Aug 2005 21:19:01 +0100 (BST)
Received: from mx02.qsc.de ([IPv6:::ffff:213.148.130.14]:49827 "EHLO
	mx02.qsc.de") by linux-mips.org with ESMTP id <S8225548AbVHCUSn>;
	Wed, 3 Aug 2005 21:18:43 +0100
Received: from port-195-158-168-34.dynamic.qsc.de ([195.158.168.34] helo=hattusa.textio)
	by mx02.qsc.de with esmtp (Exim 3.35 #1)
	id 1E0PkQ-00036d-00; Wed, 03 Aug 2005 22:21:54 +0200
Received: from ths by hattusa.textio with local (Exim 4.52)
	id 1E0PkQ-0007vk-LJ; Wed, 03 Aug 2005 22:21:54 +0200
Date:	Wed, 3 Aug 2005 22:21:54 +0200
To:	Dave Johnson <djohnson+linuxmips@sw.starentnetworks.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: modules fail to load for 64bit kernel with 32bit ELF format
Message-ID: <20050803202154.GS29782@hattusa.textio>
References: <17137.2596.203177.705324@cortez.sw.starentnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17137.2596.203177.705324@cortez.sw.starentnetworks.com>
User-Agent: Mutt/1.5.9i
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8689
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Dave Johnson wrote:
> 
> Building for 64bit kernel with 32bit ELF format produces the correct
> object files for loading, but attempting to load them produces
> ENOEXEC.
> 
> This is because the object file is failing ELF header checks in
> load_module().
> 
> Elf_Ehdr in include/asm-mips/module.h is being defined as Elf64_Ehdr
> based on CONFIG_MIPS64 instead of CONFIG_BUILD_ELF64.
> 
> elf_check_arch() also needs some fixing in include/asm-mips/elf.h as
> it too is invoked from load_module(), however elf_check_arch() is also
> used in binfmt_elf*.c.
> 
> Simply changing the defines produces loads of warnings due to casting
> pointers around in module.c. Any suggestions on the best way to fix
> this?

The plan is to obsolete 64bit kernel in 32bit ELF and use 64bit ELF
with gcc -msym32 to get a similiar optimization.


Thiemo
