Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Dec 2004 14:19:05 +0000 (GMT)
Received: from pD9562F66.dip.t-dialin.net ([IPv6:::ffff:217.86.47.102]:47891
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225011AbULOOTB>; Wed, 15 Dec 2004 14:19:01 +0000
Received: from fluff.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id iBFEIoc0029338;
	Wed, 15 Dec 2004 15:18:50 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id iBFEInBa029337;
	Wed, 15 Dec 2004 15:18:49 +0100
Date: Wed, 15 Dec 2004 15:18:49 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Jon Anders Haugum <jonah@omegav.ntnu.no>
Cc: linux-mips@linux-mips.org
Subject: Re: HIGHMEM
Message-ID: <20041215141849.GC29222@linux-mips.org>
References: <003801c4dc45$f9212690$2203a8c0@qfree.com> <20041207112038.X44387@invalid.ed.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041207112038.X44387@invalid.ed.ntnu.no>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6671
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Dec 07, 2004 at 11:29:04AM +0100, Jon Anders Haugum wrote:

> What about on a processor like the AMD au1550?
> 
> I've tried the latest from 2.4 branch in cvs, and I haven't been 
> successful in geting past INIT either...
> 
> Can I place all the memory from address 0x20000000 to get more than 
> 256Meg?

Yes, that should just work on Alchemy.

  Ralf
