Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Oct 2004 13:22:05 +0100 (BST)
Received: from pD956212F.dip.t-dialin.net ([IPv6:::ffff:217.86.33.47]:58649
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225072AbUJVMWA>; Fri, 22 Oct 2004 13:22:00 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i9MCLkuT028223;
	Fri, 22 Oct 2004 14:21:46 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i9MCLkbC028222;
	Fri, 22 Oct 2004 14:21:46 +0200
Date: Fri, 22 Oct 2004 14:21:46 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Ladislav Michl <ladis@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 2.6.9] KSEG/CKSEG fixes
Message-ID: <20041022122146.GB27961@linux-mips.org>
References: <20041021001427.GA25441@smtp.west.cox.net> <20041021070921.GA2297@umax645sx> <20041021144815.GB25441@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041021144815.GB25441@smtp.west.cox.net>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6175
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 21, 2004 at 07:48:15AM -0700, Tom Rini wrote:

> Would this include abstracting the notion of KSEG1/CKSEG1 into something
> where one name would get the right var on 32 or 64 ?  If so, is this in
> CVS now?  If not, wouldn't it make sense to put this in now and convert
> it when the changes do go in?

The plan was to use K0BASE / K1BASE and define them as appropriate for
a platform.  KSEG0 / KSEG1 / KSEG2 would always be 32-bit constants and
CKSEG0/1/2 always 64-bit.  Somebody recently screwed the latter with a
checkin.

  Ralf
