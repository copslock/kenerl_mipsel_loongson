Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Feb 2004 14:30:58 +0000 (GMT)
Received: from p508B5CC5.dip.t-dialin.net ([IPv6:::ffff:80.139.92.197]:62811
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225375AbUBYOa5>; Wed, 25 Feb 2004 14:30:57 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i1PEUuex015552;
	Wed, 25 Feb 2004 15:30:56 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i1PEUrQ8015551;
	Wed, 25 Feb 2004 15:30:53 +0100
Date: Wed, 25 Feb 2004 15:30:53 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Joost <Joost@stack.nl>
Cc: linux-mips@linux-mips.org
Subject: Re: fore atm card in indy?
Message-ID: <20040225143053.GC19555@linux-mips.org>
References: <Pine.LNX.4.58.0402181631050.30510@brilsmurf.chem.tue.nl> <20040220142138.GD23404@linux-mips.org> <20040223204649.GF1046@mind.be> <Pine.LNX.4.58.0402241658390.21389@brilsmurf.chem.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402241658390.21389@brilsmurf.chem.tue.nl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4438
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Feb 24, 2004 at 05:03:19PM +0100, Joost wrote:

> > There is already a driver for the PCI and SBUS versions of this card. It
> > lives in drivers/atm/fore200e*. You 'only' need to add code for the
> > GIO32 specifics.
> 
> Thank you both for your answer. I've only taken a quick
> peek, and got rather scared :-) Maybe I'll try again
> when I have more time (exams coming up).

One of the running gags on ATM is it actually stands for A Terrible Mess ;-)

  Ralf
