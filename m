Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jun 2003 16:26:35 +0100 (BST)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:30474 "EHLO
	mail.trasno.org") by linux-mips.org with ESMTP id <S8224861AbTFQP0d>;
	Tue, 17 Jun 2003 16:26:33 +0100
Received: by mail.trasno.org (Postfix, from userid 1001)
	id 2BF077D0; Tue, 17 Jun 2003 17:26:06 +0200 (CEST)
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Ladislav Michl <ladis@linux-mips.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [PATCH] kill prom_printf
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@trasno.org>
In-Reply-To: <Pine.GSO.4.21.0306171712100.17930-100000@vervain.sonytel.be> (Geert
 Uytterhoeven's message of "Tue, 17 Jun 2003 17:13:37 +0200 (MEST)")
References: <Pine.GSO.4.21.0306171712100.17930-100000@vervain.sonytel.be>
Date: Tue, 17 Jun 2003 17:26:06 +0200
Message-ID: <86brwwiv3l.fsf@trasno.mitica>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@trasno.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2673
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@trasno.org
Precedence: bulk
X-list: linux-mips

>>>>> "geert" == Geert Uytterhoeven <geert@linux-m68k.org> writes:

geert> On Tue, 17 Jun 2003, Juan Quintela wrote:
>> Problems:
>> a - you want all your messages in your console, and your console is not
>> the console used by early_printk.  Some meassages dissapear, why?
>> because early_printk is the default -> you don't want early_printk
>> by default.uu

geert> No, if the `real' console has the CON_PRINTBUFFER flag set, all old buffered
geert> messages will be sent again to that console upon registration.

Didn't knew that.
Then it could be enabled by default without any adverse effect.

Later, Juan.

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
