Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Apr 2003 19:46:02 +0100 (BST)
Received: from p508B4F51.dip.t-dialin.net ([IPv6:::ffff:80.139.79.81]:29397
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225072AbTDRSqB>; Fri, 18 Apr 2003 19:46:01 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h3IIjse05090;
	Fri, 18 Apr 2003 20:45:54 +0200
Date: Fri, 18 Apr 2003 20:45:53 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
Cc: linux-mips@linux-mips.org
Subject: Re: simulate_ll and simulate_sc move to do_cpu from do_ri
Message-ID: <20030418204553.A29634@linux-mips.org>
References: <20030418181748.57f7789a.yuasa@hh.iij4u.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030418181748.57f7789a.yuasa@hh.iij4u.or.jp>; from yuasa@hh.iij4u.or.jp on Fri, Apr 18, 2003 at 06:17:48PM +0900
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2107
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Apr 18, 2003 at 06:17:48PM +0900, Yoichi Yuasa wrote:

> Why did you move simulate_ll and simulate_sc to do_cpu from do_ri?
> NEC VR4100 series need simulate_ll and simulate_sc in do_ri.

As the CVS comment said ll is using the opcode for lwc0 and sc the opcode
for swc0 so the expected behaviour of an attempt to execute ll or sc on a
ll/sc-less processor is throwing a coprocessor unusable exception, not
reserved exception.

So if the VR4100 series is indeed throwing RI exceptions then this processor
is plain broken.  Will fix but not without cursing into NEC's direction.

Grr...

  Ralf
