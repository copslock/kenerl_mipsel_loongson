Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jan 2004 13:49:47 +0000 (GMT)
Received: from p508B6B36.dip.t-dialin.net ([IPv6:::ffff:80.139.107.54]:30238
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225203AbUATNtr>; Tue, 20 Jan 2004 13:49:47 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i0KDnjex024978;
	Tue, 20 Jan 2004 14:49:45 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i0KDni8B024971;
	Tue, 20 Jan 2004 14:49:44 +0100
Date: Tue, 20 Jan 2004 14:49:44 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Samium Gromoff <deepfire@sic-elvis.zel.ru>
Cc: linux-mips@linux-mips.org
Subject: Re: a shared cache_op() macros?
Message-ID: <20040120134944.GA24044@linux-mips.org>
References: <87hdyqvjh2.wl@canopus.ns.zel.ru> <87fzeaviqx.wl@canopus.ns.zel.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fzeaviqx.wl@canopus.ns.zel.ru>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4062
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 20, 2004 at 04:42:46PM +0300, Samium Gromoff wrote:

> While pondering for some generic mips cache initialisation routines, i
> have found a precious cache_op() macro in mm/r5k-sc.c.
> 
> And the question is, why isn`t it shared amongst all of the implementations
> which could make use of it?
> 
> regards, Samium Gromoff

You're looking at an ancient tree; this has long been done.

  Ralf
