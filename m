Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Nov 2002 19:48:09 +0100 (CET)
Received: from p508B6D85.dip.t-dialin.net ([80.139.109.133]:57503 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S1122118AbSKNSsJ>; Thu, 14 Nov 2002 19:48:09 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id gAEIls508150;
	Thu, 14 Nov 2002 19:47:54 +0100
Date: Thu, 14 Nov 2002 19:47:54 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Brian Murphy <brian@murphy.dk>
Cc: Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: rsync suggestion
Message-ID: <20021114194754.B5610@linux-mips.org>
References: <3DA1E42C.3050900@murphy.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DA1E42C.3050900@murphy.dk>; from brian@murphy.dk on Mon, Oct 07, 2002 at 09:44:44PM +0200
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 643
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 07, 2002 at 09:44:44PM +0200, Brian Murphy wrote:

> Is there any chance, Ralf, of an rsync server for the kernel cvs?
> This  really speeds up making diffs and so on and removes load
> from the central cvs server.

Load is hardly an argument.  The machine has 2GB of memory so can keep the
entire CVS archive in memory which extremly speeds up operation.  Anyway,
I rsync of the cvs archive was disabled from the time that the archive
was just an outdated copy of oss; now I re-enabled it.

  Ralf
