Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2003 06:28:59 +0000 (GMT)
Received: from p508B6ED0.dip.t-dialin.net ([IPv6:::ffff:80.139.110.208]:51339
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225201AbTA0G26>; Mon, 27 Jan 2003 06:28:58 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h0R6Svc13704
	for linux-mips@linux-mips.org; Mon, 27 Jan 2003 07:28:57 +0100
Date: Mon, 27 Jan 2003 07:28:57 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
Message-ID: <20030127072857.A13629@linux-mips.org>
References: <20030126173616Z8225206-1272+297@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030126173616Z8225206-1272+297@linux-mips.org>; from macro@linux-mips.org on Sun, Jan 26, 2003 at 05:36:11PM +0000
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1224
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Jan 26, 2003 at 05:36:11PM +0000, macro@linux-mips.org wrote:

> Modified files:
> 	include/asm-mips: Tag: linux_2_4 checksum.h 
> 	include/asm-mips64: Tag: linux_2_4 checksum.h 
> 
> Log message:
> 	Fix a restoration of assembler's settings in csum_ipv6_magic().

Wow, how did you catch this one - running IPv6?

  Ralf
