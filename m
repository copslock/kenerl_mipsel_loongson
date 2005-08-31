Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Aug 2005 16:19:54 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:36883 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225326AbVHaPTe>; Wed, 31 Aug 2005 16:19:34 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j7VFPbe6007894;
	Wed, 31 Aug 2005 16:25:37 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j7VFPb8G007893;
	Wed, 31 Aug 2005 16:25:37 +0100
Date:	Wed, 31 Aug 2005 16:25:37 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thiemo Seufer <ths@networkno.de>
Cc:	Damian Dimmich <djd20@kent.ac.uk>, linux-mips@linux-mips.org
Subject: Re: compiling kernel 2.6.13
Message-ID: <20050831152537.GE3377@linux-mips.org>
References: <200508311459.47273.djd20@kent.ac.uk> <20050831151223.GV21717@hattusa.textio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050831151223.GV21717@hattusa.textio>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8841
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Aug 31, 2005 at 05:12:23PM +0200, Thiemo Seufer wrote:

> You could try the patch in http://people.debian.org/~ths/foo/ip22-eisa.diff
> which fixes that problem. I don't have the hardware to test it, and so far
> nobody else cared to tell me if works.

At least it looks like an improvment and since it's probably save to
consider the current IP22 EISA code as broken I wouldn't mind if you want
to check this one in ...

  Ralf
