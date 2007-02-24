Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Feb 2007 20:58:58 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:11746 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28576270AbXBXU65 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 24 Feb 2007 20:58:57 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l1OKwrFd012775;
	Sat, 24 Feb 2007 20:58:53 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l1OKwopf012774;
	Sat, 24 Feb 2007 20:58:50 GMT
Date:	Sat, 24 Feb 2007 20:58:50 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Jim Gifford <maillist@jg555.com>
Cc:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: Building 2.6.20.1 from source
Message-ID: <20070224205850.GA12637@linux-mips.org>
References: <45E0A57F.4020304@jg555.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45E0A57F.4020304@jg555.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14239
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Feb 24, 2007 at 12:52:15PM -0800, Jim Gifford wrote:

> arch/mips/lib-64/dump_tlb.c: In function 'msk2str':
> arch/mips/lib-64/dump_tlb.c:34: warning: control reaches end of non-void 
> function
>  LD      arch/mips/lib-64/built-in.o
>  AS      arch/mips/lib-64/memset.o
>  AS      arch/mips/lib-64/watch.o
>  AR      arch/mips/lib-64/lib.a
>  GEN     .version
>  CHK     include/linux/compile.h
>  UPD     include/linux/compile.h
>  CC      init/version.o
>  LD      init/built-in.o
>  LD      .tmp_vmlinux1
> arch/mips/kernel/built-in.o: In function `sys_call_table':
> arch/mips/kernel/scall64-64.S:(.text+0x9ef8): undefined reference to 
> `compat_sys_epoll_pwait'
> make: *** [.tmp_vmlinux1] Error 1

Whops.  You can work around this bug by enabling either CONFIG_MIPS32_N32
or CONFIG_MIPS32_O32.

  Ralf
