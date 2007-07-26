Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jul 2007 12:17:13 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:42181 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021763AbXGZLRG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 26 Jul 2007 12:17:06 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l6QBH3dT030169;
	Thu, 26 Jul 2007 12:17:04 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l6QBH3Q1030168;
	Thu, 26 Jul 2007 12:17:03 +0100
Date:	Thu, 26 Jul 2007 12:17:03 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Dajie Tan <jiankemeng@gmail.com>
Cc:	John Levon <levon@movementarian.org>,
	linux-mips <linux-mips@linux-mips.org>, phil.el@wanadoo.fr,
	oprofile-list@lists.sourceforge.net
Subject: Re: [PATCH] Add support for profiling Loongson 2E
Message-ID: <20070726111703.GA30004@linux-mips.org>
References: <5861a7880707240220g5d8129anc95e10bea833e323@mail.gmail.com> <20070724144051.GA17256@linux-mips.org> <5861a7880707242041w32811dal6e2765747cbada32@mail.gmail.com> <20070725125235.GD8454@totally.trollied.org.uk> <5861a7880707251814q4b6876a1u4291d068e201488c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5861a7880707251814q4b6876a1u4291d068e201488c@mail.gmail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15903
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jul 26, 2007 at 05:14:14AM +0400, Dajie Tan wrote:

> >> Yeah,this change is to enhance the robust of oprofile. When using
> >> performace counter manually(writting control register in a module, no
> >> need to use the oprofile),I usually make kernel panic if I do not
> >> initialize the oprofile and enable the overflow interrupt carelessly.
> >> So, this change can avoid this panic. :D
> >
> >This panic is good and should stay. It shows that you've made a mistake.
> >
> >john
> >
> 
> This panic is caused by accessing a null pointer.Do you think that
> accessing a null
> pointer is allowed in a robust system ?

Of course it isn't.  From the perspective of us kernel maintainers patches
that add such checks are a red flag which raise concerns about the
correctness of the caller of the function.  So if a patch like this is
submitted the first thing that is likely to happen is that we will ask
why the check is needed.  It does not mean such a patch is fundamentally
a no-no but the code will be looked at a little harder.

  Ralf
