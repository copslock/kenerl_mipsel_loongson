Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Aug 2005 16:29:21 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:63518 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225326AbVHaP3B>; Wed, 31 Aug 2005 16:29:01 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j7VFZAgM008235;
	Wed, 31 Aug 2005 16:35:10 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j7VFZAHk008234;
	Wed, 31 Aug 2005 16:35:10 +0100
Date:	Wed, 31 Aug 2005 16:35:10 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Stephen P. Becker" <geoman@gentoo.org>
Cc:	"'Linux/MIPS Development'" <linux-mips@linux-mips.org>
Subject: Re: compiling kernel 2.6.13
Message-ID: <20050831153509.GF3377@linux-mips.org>
References: <200508311459.47273.djd20@kent.ac.uk> <20050831150256.GC3377@linux-mips.org> <4315CD1C.80203@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4315CD1C.80203@gentoo.org>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8843
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Aug 31, 2005 at 11:30:36AM -0400, Stephen P. Becker wrote:

> >Daring.  Hardly anybody is using EISA on that machine and even less so on
> >64-bit, expect to find bugs.
> 
> Furthermore, 64-bit kernels are somewhat broken on ip22 right now. 
> Something is wrong with memory allocation, and it really screws a lot of 
> things up.  Off the top of my head, you won't be able to turn on swap, 
> mount a ricerfs partition, or dd large blocks from /dev/zero.  You would 
> be much better of sticking with 32-bit at this time.

But that seems an IP22-specific problem.

  Ralf
