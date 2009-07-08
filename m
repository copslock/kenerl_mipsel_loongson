Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Jul 2009 20:25:42 +0200 (CEST)
Received: from syd-iport-2.cisco.com ([64.104.193.197]:51138 "EHLO
	syd-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492483AbZGHSZZ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 8 Jul 2009 20:25:25 +0200
X-IronPort-AV: E=Sophos;i="4.42,369,1243814400"; 
   d="scan'208";a="55019743"
Received: from syd-dkim-1.cisco.com ([64.104.193.116])
  by syd-iport-2.cisco.com with ESMTP; 08 Jul 2009 18:25:01 +0000
Received: from sj-core-5.cisco.com (sj-core-5.cisco.com [171.71.177.238])
	by syd-dkim-1.cisco.com (8.12.11/8.12.11) with ESMTP id n68IP0Q9006456;
	Thu, 9 Jul 2009 04:25:01 +1000
Received: from cuplxvomd02.corp.sa.net ([64.101.20.155])
	by sj-core-5.cisco.com (8.13.8/8.14.3) with ESMTP id n68IP0LZ019278;
	Wed, 8 Jul 2009 18:25:00 GMT
Date:	Wed, 8 Jul 2009 11:25:00 -0700
From:	David VomLehn <dvomlehn@cisco.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	joe seb <joe.seb8@gmail.com>, linux-mips@linux-mips.org
Subject: Re: Linux port failing on MIPS32 24Kc
Message-ID: <20090708182500.GA31285@cuplxvomd02.corp.sa.net>
References: <4f9abdc70907080107t28fdac03h86b834a60806fb10@mail.gmail.com> <20090708103756.GB22308@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090708103756.GB22308@linux-mips.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=1937; t=1247077501; x=1247941501;
	c=relaxed/simple; s=syddkim1002;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20David=20VomLehn=20<dvomlehn@cisco.com>
	|Subject:=20Re=3A=20Linux=20port=20failing=20on=20MIPS32=20
	24Kc
	|Sender:=20;
	bh=H9x7iIfx3mb+5l91nAGr4VB7ybExpaEoXHatMp37R/k=;
	b=15hDUVk41g5/cXdz+bTpz+MLlIAbTQO2EfQm6tRK10Ar+gQBmkB2/cbbQp
	siXlLewDZtYgJBIi8p2LfdN46VH0lc9ujj9ySLyma206r4bL3QTmMflgpygb
	i8bqxLJl9zDWJvY1A2LX+zLrTJHdn7A0S9lUWy8EVKcpFG3Olgbzk=;
Authentication-Results:	syd-dkim-1; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/syddkim1002 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23682
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

On Wed, Jul 08, 2009 at 11:37:56AM +0100, Ralf Baechle wrote:
> On Wed, Jul 08, 2009 at 01:37:42PM +0530, joe seb wrote:
> 
> > We are trying to port linux 2.6.29.4 version of the kernel from
> > linux-mips.org site to our MIPS 24K based platform and we see issues when we
> > use the cache in write-back mode. Cache with write-through configuration
> > works fine.
...
> > CPU 0 Unable to handle kernel paging request at virtual address cccccccc,
> > epc ==
> >  cccccccc, ra == cccccccc
...
> > We get crashes at different places and the above crash is one of them.
> > Do you think this failure is due to the wrong cache configuration or related
> > to the d-cache aliasing problem?

In a narrow sense, when you get a page fault at an address that equals the
value of the EPC register and the ra register is the same value, you have
probably smashed your stack. Specifically, you smashed the location where
the ra value was stored on function entry. When you restored it to ra and
did a jr ra, you put the value in the pc register.

One possible cause is a stack overflow. This is unlikely, but I've seen
drivers put big enough buffers on the stack that it intruded into the
thread_info area. This causes all sorts of badness to happen.

> (Why do people use non-zero starting addresses for memory?  Handling of
> cache error exceptions is hard enough as it is but with no memory in the
> low 32k the design idea of the cache architecture that stores relative to
> $zero can be used goes down the drain and (not considering platform-specific
> solutions here) only be handled by burning the scarce resource of a TLB
> entry for an extremly rare event ...)

(Because hardware people are, uh, insufficiently acquainted with the MIPS
architecture and don't know what the conventions are. Or why they are that
way. Then, you're stuck with that architecture forever. Sigh.)

>   Ralf

David VomLehn
