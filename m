Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Mar 2003 14:48:58 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:20839 "EHLO
	trasno.mitica") by linux-mips.org with ESMTP id <S8225194AbTCUOs4>;
	Fri, 21 Mar 2003 14:48:56 +0000
Received: by trasno.mitica (Postfix, from userid 1001)
	id 2695C720; Fri, 21 Mar 2003 15:48:53 +0100 (CET)
To: Dominic Sweetman <dom@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: Cache code changes
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <15994.64849.704568.803119@gladsmuir.algor.co.uk> (Dominic
 Sweetman's message of "Fri, 21 Mar 2003 11:53:53 +0000")
References: <20030320111625.A13219@linux-mips.org>
	<15994.64849.704568.803119@gladsmuir.algor.co.uk>
Date: Fri, 21 Mar 2003 15:48:52 +0100
Message-ID: <86k7esvkq3.fsf@trasno.mitica>
User-Agent: Gnus/5.090015 (Oort Gnus v0.15) Emacs/21.2.93
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1784
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips

>>>>> "dominic" == Dominic Sweetman <dom@mips.com> writes:

dominic> Ralf,

>> flush_page_to_ram()...

dominic> Can you remind me where I can find the specification of what these
dominic> functions are supposed to do?

In the linux source:

linux/Documentation/cachetlb.txt

Later, Juan.

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
