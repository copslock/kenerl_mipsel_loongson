Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Jan 2003 13:46:20 +0000 (GMT)
Received: from p508B705C.dip.t-dialin.net ([IPv6:::ffff:80.139.112.92]:14723
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225976AbTACNqT>; Fri, 3 Jan 2003 13:46:19 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h03DkFE08978;
	Fri, 3 Jan 2003 14:46:15 +0100
Date: Fri, 3 Jan 2003 14:46:15 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Pete Popov <ppopov@mvista.com>
Cc: linux-mips <linux-mips@linux-mips.org>
Subject: Re: unaligned handler problem
Message-ID: <20030103144615.A8482@linux-mips.org>
References: <1041589762.18883.4.camel@adsl.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1041589762.18883.4.camel@adsl.pacbell.net>; from ppopov@mvista.com on Fri, Jan 03, 2003 at 02:29:22AM -0800
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1082
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jan 03, 2003 at 02:29:22AM -0800, Pete Popov wrote:

> The changes betwen rev 1.23 and 1.24 in unaligned.c, to replace
> check_axs() with verify_area(), causes any unaligned access from within
> a kernel module to crash. access_ok() returns -EFAULT as the
> __access_mask is 0xffffffff so __access_ok evaluates to > 0.  It's too
> late for me to look into it any further but perhaps the problem will be
> obvious to someone else. I'm not sure what get_fs() should return in
> this case (again, the access is from within a kernel module) but it
> returns 0xffffffff.

The address error handler should do something like:

	mm_segment_t seg;

	seg = get_fs();
	if (!user_mode(regs))
		set_fs(KERNEL_DS);

	... usual unaligned stuff goes here ...

	set_fs(seg);

  Ralf
