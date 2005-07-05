Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jul 2005 21:03:16 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:14093 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8226290AbVGEUC5>; Tue, 5 Jul 2005 21:02:57 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j65K3Aj5029278;
	Tue, 5 Jul 2005 21:03:10 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j65K3969029277;
	Tue, 5 Jul 2005 21:03:09 +0100
Date:	Tue, 5 Jul 2005 21:03:09 +0100
From:	Ralf Baechle DL5RB <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	djohnson+linuxmips@sw.starentnetworks.com,
	linux-mips@linux-mips.org
Subject: Re: preempt_schedule_irq missing from mfinfo[]?
Message-ID: <20050705200308.GE18772@linux-mips.org>
References: <17092.5345.75666.403044@cortez.sw.starentnetworks.com> <20050701.114358.21591461.nemoto@toshiba-tops.co.jp> <17093.19241.353160.946039@cortez.sw.starentnetworks.com> <20050703.005921.25910131.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050703.005921.25910131.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8354
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Jul 03, 2005 at 12:59:21AM +0900, Atsushi Nemoto wrote:

> Ralf, how do you think about this?

If the WCHAN column of ps axl is supposed to be any useful we need to
unwind the stack until we find the caller of the sleeping or scheduling
function.  Very useful for debugging.

  Ralf
