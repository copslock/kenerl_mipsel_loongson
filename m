Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Feb 2003 15:14:41 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:61271 "EHLO
	trasno.mitica") by linux-mips.org with ESMTP id <S8225213AbTBJPOk>;
	Mon, 10 Feb 2003 15:14:40 +0000
Received: by trasno.mitica (Postfix, from userid 1001)
	id AB87FC907; Mon, 10 Feb 2003 16:14:18 +0100 (CET)
To: Christoph Hellwig <hch@infradead.org>
Cc: Vivien Chappelier <vivienc@nerim.net>, linux-mips@linux-mips.org,
	Guido Guenther <agx@gandalf.physik.uni-konstanz.de>
Subject: Re: porting arcboot
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <20030210150330.A23150@infradead.org> (Christoph Hellwig's
 message of "Mon, 10 Feb 2003 15:03:30 +0000")
References: <Pine.LNX.4.21.0302101533410.1709-100000@melkor>
	<861y2g2n8r.fsf@trasno.mitica> <20030210150330.A23150@infradead.org>
Date: Mon, 10 Feb 2003 16:14:18 +0100
Message-ID: <86wuk81839.fsf@trasno.mitica>
User-Agent: Gnus/5.090012 (Oort Gnus v0.12) Emacs/21.2.92
 (i386-mandrake-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1384
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips

>>>>> "christoph" == Christoph Hellwig <hch@infradead.org> writes:

christoph> On Mon, Feb 10, 2003 at 04:01:40PM +0100, Juan Quintela wrote:
>> >>>>> "vivien" == Vivien Chappelier <vivienc@nerim.net> writes:
>> 
vivien> Thiemo told me that his R10k I2s PROM only loads 64bit executables.
vivien> Don't know if the rest of IP22 can laod 64bit executables at all.
>> 
>> I don't think so, mine (I2) only allows ECOFF, ELF is too young for it
>> :p

christoph> You probably don't have a R10k I2..

No, mine is a good old r4400SC :p

I thought that r10k I2 was IP28 not IP22, but I can be wrong as I
don't speak SGI code names natively :p

Later, Juan.

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
