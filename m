Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 31 Jan 2004 03:04:42 +0000 (GMT)
Received: from p508B68A1.dip.t-dialin.net ([IPv6:::ffff:80.139.104.161]:6677
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225490AbUAaDEl>; Sat, 31 Jan 2004 03:04:41 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i0V34aex024697;
	Sat, 31 Jan 2004 04:04:37 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i0V34aPw024693;
	Sat, 31 Jan 2004 04:04:36 +0100
Date: Sat, 31 Jan 2004 04:04:35 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Kumba <kumba@gentoo.org>
Cc: linux-mips@linux-mips.org
Subject: Re: linux 2.4 and Indy
Message-ID: <20040131030435.GA24228@linux-mips.org>
References: <20040129102215.GC17760@ballina> <4018E322.9030801@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4018E322.9030801@gentoo.org>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4209
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jan 29, 2004 at 05:40:34AM -0500, Kumba wrote:

> Check out a cvs tree no later than 12/11/2003, a change in CVS after 
> that date seems to have nuked r4k kernels.  It is believed the change in 
> question is:
> 
> http://www.linux-mips.org/archives/linux-cvs/2003-12/msg00031.html
> 
> I've not yet been able to find a 'clean' way to remove the changes to 
> those specific files in that commit while keeping all the changes made 
> afterwards intact to test this idea.

Over the past days a few fixes went into CVS, the last only a few minutes
ago.  Can you retry and let me know?

  Ralf
