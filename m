Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 31 Jan 2004 16:58:44 +0000 (GMT)
Received: from p508B577C.dip.t-dialin.net ([IPv6:::ffff:80.139.87.124]:18719
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225512AbUAaQ6o>; Sat, 31 Jan 2004 16:58:44 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i0VGwcex025797;
	Sat, 31 Jan 2004 17:58:38 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i0VGwaIY025796;
	Sat, 31 Jan 2004 17:58:36 +0100
Date: Sat, 31 Jan 2004 17:58:36 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
Cc: linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][2.6] Changed machine_restart/halt/power_off for vr41xx
Message-ID: <20040131165836.GA25563@linux-mips.org>
References: <20040131192543.1eb7b88d.yuasa@hh.iij4u.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040131192543.1eb7b88d.yuasa@hh.iij4u.or.jp>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4212
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Jan 31, 2004 at 07:25:43PM +0900, Yoichi Yuasa wrote:

> I made the patch for machine_restart/halt/power_off for vr41xx.
> This patch updates these functions.
> 
> I am going to add power management to pmu.c.
> 
> Please apply this patch to v2.6.

Applied,

  Ralf
