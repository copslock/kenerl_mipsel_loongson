Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Dec 2003 03:21:21 +0000 (GMT)
Received: from mo03.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:42732 "EHLO
	mo03.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225567AbTLBDVS>;
	Tue, 2 Dec 2003 03:21:18 +0000
Received: from mdo01.iij4u.or.jp (mdo01.iij4u.or.jp [210.130.0.171])
	by mo03.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id MAA00742;
	Tue, 2 Dec 2003 12:21:14 +0900 (JST)
Received: 4UMDO01 id hB23LD421709; Tue, 2 Dec 2003 12:21:13 +0900 (JST)
Received: 4UMRO00 id hB23LDe04994; Tue, 2 Dec 2003 12:21:13 +0900 (JST)
	from rally.montavista.co.jp (sonicwall.montavista.co.jp [202.232.97.131]) (authenticated)
Date: Tue, 2 Dec 2003 12:21:13 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips@linux-mips.org
Subject: Re: [patch] NEC VR41xx new timer
Message-Id: <20031202122113.7ce9ab7d.yuasa@hh.iij4u.or.jp>
In-Reply-To: <20031201193748.GA21538@linux-mips.org>
References: <20031202014935.1b2c796b.yuasa@hh.iij4u.or.jp>
	<20031201193748.GA21538@linux-mips.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3697
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

On Mon, 1 Dec 2003 20:37:48 +0100
Ralf Baechle <ralf@linux-mips.org> wrote:

> On Tue, Dec 02, 2003 at 01:49:35AM +0900, Yoichi Yuasa wrote:
> 
> > I updated new timer patches for latest CVS tree.
> > These patches are required for power management.
> > 
> > Please apply these patches.
> 
> Applied.  One comment on the new ksym.c file.  In 2.4 we used to have most
> of the EXPORT_SYMBOL calls in a separate file in order to reduce the
> compile time.  With the new kbuild system of 2.6 this is no longer a
> problem so now the prefered way is exporting symbols from the defining
> file itself.  So for example most of the symbol exports left in
> arch/mips/kernel/mips_ksyms.c are for definitions in assembler files.

I understood it.
I'll check whether they are needed for 2.6.

Thank you for your comment,

Yoichi
