Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Dec 2002 14:13:18 +0000 (GMT)
Received: from p508B7BBE.dip.t-dialin.net ([80.139.123.190]:34989 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225268AbSLLONR>; Thu, 12 Dec 2002 14:13:17 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id gBCED8j07655;
	Thu, 12 Dec 2002 15:13:08 +0100
Date: Thu, 12 Dec 2002 15:13:08 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Jun Sun <jsun@mvista.com>
Cc: Carsten Langgaard <carstenl@mips.com>, linux-mips@linux-mips.org
Subject: Re: Cache routine patch
Message-ID: <20021212151308.C6657@linux-mips.org>
References: <3DF719D0.658530E2@mips.com> <20021211090635.C6755@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021211090635.C6755@mvista.com>; from jsun@mvista.com on Wed, Dec 11, 2002 at 09:06:35AM -0800
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 886
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Dec 11, 2002 at 09:06:35AM -0800, Jun Sun wrote:

> Part of you patches fixes an off-by-one problem in flushing
> cache for a range of addresses.  I have a different version
> for that part which is a little more visually pleasing.
> 
> See attachment.

In case you were wondering why the whole loop construction is looking so
odd, take a look at the compiler output.  The loop construction I've
choosen is the only one that's producing bearable code.  Sad to see that
gcc is producing crap code from such a trivial loop ...

   Ralf
