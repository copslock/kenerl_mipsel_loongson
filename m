Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jan 2003 12:15:51 +0000 (GMT)
Received: from p508B634D.dip.t-dialin.net ([IPv6:::ffff:80.139.99.77]:2713
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225198AbTAOMPv>; Wed, 15 Jan 2003 12:15:51 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h0FCFoG27569
	for linux-mips@linux-mips.org; Wed, 15 Jan 2003 13:15:50 +0100
Date: Wed, 15 Jan 2003 13:15:50 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: linux-mips@linux-mips.org
Subject: Re: insmod failure: "Unhandled relocation" errors
Message-ID: <20030115131550.A27412@linux-mips.org>
References: <001801c2bbb4$a6177de0$7100000a@riverhead.com> <20030114191417.GA1243@wumpus.internal.keyresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030114191417.GA1243@wumpus.internal.keyresearch.com>; from lindahl@keyresearch.com on Tue, Jan 14, 2003 at 11:14:18AM -0800
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1156
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 14, 2003 at 11:14:18AM -0800, Greg Lindahl wrote:

> > I am now trying to insert a module, a standard module from
> > the kernel tree, and get lots of errors such as:
> > "Unhandled relocation of type 18 for"
> > or
> > "Unhandled relocation of type 18 for <function_name>"
> 
> I'm impressed that it got this far -- let me guess, big endian?
> Little endian didn't even get that far last time I tried it.

The modules we also built with the wrong options which is the cause for
these specific error messages.  There was just no point mentioning these
because the actual showstopper was a 32-bit vs. 64-bit problem.

  Ralf
