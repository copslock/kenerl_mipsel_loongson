Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Dec 2006 02:05:45 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:15784 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039733AbWLNCFn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 14 Dec 2006 02:05:43 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id kBE1l6bj004659;
	Thu, 14 Dec 2006 01:47:06 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id kBE1l4DH004657;
	Thu, 14 Dec 2006 02:47:04 +0100
Date:	Thu, 14 Dec 2006 02:47:04 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	dmitry.adamushko@gmail.com, ths@networkno.de,
	linux-mips@linux-mips.org
Subject: Re: unwind_stack() and an exception at the last instruction (after the epilogue)
Message-ID: <20061214014704.GA984@linux-mips.org>
References: <b647ffbd0612130445r14895d70p4ea313f94dee8b41@mail.gmail.com> <20061213135222.GB25904@networkno.de> <b647ffbd0612130640r10bedda5l491679df882fe2e@mail.gmail.com> <20061214.011651.31638583.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061214.011651.31638583.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13449
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Dec 14, 2006 at 01:16:51AM +0900, Atsushi Nemoto wrote:

> While current unwind_stack() is not perfect, any attempt to make it
> robust is welcome.  But you might have to analyze _all_ code if you
> wanted to save _all_ case.  I think UNIX's "90% principle" is good
> enough here.

If the current unwinder should ever become a problem we have the option
of the DWARF2-based unwinder as backup.

  Ralf
