Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Apr 2003 13:15:32 +0100 (BST)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:61563 "EHLO
	trasno.mitica") by linux-mips.org with ESMTP id <S8225204AbTDVMPb>;
	Tue, 22 Apr 2003 13:15:31 +0100
Received: by trasno.mitica (Postfix, from userid 1001)
	id 6FED6729; Tue, 22 Apr 2003 14:15:04 +0200 (CEST)
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Yoichi Yuasa <yuasa@hh.iij4u.or.jp>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [patch] TANBAC TB0226(NEC VR4131) for v2.5
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <20030422140007.C15285@linux-mips.org> (Ralf Baechle's message
 of "Tue, 22 Apr 2003 14:00:07 +0200")
References: <20030422133642.A15285@linux-mips.org>
	<Pine.GSO.4.21.0304221338360.16017-100000@vervain.sonytel.be>
	<20030422140007.C15285@linux-mips.org>
Date: Tue, 22 Apr 2003 14:15:04 +0200
Message-ID: <86bryy4tkn.fsf@trasno.mitica>
User-Agent: Gnus/5.090015 (Oort Gnus v0.15) Emacs/21.2.93
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2127
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips

>>>>> "ralf" == Ralf Baechle <ralf@linux-mips.org> writes:

ralf> On Tue, Apr 22, 2003 at 01:40:19PM +0200, Geert Uytterhoeven wrote:
>> > I don't think there's much point in using ISO style initializers everywhere.
>> > So far the convention is only to replace the GNU-style inializer.
>> > We unfortunately have a few places where the code got inflated by at least
>> > the factor of 3 because now some code uses the ISO initializers for
>> > everything - for no good reason.
>> 
>> What if someone will change struct resource in the future?

ralf> For the generic case that concern may be true - but I don't think struct
ralf> resource will change any time soon.  Imagine fixing all the drivers ...

Did you noticed that "they" changed the modules? and bio?

/me think that we have already had enough _big_ breakages to learn
that not using named initializers is a bad idea.

Later, Juan.

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
