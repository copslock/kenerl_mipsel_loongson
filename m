Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jun 2003 13:25:11 +0100 (BST)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:60960 "EHLO
	mail.trasno.org") by linux-mips.org with ESMTP id <S8225233AbTFQMZJ>;
	Tue, 17 Jun 2003 13:25:09 +0100
Received: by mail.trasno.org (Postfix, from userid 1001)
	id 8E9087FA; Tue, 17 Jun 2003 14:24:41 +0200 (CEST)
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Ladislav Michl <ladis@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] kill prom_printf
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@trasno.org>
In-Reply-To: <Pine.GSO.3.96.1030617141524.22214C-100000@delta.ds2.pg.gda.pl> (Maciej
 W. Rozycki's message of "Tue, 17 Jun 2003 14:16:12 +0200 (MET DST)")
References: <Pine.GSO.3.96.1030617141524.22214C-100000@delta.ds2.pg.gda.pl>
Date: Tue, 17 Jun 2003 14:24:41 +0200
Message-ID: <86d6hcriwm.fsf@trasno.mitica>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@trasno.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2660
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@trasno.org
Precedence: bulk
X-list: linux-mips

>>>>> "maciej" == Maciej W Rozycki <macro@ds2.pg.gda.pl> writes:

maciej> On Tue, 17 Jun 2003, Ladislav Michl wrote:
>> >  Well, I would see early_printk() as advantageous if it was also capable
>> > to leave messages in the kernel ring buffer for dmesg or klogd to fetch. 
>> 
>> Ah, we probably don't understand each other. I should type EARLY_PRINTK
>> instead of early_printk (sorry for my lazyness, I'm usually typing in
>> lowercase). CONFIG_EARLY_PRINTK enables early console, you are supposed to
>> use printk everywhere and that way you achieve such functionality.

maciej> So you need to explicitly configure it?  That's very bad.

You bet:
- you force everybody to use early_printk (you only want it for
  debugging).
- you configure early_printk for everybody (never have to configure
  it).

You can't have the cake and eat it :(

Why do you ever will want not to use early_printk?

when you are using a console that is not the prom console (why do you
want to do that on MIPS is a misterios to me), but for other
archs/machines it make sense:

think on a machine that you now it boots to use a network console.

Later, Juan.

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
