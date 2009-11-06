Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Nov 2009 17:34:16 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:53493 "EHLO
	localhost.localdomain" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492939AbZKFQeN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 6 Nov 2009 17:34:13 +0100
Date:	Fri, 6 Nov 2009 16:34:13 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
cc:	linux-mips@linux-mips.org
Subject: Re: COMMAND_LINE_SIZE and CONFIG_FRAME_WARN
In-Reply-To: <20091107.010839.246840249.anemo@mba.ocn.ne.jp>
Message-ID: <alpine.LFD.2.00.0911061622160.9725@eddie.linux-mips.org>
References: <20091107.010839.246840249.anemo@mba.ocn.ne.jp>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24736
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, 7 Nov 2009, Atsushi Nemoto wrote:

> Recently COMMAND_LINE_SIZE (CL_SIZE) was extended to 4096 from 512.
> (commit 22242681 "MIPS: Extend COMMAND_LINE_SIZE")
> 
> This cause warning if something like buf[CL_SIZE] was declared as a
> local variable, for example in prom_init_cmdline() on some platforms.
> 
> And since many Makefiles in arch/mips enables -Werror, this cause
> build failure.
> 
> How can we avoid this error?
> 
> - do not use local array? (but dynamic allocation cannot be used in
>   such an early stage.  static array?)
> - are there any way to disable -Wframe-larger-than for the file or function?
> - make COMMAND_LINE_SIZE customizable?
> - use non default CONFIG_FRAME_WARN?
> 
> Any comments or suggestions?

 Use static storage and mark it initdata?  You can certainly override 
-Wframe-larger-than in per-object CFLAGS too.  You might also be able to 
use __builtin_alloca(), but this sounds like a shaky ground. ;)

  Maciej
