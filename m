Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Feb 2005 21:22:56 +0000 (GMT)
Received: from alg138.algor.co.uk ([IPv6:::ffff:62.254.210.138]:50904 "EHLO
	mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224935AbVBGVWm>; Mon, 7 Feb 2005 21:22:42 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j17LHgxD014157;
	Mon, 7 Feb 2005 21:17:42 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j17LHgGg014156;
	Mon, 7 Feb 2005 21:17:42 GMT
Date:	Mon, 7 Feb 2005 21:17:42 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@avtrex.com>
Cc:	andreev <andreev@niisi.msk.ru>, linux-mips@linux-mips.org
Subject: Re: Strace doesn't work on linux-2.4.28 and later
Message-ID: <20050207211742.GB6703@linux-mips.org>
References: <41FF876B.3070407@niisi.msk.ru> <4207C142.6070804@avtrex.com> <4207C3E0.7070405@avtrex.com> <20050207210825.GA6703@linux-mips.org> <4207DBB1.9000506@avtrex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4207DBB1.9000506@avtrex.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7189
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 07, 2005 at 01:20:49PM -0800, David Daney wrote:

> >@@ -121,15 +121,14 @@
> > 
> > trace_a_syscall:
> > 	SAVE_STATIC
> >-	sw	t2, PT_SCRATCH0(sp)
> >+	move	s0, sp
>          ^^^^^^^^^^^^^
> I think this should be "move s0, t2" as in scall_64.S et al.

It should and what I've actually commited in CVS doesn't have this bug.

  Ralf
