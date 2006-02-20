Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Feb 2006 13:00:39 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:27910 "EHLO
	bacchus.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133433AbWBUNA3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 21 Feb 2006 13:00:29 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.4/8.13.4) with ESMTP id k1LD5eiu018985;
	Tue, 21 Feb 2006 13:05:46 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k1KLtV64027895;
	Mon, 20 Feb 2006 21:55:31 GMT
Date:	Mon, 20 Feb 2006 21:55:31 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	linux-mips@linux-mips.org, jblache@debian.org
Subject: Re: IP22 doesn't shutdown properly
Message-ID: <20060220215531.GA27383@linux-mips.org>
References: <20060217225824.GE20785@deprecation.cyrius.com> <20060219165245.GD21416@linux-mips.org> <20060220181227.GA17439@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060220181227.GA17439@deprecation.cyrius.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10595
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 20, 2006 at 06:12:27PM +0000, Martin Michlmayr wrote:
> Date:	Mon, 20 Feb 2006 18:12:27 +0000
> From:	Martin Michlmayr <tbm@cyrius.com>
> To:	Ralf Baechle <ralf@linux-mips.org>
> Cc:	linux-mips@linux-mips.org, jblache@debian.org
> Subject: Re: IP22 doesn't shutdown properly
> Content-Type: text/plain; charset=us-ascii
> 
> * Ralf Baechle <ralf@linux-mips.org> [2006-02-19 16:52]:
> > > beginning, the light on the Indy is green but after about 20 seconds
> > > it turns red.  Nothing happens on the console and the machine doesn't
> > > turn off.  Seen on Indy and Indigo2.
> > > Anyone got a fix?
> > No.  Do you know when this problems started?
> 
> A long time ago, it seems.  I can trace it back to 2.6.9;
> unfortunately I don't get any older kernel to run/compile, possibily
> because my toolchain isn't old enough (I even installed the SDE that's
> based on 3.3).
> 
> Here's what I got:
> 
> 2.6.15 - broken
> 2.6.14 - broken
> 2.6.13 - broken
> 2.6.10 - broken
> 2.6.9 - broken
> 2.6.8 - hangs after download (SDE)
> 2.6.6 - hangs after download (SDE)
> 2.6.5 - hangs after download (SDE)
> 2.6.4 - hangs after download (SDE)
> 2.6.3 - fails to load with: Text start 0x8000000, size 0x25e998 doesn't
>           fit in a FreeMemory area.

Somehow this all sounds suspicious.  I ran at least a few of those kernels
on my own Indy.

> 2.6.1 - doesn't compile

Okay, I had to try this one.  Clear case of bitrot.  Don't use fancy
new compilers with that kernel, it doesn't like them.

  Ralf
