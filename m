Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Mar 2003 15:41:11 +0000 (GMT)
Received: from p508B7A20.dip.t-dialin.net ([IPv6:::ffff:80.139.122.32]:24013
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225202AbTCEPlK>; Wed, 5 Mar 2003 15:41:10 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h25Feae12170;
	Wed, 5 Mar 2003 16:40:36 +0100
Date: Wed, 5 Mar 2003 16:40:36 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Santosh <ipv6_san@rediffmail.com>
Cc: Yogish Patil <yogishpatila@rediffmail.com>,
	linux-mips@linux-mips.org
Subject: Re: glibc-2.2.1 problems for mips-linux
Message-ID: <20030305164036.A10407@linux-mips.org>
References: <20030305094246.6797.qmail@webmail17.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030305094246.6797.qmail@webmail17.rediffmail.com>; from ipv6_san@rediffmail.com on Wed, Mar 05, 2003 at 09:42:46AM -0000
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1630
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Mar 05, 2003 at 09:42:46AM -0000, Santosh  wrote:

> Try this link ftp://ftp.linux-mips.org/pub/linux/mips/glibc/

Don't.  That's over two year old stuff and almost implies a guarantee to
make you unhappy.  Recompiling libc requires fairly complex setup in
particular when crosscompiling so the strong recommendation is to use
the binaries of your favorite Linux distribution.

  Ralf
