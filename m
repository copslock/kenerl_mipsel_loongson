Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jun 2003 16:03:53 +0100 (BST)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:23049 "EHLO
	mail.trasno.org") by linux-mips.org with ESMTP id <S8224861AbTFQPDv>;
	Tue, 17 Jun 2003 16:03:51 +0100
Received: by mail.trasno.org (Postfix, from userid 1001)
	id BF3047D0; Tue, 17 Jun 2003 17:03:24 +0200 (CEST)
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Ladislav Michl <ladis@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] kill prom_printf
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@trasno.org>
In-Reply-To: <Pine.GSO.3.96.1030617154243.22214F-100000@delta.ds2.pg.gda.pl> (Maciej
 W. Rozycki's message of "Tue, 17 Jun 2003 15:44:32 +0200 (MET DST)")
References: <Pine.GSO.3.96.1030617154243.22214F-100000@delta.ds2.pg.gda.pl>
Date: Tue, 17 Jun 2003 17:03:24 +0200
Message-ID: <86of0wiw5f.fsf@trasno.mitica>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@trasno.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2670
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@trasno.org
Precedence: bulk
X-list: linux-mips

>>>>> "maciej" == Maciej W Rozycki <macro@ds2.pg.gda.pl> writes:

maciej> On Tue, 17 Jun 2003, Juan Quintela wrote:
maciej> So you need to explicitly configure it?  That's very bad.
>> 
>> You bet:
>> - you force everybody to use early_printk (you only want it for
>> debugging).
>> - you configure early_printk for everybody (never have to configure
>> it).
>> 
>> You can't have the cake and eat it :(

maciej> I'm not sure what you mean.  Please elaborate.

As it is used in the other platforms:

- you setup your console (there is a console by default).
- until that console is initilized, messages are buffered.

that is clearly bad if your system stops before initializing the
console: i.e. zero output.

- early_printk to the rescue, as soon as you can print, you initialize
  the console, and begin printing.

- so far so god.

- now it is time to initialize the real console (reading
  console=<blah> ....)
- output from now one goes to the real console.

Problems:
a - you want all your messages in your console, and your console is not
  the console used by early_printk.  Some meassages dissapear, why?
  because early_printk is the default -> you don't want early_printk
  by default.uu

b - you want at least some output if the kernel hangs early -> you want
  early_printk by default.

I am not able to make happy people in the a) group or people in the b)
group, but not both at the same time with the default early_console.


I hope that now explanation is better (for sure that it is larger).

>> Why do you ever will want not to use early_printk?

maciej> I won't, but someone else certainly will.

I meaned here somebody in general, not you in particular :p

Later, Juan.

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
