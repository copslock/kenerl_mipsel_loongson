Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Mar 2006 08:35:57 +0000 (GMT)
Received: from www.haninternet.co.kr ([211.63.64.4]:1809 "EHLO
	www.haninternet.co.kr") by ftp.linux-mips.org with ESMTP
	id S8133529AbWCXIfr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Mar 2006 08:35:47 +0000
Received: from [211.63.70.179] ([211.63.70.179])
	by www.haninternet.co.kr (8.9.3/8.9.3) with ESMTP id RAA13527
	for <linux-mips@linux-mips.org>; Fri, 24 Mar 2006 17:43:44 +0900
Subject: Re: Compilation problem with kernel 2.4.16
From:	Gowri Satish Adimulam <gowri@bitel.co.kr>
Reply-To: gowri@bitel.co.kr
To:	linux-mips@linux-mips.org
In-Reply-To: <20060324082842.68469.qmail@web53506.mail.yahoo.com>
References: <20060324082842.68469.qmail@web53506.mail.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Organization: Bitel Co Ltd
Date:	Fri, 24 Mar 2006 17:45:48 +0900
Message-Id: <1143189948.3249.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 8bit
Return-Path: <gowri@bitel.co.kr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10922
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gowri@bitel.co.kr
Precedence: bulk
X-list: linux-mips

Hi , your first line of error gives some indication taht your make file
is trying to use conditional compilation based on .config .
hence searching for .config but  it could not find location.

maybe due to the first error , you are getting remaining errors.
Regards
Gowri 

On Fri, 2006-03-24 at 00:28 -0800, Krishna wrote:
> here is the error description:
>  
> ********************************************************
> Makefile:489: .config: No such file or directory
> scripts/basic/fixdep.c: In function `parse_config_file':
> scripts/basic/fixdep.c:228: warning: implicit declaration of function
> `ntohl'
> scripts/basic/fixdep.c: In function `print_deps':
> scripts/basic/fixdep.c:336: warning: unused variable `map'
> /home1/guest/vikram/COMPILER/specifix/broadcom_2004e_341/i686-pc-linux-gnu/bin/../lib/gcc/sb1-elf/3.4.1/../../../../sb1-elf/bin/ld: warning: cannot find entry symbol _start; defaulting to 0000000000400040
> /tmp/ccb1vCvc.o(.text+0x4): In function `usage':
> : undefined reference to `_impure_ptr'
> /tmp/ccb1vCvc.o(.text+0x4): In function `usage':
> : relocation truncated to fit: R_MIPS_GPREL16 _impure_ptr
> /tmp/ccb1vCvc.o(.text+0x1c): In function `usage':
> : undefined reference to `fwrite'
> /tmp/ccb1vCvc.o(.text+0x24): In function `usage':
> : undefined reference to `exit'
> /tmp/ccb1vCvc.o(.text+0x3c): In function `print_cmdline':
> : undefined reference to `printf'
> /tmp/ccb1vCvc.o(.text+0x80): In function `grow_config':
> : undefined reference to `realloc'
> /tmp/ccb1vCvc.o(.text+0xc0): In function `grow_config':
> : undefined reference to `perror'
> /tmp/ccb1vCvc.o(.text+0xc8): In function `grow_config':
> : undefined reference to `exit'
> /tmp/ccb1vCvc.o(.text+0x148): In function `is_defined_config':
> : undefined reference to `memcmp'
> /tmp/ccb1vCvc.o(.text+0x1b8): In function `define_config':
> : undefined reference to `memcpy'
> /tmp/ccb1vCvc.o(.text+0x268): In function `use_config':
> : undefined reference to `memcpy'
> /tmp/ccb1vCvc.o(.text+0x340): In function `parse_config_file':
> : undefined reference to `_ctype_'
> /tmp/ccb1vCvc.o(.text+0x290): In function `use_config':
> : undefined reference to `_ctype_'
> /tmp/ccb1vCvc.o(.text+0x2e8): In function `use_config':
> : undefined reference to `printf'
> /tmp/ccb1vCvc.o(.text+0x280): In function `use_config':
> : undefined reference to `_ctype_'
> /tmp/ccb1vCvc.o(.text+0x358): In function `parse_config_file':
> : undefined reference to `_ctype_'
> /tmp/ccb1vCvc.o(.text+0x360): In function `parse_config_file':
> : undefined reference to `ntohl'
> /tmp/ccb1vCvc.o(.text+0x374): In function `parse_config_file':
> : undefined reference to `ntohl'
> /tmp/ccb1vCvc.o(.text+0x388): In function `parse_config_file':
> : undefined reference to `ntohl'
> /tmp/ccb1vCvc.o(.text+0x3b0): In function `parse_config_file':
> : undefined reference to `ntohl'
> /tmp/ccb1vCvc.o(.text+0x3d8): In function `parse_config_file':
> : undefined reference to `memcmp'
> /tmp/ccb1vCvc.o(.text+0x498): In function `strrcmp':
> : undefined reference to `strlen'
> /tmp/ccb1vCvc.o(.text+0x4a4): In function `strrcmp':
> : undefined reference to `strlen'
> /tmp/ccb1vCvc.o(.text+0x4dc): In function `strrcmp':
> : undefined reference to `memcmp'
> /tmp/ccb1vCvc.o(.text+0x514): In function `do_config_file':
> : undefined reference to `open'
> /tmp/ccb1vCvc.o(.text+0x52c): In function `do_config_file':
> : undefined reference to `fstat'
> /tmp/ccb1vCvc.o(.text+0x540): In function `do_config_file':
> : undefined reference to `close'
> /tmp/ccb1vCvc.o(.text+0x560): In function `do_config_file':
> : undefined reference to `close'
> /tmp/ccb1vCvc.o(.text+0x57c): In function `do_config_file':
> : undefined reference to `_impure_ptr'
> /tmp/ccb1vCvc.o(.text+0x57c): In function `do_config_file':
> : relocation truncated to fit: R_MIPS_GPREL16 _impure_ptr
> /tmp/ccb1vCvc.o(.text+0x590): In function `do_config_file':
> : undefined reference to `fwrite'
> /tmp/ccb1vCvc.o(.text+0x598): In function `do_config_file':
> : undefined reference to `perror'
> /tmp/ccb1vCvc.o(.text+0x5a0): In function `do_config_file':
> : undefined reference to `exit'
> /tmp/ccb1vCvc.o(.text+0x5dc): In function `parse_dep_file':
> : undefined reference to `strchr'
> /tmp/ccb1vCvc.o(.text+0x600): In function `parse_dep_file':
> : undefined reference to `memcpy'
> /tmp/ccb1vCvc.o(.text+0x614): In function `parse_dep_file':
> : undefined reference to `printf'
> /tmp/ccb1vCvc.o(.text+0x6a4): In function `parse_dep_file':
> : undefined reference to `memcpy'
> /tmp/ccb1vCvc.o(.text+0x704): In function `parse_dep_file':
> : undefined reference to `printf'
> /tmp/ccb1vCvc.o(.text+0x714): In function `parse_dep_file':
> : undefined reference to `printf'
> /tmp/ccb1vCvc.o(.text+0x7b8): In function `parse_dep_file':
> : undefined reference to `printf'
> /tmp/ccb1vCvc.o(.text+0x7d0): In function `parse_dep_file':
> : undefined reference to `_impure_ptr'
> /tmp/ccb1vCvc.o(.text+0x7d0): In function `parse_dep_file':
> : relocation truncated to fit: R_MIPS_GPREL16 _impure_ptr
> /tmp/ccb1vCvc.o(.text+0x7e4): In function `parse_dep_file':
> : undefined reference to `fwrite'
> /tmp/ccb1vCvc.o(.text+0x7ec): In function `parse_dep_file':
> : undefined reference to `exit'
> /tmp/ccb1vCvc.o(.text+0x808): In function `print_deps':
> : undefined reference to `open'
> /tmp/ccb1vCvc.o(.text+0x820): In function `print_deps':
> : undefined reference to `fstat'
> /tmp/ccb1vCvc.o(.text+0x83c): In function `print_deps':
> : undefined reference to `_impure_ptr'
> /tmp/ccb1vCvc.o(.text+0x83c): In function `print_deps':
> : relocation truncated to fit: R_MIPS_GPREL16 _impure_ptr
> /tmp/ccb1vCvc.o(.text+0x844): In function `print_deps':
> : undefined reference to `fprintf'
> /tmp/ccb1vCvc.o(.text+0x850): In function `print_deps':
> : undefined reference to `close'
> /tmp/ccb1vCvc.o(.text+0x868): In function `print_deps':
> : undefined reference to `_impure_ptr'
> /tmp/ccb1vCvc.o(.text+0x868): In function `print_deps':
> : relocation truncated to fit: R_MIPS_GPREL16 _impure_ptr
> /tmp/ccb1vCvc.o(.text+0x87c): In function `print_deps':
> : undefined reference to `fwrite'
> /tmp/ccb1vCvc.o(.text+0x884): In function `print_deps':
> : undefined reference to `perror'
> /tmp/ccb1vCvc.o(.text+0x88c): In function `print_deps':
> : undefined reference to `exit'
> /tmp/ccb1vCvc.o(.text+0x8a4): In function `traps':
> : undefined reference to `ntohl'
> /tmp/ccb1vCvc.o(.text+0x8c0): In function `traps':
> : undefined reference to `_impure_ptr'
> /tmp/ccb1vCvc.o(.text+0x8c0): In function `traps':
> : relocation truncated to fit: R_MIPS_GPREL16 _impure_ptr
> /tmp/ccb1vCvc.o(.text+0x8cc): In function `traps':
> : undefined reference to `fprintf'
> /tmp/ccb1vCvc.o(.text+0x8d4): In function `traps':
> : undefined reference to `exit'
> /tmp/ccb1vCvc.o(.sdata+0x0): undefined reference to `_ctype_'
> collect2: ld returned 1 exit status
> make[2]: *** [scripts/basic/fixdep] Error 1
> make[1]: *** [scripts_basic] Error 2
> make: *** [include/linux/autoconf.h] Error 2
>  
> ******************************************************************************************
>  
> Hope it will help you to sort it out the problem.
>  
> Thanks
> Krishna
> 
> 
> Gowri Satish Adimulam <gowri@bitel.co.kr> wrote:
>         Hi,
>         could you post the error message , so that group members can
>         analyse and
>         post you correct solution.
>         
>         Gowri
>         On Thu, 2006-03-23 at 23:45 -0800, Krishna wrote:
>         > Hi,
>         > 
>         > I have been trying to cross compile Linux/MIPS kernel
>         verison 2.4.16
>         > with the specifix's sibyte cross compiler (sb1-elf cross
>         compilers for
>         > x86 linux hosts) for BCM 1480 Broadcom board. I have set the
>         path for
>         > cross compiler properly in make file even then the
>         compilation failed.
>         > Then we tried adding parameter " -Tcfe.ld" (which is must
>         for
>         > compilation) in compilation command (as has been suggested
>         by
>         > broadcom) still unble to get it done correctly. Wondering
>         what else we
>         > need to change in make file. Or else is there any other
>         cross compiler
>         > for BCM 1480 (than specifix one) that we can use. Anyone
>         suggest me
>         > the proper way for compiling the kernel with the above cross
>         > compiler. 
>         > 
>         > Thanks and Regards
>         > Krishna
>         > 
>         >
>         ______________________________________________________________________
>         > New Yahoo! Messenger with Voice. Call regular phones from
>         your PC and
>         > save big.
>         
> 
> 
> 
> 
> ______________________________________________________________________
> Blab-away for as little as 1¢/min. Make PC-to-Phone Calls using Yahoo!
> Messenger with Voice.
