Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Jan 2003 12:45:22 +0000 (GMT)
Received: from p508B799F.dip.t-dialin.net ([IPv6:::ffff:80.139.121.159]:13763
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225229AbTAVMpV>; Wed, 22 Jan 2003 12:45:21 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h0MCj6J13676;
	Wed, 22 Jan 2003 13:45:06 +0100
Date: Wed, 22 Jan 2003 13:45:06 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Christoph Hellwig <hch@sgi.com>
Cc: Andrew Clausen <clausen@melbourne.sgi.com>,
	linux-mips@linux-mips.org, gnb@melbourne.sgi.com
Subject: Re: debian's mips userland on mips64
Message-ID: <20030122134506.A12847@linux-mips.org>
References: <20030122073006.GF6262@pureza.melbourne.sgi.com> <20030122124540.A31505@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030122124540.A31505@sgi.com>; from hch@sgi.com on Wed, Jan 22, 2003 at 12:45:40PM -0500
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1204
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jan 22, 2003 at 12:45:40PM -0500, Christoph Hellwig wrote:

> I don't think so.  You should rather implement a sys32_ptrace and
> reference it in the 32bit syscall vector.  Look at the version in
> arch/ia64/ia32/sys_ia32.c for an example.

There is a 32-bit ptrace compatibility syscall already and last I tried
it was working quite well for strace.

  Ralf
