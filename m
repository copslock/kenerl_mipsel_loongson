Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jan 2006 12:49:15 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:53020 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133598AbWARMs6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 18 Jan 2006 12:48:58 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.4) with ESMTP id k0ICpSlV022936;
	Wed, 18 Jan 2006 12:51:28 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k0ICpR1L022935;
	Wed, 18 Jan 2006 12:51:27 GMT
Date:	Wed, 18 Jan 2006 12:51:27 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Martin Michlmayr <tbm@cyrius.com>, linux-mips@linux-mips.org
Subject: Re: CONFIG_64BIT and CONFIG_BUILD_ELF64
Message-ID: <20060118125127.GA3555@linux-mips.org>
References: <20060118123110.GA21786@deprecation.cyrius.com> <Pine.LNX.4.64N.0601181240090.18424@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0601181240090.18424@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9961
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jan 18, 2006 at 12:42:25PM +0000, Maciej W. Rozycki wrote:

> On Wed, 18 Jan 2006, Martin Michlmayr wrote:
> 
> > Is there a good reason why CONFIG_64BIT does not activate
> > CONFIG_BUILD_ELF64 automatically?
> 
>  It works with some old toolchains and apparently there are people who 
> want this feature.  Please feel free to propose a patch to add such a 
> dependency and see if there are any objections.

At this stage support for gcc 2.95 is decaying and soon may be removed
entirely from the kernel.  So the time to hardwire CONFIG_BUILD_ELF64=y
may have come.

  Ralf
