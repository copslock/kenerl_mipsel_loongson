Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Apr 2003 13:33:15 +0100 (BST)
Received: from p508B5469.dip.t-dialin.net ([IPv6:::ffff:80.139.84.105]:44714
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225278AbTDPMdP>; Wed, 16 Apr 2003 13:33:15 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h3GCXDi09060;
	Wed, 16 Apr 2003 14:33:13 +0200
Date: Wed, 16 Apr 2003 14:33:13 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Ladislav Michl <ladis@linux-mips.org>
Cc: linux-mips@linux-mips.org
Subject: Re: r4400 cache code speed
Message-ID: <20030416143313.A7703@linux-mips.org>
References: <20030416110202.GA2319@simek>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030416110202.GA2319@simek>; from ladis@linux-mips.org on Wed, Apr 16, 2003 at 01:02:02PM +0200
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2076
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Apr 16, 2003 at 01:02:02PM +0200, Ladislav Michl wrote:

> make vmlinux on current cvs tree
> 
> 2.4.19-rc1
> real    40m32.394s
> user    37m48.550s
> sys     2m13.350s
> cvs current
> real    41m14.253s
> user    37m39.880s
> sys     3m6.730s

This really comes as a surprise.  You have lost about as much performance
as other people have won.  I wonder if that is related to you using the
R4400SC which along with it's older brother R4000SC still is a major
special case in the cache code.

  Ralf
