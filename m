Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Jul 2005 15:33:58 +0100 (BST)
Received: from mra03.ex.eclipse.net.uk ([IPv6:::ffff:212.104.129.88]:64654
	"EHLO mra03.ex.eclipse.net.uk") by linux-mips.org with ESMTP
	id <S8226358AbVGHOdi>; Fri, 8 Jul 2005 15:33:38 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mra03.ex.eclipse.net.uk (Postfix) with ESMTP id D76C72E2B74
	for <linux-mips@linux-mips.org>; Fri,  8 Jul 2005 15:34:10 +0100 (BST)
Received: from mra03.ex.eclipse.net.uk ([127.0.0.1])
 by localhost (mra03.ex.eclipse.net.uk [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 09127-01-49 for <linux-mips@linux-mips.org>;
 Fri,  8 Jul 2005 15:34:10 +0100 (BST)
Received: from euskadi.packetvision (unknown [82.152.104.245])
	by mra03.ex.eclipse.net.uk (Postfix) with ESMTP id 337A52E2C16
	for <linux-mips@linux-mips.org>; Fri,  8 Jul 2005 15:34:02 +0100 (BST)
Subject: Re: Benchmarking RM9000
From:	Alex Gonzalez <alex.gonzalez@packetvision.com>
To:	linux-mips@linux-mips.org
Content-Type: text/plain
Message-Id: <1120833353.28569.957.camel@euskadi.packetvision>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date:	Fri, 08 Jul 2005 15:35:54 +0100
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: by Eclipse VIRUSshield at eclipse.net.uk
Return-Path: <alex.gonzalez@packetvision.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8410
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex.gonzalez@packetvision.com
Precedence: bulk
X-list: linux-mips

My understanding of these numbers is that they all refer to the target
under test.

So for that specific test, the target is 9.24 times quicker than a base
Pentium 90 and 3.04 times quicker than a AMD K6.

That makes the AMD three times quicker than the Pentium 90.

But then, I might have been trying to make sense of the numbers as it is
not clear enough in the documentation.

Alex

On Fri, 2005-07-08 at 14:54, Laurence Darby wrote:
> Alex Gonzalez wrote:
> 
> > Hi,
> > 
> > I am doing some basic benchmarking tests on our RM9000 based platform,
> > running on just one of the two cores (non-smp kernel).
> 
> <snip>
> 
> > TEST                : Iterations/sec.  : Old Index   : New Index
> >                     :                  : Pentium 90* : AMD K6/233*
> > --------------------:------------------:-------------:------------>
> > NUMERIC SORT        :          360.48  :       9.24  :       3.04
> 
> 
> I'd expect a K6 to be able to do more Iterations per second than a
> Pentium 90, not fewer. 
> 
> 
> Laurence
