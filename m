Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Feb 2005 16:07:05 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:46341 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224934AbVBNQGt>; Mon, 14 Feb 2005 16:06:49 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 7B7C3F5974; Mon, 14 Feb 2005 17:06:40 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 21497-10; Mon, 14 Feb 2005 17:06:40 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 365B8F5945; Mon, 14 Feb 2005 17:06:40 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id j1EG6hJ4016210;
	Mon, 14 Feb 2005 17:06:43 +0100
Date:	Mon, 14 Feb 2005 16:06:51 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: CVS Update@linux-mips.org: linux
In-Reply-To: <20050214153435.GD806@linux-mips.org>
Message-ID: <Pine.LNX.4.61L.0502141557460.2566@blysk.ds.pg.gda.pl>
References: <20050214035304Z8225242-1340+3175@linux-mips.org>
 <20050214153435.GD806@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.80/700/Fri Feb  4 00:33:15 2005
	clamav-milter version 0.80j
	on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7251
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 14 Feb 2005, Ralf Baechle wrote:

> > Modified files:
> > 	arch/mips64/kernel: Tag: linux_2_4 scall_o32.S 
> > 
> > Log message:
> > 	Gas no longer supports redefining macros.
> 
> Bulletproofing 2.4 against newer tools is something that only makes limited
> sense, especially wrt. to gcc 3.4 and newer.  Chances for any such changes
> to be accepted upstream are slim - and the kernel has traditionally been
> easily affected by overoptimization, so I recommend against gcc 3.4.  The
> recommended compiler for 2.4 is still gcc 2.95.3 but except gcc 3.0 upto
> gcc 3.3 is reasonable and can be considered well tested.

 I do agree in general, but given that the construct I've used has been 
supported by gas since 1995, there is no point in keeping our code broken.  
And binutils actually quite rarely trigger problems with Linux, while 
they've got improved significantly with the last few releases; unlike with 
GCC it's normally a good idea to use the latest version of binutils.

  Maciej
