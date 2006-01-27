Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jan 2006 11:25:57 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:22037 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133357AbWA0LZk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 27 Jan 2006 11:25:40 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.4) with ESMTP id k0RBU4bL005017;
	Fri, 27 Jan 2006 11:30:04 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k0RBU3pM005016;
	Fri, 27 Jan 2006 11:30:03 GMT
Date:	Fri, 27 Jan 2006 11:30:03 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Kevin D. Kissell" <kevink@mips.com>
Cc:	Franck <vagabon.xyz@gmail.com>, Nigel Stephens <nigel@mips.com>,
	linux-mips@linux-mips.org
Subject: Re: [RFC] Optimize swab operations on mips_r2 cpu
Message-ID: <20060127113003.GA3497@linux-mips.org>
References: <43D7C050.5090607@mips.com> <cda58cb80601260702wf781e70l@mail.gmail.com> <005101c6228c$6ebfb0a0$10eca8c0@grendel> <43D8F000.9010106@mips.com> <cda58cb80601260831i61167787g@mail.gmail.com> <43D8FF16.40107@mips.com> <cda58cb80601261002w6eb02249k@mail.gmail.com> <43D93025.9040800@mips.com> <cda58cb80601270103t1419117cq@mail.gmail.com> <000b01c6232a$5ea81470$10eca8c0@grendel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000b01c6232a$5ea81470$10eca8c0@grendel>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10204
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jan 27, 2006 at 11:13:44AM +0100, Kevin D. Kissell wrote:

> Configuration hacks that are specific to a single core create cruft and
> maintenence problems.  As I said yesterday, I think we'd be much better
> off to have a CONFIG_CPU_MIPS_SMALL or some such option
> that could cause -Os to be used, allow branch-likelies, etc.

There is already CONFIG_CC_OPTIMIZE_FOR_SIZE.

Unfortunately gcc has begun to avoid gcc totally since it was marked
"deprecated" in the architecture spec even though in the real world
branch likely often is a win.

  Ralf
