Received:  by oss.sgi.com id <S553762AbQKSPFU>;
	Sun, 19 Nov 2000 07:05:20 -0800
Received: from smtp.algor.co.uk ([62.254.210.199]:51397 "EHLO
        kenton.algor.co.uk") by oss.sgi.com with ESMTP id <S553664AbQKSPFM>;
	Sun, 19 Nov 2000 07:05:12 -0800
Received: from gladsmuir.algor.co.uk (dom@gladsmuir.algor.co.uk [192.168.5.75])
	by kenton.algor.co.uk (8.9.3/8.8.8) with ESMTP id PAA15603;
	Sun, 19 Nov 2000 15:05:05 GMT
Received: (from dom@localhost)
	by gladsmuir.algor.co.uk (8.8.5/8.8.5) id PAA00336;
	Sun, 19 Nov 2000 15:16:33 GMT
Date:   Sun, 19 Nov 2000 15:16:33 GMT
Message-Id: <200011191516.PAA00336@gladsmuir.algor.co.uk>
From:   Dominic Sweetman <dom@algor.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     Harald Koerfgen <Harald.Koerfgen@home.ivm.de>,
        linux-cvs@oss.sgi.com, linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: Re: CVS Update@oss.sgi.com: linux
In-Reply-To: <20001118182114.A19710@bacchus.dhis.org>
References: <20001118132233Z553804-494+838@oss.sgi.com>
	<XFMail.001118180639.Harald.Koerfgen@home.ivm.de>
	<20001118182114.A19710@bacchus.dhis.org>
X-Mailer: VM 6.34 under 19.16 "Lille" XEmacs Lucid
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


Ralf Baechle (ralf@oss.sgi.com) writes:

> > >       New configuration option CONFIG_MIPS_UNCACHED.  Not yet
> > >       selectable due to the manuals documenting ll/sc operation
> > >       as undefined for uncached memory.
> > 
> > Wouldn't it make sense then to disable CONFIG_CPU_HAS_LLSC as well?
> 
> I'm waiting for authoritative answer from silicon guys before I
> deciede.  In the past I ran kernel entirely uncached and they seemed
> to work even though the documentation made me assume the opposite.

ll/sc between CPUs certainly won't work for uncached accesses, since
they rely on the cache coherency protocols.

On a uniprocessor CPU the ll/sc link is typically broken on any
exception.  You'd have to try very hard to design the CPU so that it
would work any differently for cached and uncached accesses.

-- 
Dominic Sweetman
Algorithmics Ltd
The Fruit Farm, Ely Road, Chittering, CAMBS CB5 9PH, ENGLAND
phone: +44 1223 706200 / fax: +44 1223 706250 / home: +44 20 7226 0032
http://www.algor.co.uk
