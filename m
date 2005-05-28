Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 May 2005 20:37:46 +0100 (BST)
Received: from ms-smtp-04-smtplb.ohiordc.rr.com ([IPv6:::ffff:65.24.5.138]:19596
	"EHLO ms-smtp-04-eri0.ohiordc.rr.com") by linux-mips.org with ESMTP
	id <S8225377AbVE1Thb>; Sat, 28 May 2005 20:37:31 +0100
Received: from [192.168.0.3] (cpe-65-24-168-255.columbus.res.rr.com [65.24.168.255])
	by ms-smtp-04-eri0.ohiordc.rr.com (8.12.10/8.12.7) with ESMTP id j4SJbPHH005341;
	Sat, 28 May 2005 15:37:25 -0400 (EDT)
Subject: Re: Porting To New System
From:	Cameron Cooper <developer@phatlinux.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>,
	linux-mips@linux-mips.org
In-Reply-To: <20050528192704.GA4995@linux-mips.org>
References: <Pine.GSO.4.10.10505271929510.25076-100000@helios.et.put.poznan.pl>
	 <1117217584.5743.229.camel@localhost.localdomain>
	 <1117223539.2921.15.camel@phatbox>
	 <1117237244.5744.284.camel@localhost.localdomain>
	 <1117294983.2800.12.camel@phatbox>  <20050528192704.GA4995@linux-mips.org>
Content-Type: text/plain
Date:	Sat, 28 May 2005 15:35:50 -0400
Message-Id: <1117308950.2800.51.camel@phatbox>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Symantec AntiVirus Scan Engine
Return-Path: <developer@phatlinux.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8014
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: developer@phatlinux.com
Precedence: bulk
X-list: linux-mips

> Your question would require a very long answer to be somewhat exhaustive,
> so here the express version.  Start by reading Documentation/cachetlb.txt
> from the kernel sources.  You can find plenty of discussions related to
> this code in the linux-mips and linux-kernel archives - especially the
> subtle points aren't exactly documented ;-)

Thanks, I'll check that out. However a new complexity has arisen. It
turns out that in addition to not having access to the MMU, we do not
have access to cp0. I'm afraid that this would require even more
rewriting of the kernel. Although I started this to learn something,
there might be more involved in this than I am prepared for.

Cameron
