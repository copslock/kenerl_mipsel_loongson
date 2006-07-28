Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Jul 2006 17:00:20 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:5103 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133717AbWG1QAL (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 28 Jul 2006 17:00:11 +0100
Received: from localhost (p7008-ipad205funabasi.chiba.ocn.ne.jp [222.146.102.8])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id A52D8B649; Sat, 29 Jul 2006 01:00:06 +0900 (JST)
Date:	Sat, 29 Jul 2006 01:01:37 +0900 (JST)
Message-Id: <20060729.010137.36922349.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] dump_stack() based on prologue code analysis
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <cda58cb80607271203u70b26e23o65b71d3d0c900f94@mail.gmail.com>
References: <20060726.232231.59465336.anemo@mba.ocn.ne.jp>
	<44C8CEA4.20000@innova-card.com>
	<cda58cb80607271203u70b26e23o65b71d3d0c900f94@mail.gmail.com>
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
X-archive-position: 12110
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 27 Jul 2006 21:03:07 +0200, "Franck Bui-Huu" <vagabon.xyz@gmail.com> wrote:
> > > +     info.func = (void *)(pc - ofs);
> > > +     info.func_size = ofs;   /* analyze from start to ofs */
> 
> in get_frame_info(), there is the following condition to stop the
> prologue analysis
> 
> 		if (info->func_size && i >= info->func_size / 4)
> 			break;
> 
> Setting info.func_size = ofs may trigger this stop condition very
> early, specially if "ofs" is small...I would simply remove this
> condition since it's very empirical and IMHO not very usefull.

Yes, that is what I wanted.  Imagine if a exception happened on first
place on non-leaf function.  In this case, we must assume the function
is leaf since RA is not saved to the stack.

---
Atsushi Nemoto
