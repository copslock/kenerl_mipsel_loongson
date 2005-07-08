Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Jul 2005 14:43:31 +0100 (BST)
Received: from admin.voldemort.codesourcery.com ([IPv6:::ffff:65.74.133.9]:712
	"EHLO mail.codesourcery.com") by linux-mips.org with ESMTP
	id <S8226362AbVGHNnN>; Fri, 8 Jul 2005 14:43:13 +0100
Received: (qmail 20781 invoked by uid 1010); 8 Jul 2005 13:43:48 -0000
From:	Richard Sandiford <richard@codesourcery.com>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Mail-Followup-To: "Maciej W. Rozycki" <macro@linux-mips.org>,Ralf Baechle <ralf@linux-mips.org>,  linux-mips@linux-mips.org, richard@codesourcery.com
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: CVS Update@linux-mips.org: linux
References: <20050708091711Z8226352-3678+1954@linux-mips.org>
	<20050708120238.GA2816@linux-mips.org>
	<Pine.LNX.4.61L.0507081309530.25104@blysk.ds.pg.gda.pl>
Date:	Fri, 08 Jul 2005 14:43:45 +0100
In-Reply-To: <Pine.LNX.4.61L.0507081309530.25104@blysk.ds.pg.gda.pl> (Maciej
	W. Rozycki's message of "Fri, 8 Jul 2005 13:12:55 +0100 (BST)")
Message-ID: <87vf3l4dm6.fsf@talisman.home>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <richard@codesourcery.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8407
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: richard@codesourcery.com
Precedence: bulk
X-list: linux-mips

"Maciej W. Rozycki" <macro@linux-mips.org> writes:
> On Fri, 8 Jul 2005, Ralf Baechle wrote:
>> > Log message:
>> > 	Protect noat assembly with .set push/pop and make it somewhat readable.
>> 
>> It doesn't need protction.
>
>  Are you absolutely sure future versions of GCC won't default to ".set 
> noat" for inline asm?

Yes ;)  All hell would break loose otherwise. ;)
