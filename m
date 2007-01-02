Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jan 2007 16:07:01 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:21201 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28647188AbXABQG4 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 2 Jan 2007 16:06:56 +0000
Received: from localhost (p2194-ipad201funabasi.chiba.ocn.ne.jp [222.146.65.194])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 2F77CFABE; Wed,  3 Jan 2007 01:06:51 +0900 (JST)
Date:	Wed, 03 Jan 2007 01:06:50 +0900 (JST)
Message-Id: <20070103.010650.25910215.anemo@mba.ocn.ne.jp>
To:	danieljlaird@hotmail.com
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH][respin] pnx8550: fix system timer support
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <8124491.post@talk.nabble.com>
References: <20061229.011621.05599370.anemo@mba.ocn.ne.jp>
	<acd2a5930612280820l43639382x1f573386f2752d18@mail.gmail.com>
	<8124491.post@talk.nabble.com>
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
X-archive-position: 13534
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 2 Jan 2007 06:05:55 -0800 (PST), Daniel Laird <danieljlaird@hotmail.com> wrote:
> First things first, if I do use the line 
> clocksource_mips.read = hpt_read; 
> It does not compile as this symbol is not in a header file and is a static
> struct in arch/mips/kernel/time.c
> I can make it not static and extern it from pnx8550/common/time.c is this
> how I should do it?

To fix the build problem, use latest linux-mips.org git-tree or use
2.6.20-rc3 from kernel.org, or import these patches:

http://www.linux-mips.org/git?p=linux.git;a=commit;h=c87b6ebaea034c0e0ce86127870cf1511a307b64
http://www.linux-mips.org/git?p=linux.git;a=commit;h=005985609ff72df3257fde6b29aa9d71342c2a6b

---
Atsushi Nemoto
