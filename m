Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2003 22:30:40 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:57138 "EHLO
	trasno.mitica") by linux-mips.org with ESMTP id <S8225218AbTA0Waj>;
	Mon, 27 Jan 2003 22:30:39 +0000
Received: by trasno.mitica (Postfix, from userid 1001)
	id 1C5F8BA36; Mon, 27 Jan 2003 23:30:15 +0100 (CET)
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Vivien Chappelier <vivienc@nerim.net>,
	Ralf Baechle <ralf@linux-mips.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: sigset_t32 broken?
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <Pine.GSO.4.21.0301271019030.6130-100000@vervain.sonytel.be> (Geert
 Uytterhoeven's message of "Mon, 27 Jan 2003 10:19:26 +0100 (MET)")
References: <Pine.GSO.4.21.0301271019030.6130-100000@vervain.sonytel.be>
Date: Mon, 27 Jan 2003 23:30:15 +0100
Message-ID: <86smvez0nc.fsf@trasno.mitica>
User-Agent: Gnus/5.090012 (Oort Gnus v0.12) Emacs/21.2.92
 (i386-mandrake-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1234
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips

>>>>> "geert" == Geert Uytterhoeven <geert@linux-m68k.org> writes:

geert> On Mon, 27 Jan 2003, Vivien Chappelier wrote:
>> On Fri, 24 Jan 2003, Ralf Baechle wrote:
>> > Most of what your patch does is undoing an accidental commit of a signal
>> > rework that wasn't yet supposed to go out.
>> 
>> Maybe.. but current version is still wrong :) The type of the sig
>> array in the 32-bit compatibility struct sigset_t32 must be 32bit long,
>> i.e. unsigned int not unsigned long.
>> And I think unsigned describes the data better than signed, but that's a
>> matter of taste :) (coherent with the choice in asm-mips/signal.h).

geert> Why not make it u32?

Nahh, that will make it clear indeed to stupid's like me :p

Later ,Juan.



-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
