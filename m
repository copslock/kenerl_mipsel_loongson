Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jan 2006 15:27:55 +0000 (GMT)
Received: from extgw-uk.mips.com ([62.254.210.129]:3867 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8134428AbWAIP1h (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 9 Jan 2006 15:27:37 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.4) with ESMTP id k09FUS1L006702;
	Mon, 9 Jan 2006 15:30:28 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k09FUSP4006701;
	Mon, 9 Jan 2006 15:30:28 GMT
Date:	Mon, 9 Jan 2006 15:30:28 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Kevin D. Kissell" <kevink@mips.com>
Cc:	Sathesh Babu Edara <satheshbabu.edara@analog.com>,
	linux-mips-bounce@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: LL and SC instruction simulation
Message-ID: <20060109153028.GA6542@linux-mips.org>
References: <200601090742.k097gYaZ017304@lilac.hdcindia.analog.com> <200601090749.k097nFaZ017891@lilac.hdcindia.analog.com> <20060109145425.GA4286@linux-mips.org> <00af01c6152f$dc1863f0$10eca8c0@grendel> <20060109152148.GD4286@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060109152148.GD4286@linux-mips.org>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9817
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jan 09, 2006 at 03:21:48PM +0000, Ralf Baechle wrote:

> > > Only ll/sc instructions in application software can be emulated, so it
> > > would seem your application is behaving different on 2.4 and 2.6 kernels.
> > 
> > Is there an interface where 2.6 might be telling library code to use system calls
> > instead LL/SC, where the 2.4 kernel didn't?
> 
> No.

And I think it's not really worth it.  MIPS II did introduce ll/sc in
1991 and it was becoming widely available with MIPS III and some pseudo-
MIPS II R3000 variants also in the embedded markets and MIPS32/MIPS64
were based on that.  So ll/sc-less processors are a very small part of
the market of Linux/MIPS these days, not really worth to optimize for.

  Ralf
