Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Mar 2006 11:25:34 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:33157 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133898AbWCXLZZ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 24 Mar 2006 11:25:25 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k2OBZRjt003720;
	Fri, 24 Mar 2006 11:35:27 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k2OBZQIP003719;
	Fri, 24 Mar 2006 11:35:26 GMT
Date:	Fri, 24 Mar 2006 11:35:26 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	dhunjukrishna@gmail.com
Cc:	linux-mips@linux-mips.org
Subject: Re: Compilation problem with kernel 2.4.16
Message-ID: <20060324113525.GA3250@linux-mips.org>
References: <20060324083141.GB3170@linux-mips.org> <20060324094916.96936.qmail@web53503.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060324094916.96936.qmail@web53503.mail.yahoo.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10925
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Mar 24, 2006 at 01:49:16AM -0800, Krishna wrote:

> Sorry I mentioned version incorrectly. It is 2.6.14. The compiler i m using
> is sb1-elf-gcc (which i downloaded from
> www.broadcom.com/products/sibyte_downloads.php#toolchain). Her is the error description:

The *-elf gcc configuration will not work for compiling Linux/MIPS or
applications; you need a mips-linux target.

>   **********************************************
>   Makefile:489: .config: No such file or directory
>   scripts/basic/fixdep.c: In function `parse_config_file':
>   scripts/basic/fixdep.c:228: warning: implicit declaration of function `ntohl'
>   scripts/basic/fixdep.c: In function `print_deps':
>   scripts/basic/fixdep.c:336: warning: unused variable `map'
>   /home1/guest/vikram/COMPILER/specifix/broadcom_2004e_341/i686-pc-linux-gnu/bin/../lib/gcc/sb1-elf/3.4.1/../../../../sb1-elf/bin/ld: warning: cannot find entry symbol _start; defaulting to 0000000000400040
>   /tmp/ccb1vCvc.o(.text+0x4): In function `usage':
>   : undefined reference to `_impure_ptr'
>   /tmp/ccb1vCvc.o(.text+0x4): In function `usage':
>   : relocation truncated to fit: R_MIPS_GPREL16 _impure_ptr

These messages seem to indicate you did something bad to the makefiles.
The crosscompiler is being invoked where the target compiler should be.

  Ralf
