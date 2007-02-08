Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Feb 2007 16:36:33 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:6113 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038601AbXBHQg2 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 8 Feb 2007 16:36:28 +0000
Received: from localhost (p4240-ipad301funabasi.chiba.ocn.ne.jp [122.17.254.240])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 41E3E856F; Fri,  9 Feb 2007 01:35:07 +0900 (JST)
Date:	Fri, 09 Feb 2007 01:35:07 +0900 (JST)
Message-Id: <20070209.013507.52129192.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 9/10] signal: do not use save_static_function() anymore
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <cda58cb80702080739y18d31a34gc184a0cc96c86fb0@mail.gmail.com>
References: <cda58cb80702080053m6f22dc15td3b8c447e2abbda1@mail.gmail.com>
	<20070208.223637.108120499.anemo@mba.ocn.ne.jp>
	<cda58cb80702080739y18d31a34gc184a0cc96c86fb0@mail.gmail.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13995
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 8 Feb 2007 16:39:42 +0100, "Franck Bui-Huu" <vagabon.xyz@gmail.com> wrote:
> You're right the patch I sent is not sufficient. However, we actually
> could restore save_static_function (well if we do it, I think it's
> much better to do it in assembly code...) for sys_sigreturn() _only_.
> In that case RESTORE_STATIC should load correct values, shouldn't it ?

Yes.  I think you are right.

> But the points are:
> 
> 	- get rid of saving static registers in setup_sigcontext()
> 	- get rid of restoring static registers in restore_sigcontext()
> 	- free space in the signal frame

I'm afraid of ABI compatibility.  Someone might try to handle SIGSEGV
and dump all registers to debug the program without debugger...

---
Atsushi Nemoto
