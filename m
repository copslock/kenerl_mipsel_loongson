Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Feb 2003 18:31:25 +0000 (GMT)
Received: from p508B796B.dip.t-dialin.net ([IPv6:::ffff:80.139.121.107]:13495
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225251AbTBTSbY>; Thu, 20 Feb 2003 18:31:24 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h1KIVFd02030;
	Thu, 20 Feb 2003 19:31:15 +0100
Date: Thu, 20 Feb 2003 19:31:15 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@linux-mips.org
Subject: Re: [patch] Coalesce duplicated SiByte settings
Message-ID: <20030220193115.A394@linux-mips.org>
References: <Pine.GSO.3.96.1030220183613.25777I-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1030220183613.25777I-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Thu, Feb 20, 2003 at 06:41:52PM +0100
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1473
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Feb 20, 2003 at 06:41:52PM +0100, Maciej W. Rozycki wrote:

>  There is quite a lot identical entries for SiByte board variations in the
> top-level architecture Makefiles.  They look confusing and I don't think
> they are necessary.  Following is a proposal to remove duplicated entries. 
> OK? 

Yep, I like this.

  Ralf
