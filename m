Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Dec 2002 10:19:09 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:10220 "EHLO
	demo.mitica") by linux-mips.org with ESMTP id <S8225402AbSLSKTA>;
	Thu, 19 Dec 2002 10:19:00 +0000
Received: by demo.mitica (Postfix, from userid 501)
	id CD5C1D657; Thu, 19 Dec 2002 11:25:03 +0100 (CET)
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux mips mailing list <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH]: make prototype of printk available
References: <Pine.GSO.3.96.1021218173641.5977C-100000@delta.ds2.pg.gda.pl>
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <Pine.GSO.3.96.1021218173641.5977C-100000@delta.ds2.pg.gda.pl>
Date: 19 Dec 2002 11:25:03 +0100
Message-ID: <m2of7imhkw.fsf@demo.mitica>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2.92
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 981
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips

>>>>> "maciej" == Maciej W Rozycki <macro@ds2.pg.gda.pl> writes:

maciej> On 18 Dec 2002, Juan Quintela wrote:
>> Once there, put a tag to the printk.

maciej> Why is the default log level incorrect here?

The problem (not here in general), is that if printk's use the default
log level, then you as a user has no way to raise/lower the default
log level (i.e. the messages that you want to printk or not).

Later, Juan.

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
