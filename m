Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jun 2003 00:31:33 +0100 (BST)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:63100 "EHLO
	mail.trasno.org") by linux-mips.org with ESMTP id <S8225217AbTFPXba>;
	Tue, 17 Jun 2003 00:31:30 +0100
Received: by mail.trasno.org (Postfix, from userid 1001)
	id A28677D0; Tue, 17 Jun 2003 01:31:02 +0200 (CEST)
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Ladislav Michl <ladis@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] kill prom_printf
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@trasno.org>
In-Reply-To: <Pine.GSO.3.96.1030616165248.2112D-100000@delta.ds2.pg.gda.pl> (Maciej
 W. Rozycki's message of "Mon, 16 Jun 2003 17:19:45 +0200 (MET DST)")
References: <Pine.GSO.3.96.1030616165248.2112D-100000@delta.ds2.pg.gda.pl>
Date: Tue, 17 Jun 2003 01:31:02 +0200
Message-ID: <867k7lsiq1.fsf@trasno.mitica>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@trasno.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2649
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@trasno.org
Precedence: bulk
X-list: linux-mips

>>>>> "maciej" == Maciej W Rozycki <macro@ds2.pg.gda.pl> writes:

maciej> On Mon, 16 Jun 2003, Ladislav Michl wrote:
>> I was told by many people that prom_printf and friends should die and
>> early_printk should be used instead. this patch (against 2.5) does first
>> part of job. compiles and works on IP22 (SNI RM200 and IP32 don't
>> compile anyway). Feedback appreciated, as always.

maciej> Hmm, strange idea -- I guess that originates from systems that have no
maciej> suitable firmware to perform such an operation at the console.  Currently
maciej> only x86_64 implements early_printk() -- if we have an implementation for
maciej> MIPS, we may consider removing the alternative.  Also prom_printf() comes
maciej> almost for free and works very early and as I see in the x86_64 version
maciej> early_printk() requires initialization of a console driver, which may be
maciej> unfortunate if debugging a problem within the driver. 

There is at least one implementation for x86 that uses the VGA
directly (as the BIOS left it), getting it very soon.

But you are right, PC's speciality is not to have a nice console.
Anyways, you can use early_printk() in MIPS.  You only need to put the
setup of the early console sooner, as for you the setup is basically a NOP.

Later, Juan.

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
