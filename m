Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Oct 2004 18:36:52 +0100 (BST)
Received: from p508B7611.dip.t-dialin.net ([IPv6:::ffff:80.139.118.17]:8997
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225238AbUJSRgp>; Tue, 19 Oct 2004 18:36:45 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i9JHaiIt021253;
	Tue, 19 Oct 2004 19:36:44 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i9JHaiXn021252;
	Tue, 19 Oct 2004 19:36:44 +0200
Date: Tue, 19 Oct 2004 19:36:44 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org
Subject: Re: sdc1 $f0 in r4k_switch.S
Message-ID: <20041019173644.GA21132@linux-mips.org>
References: <20041007.130538.71082967.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041007.130538.71082967.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6107
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 07, 2004 at 01:05:38PM +0900, Atsushi Nemoto wrote:

> I found a bug in resume() in 2.6 kernel.  $f0 register may not be
> saved on context switch in 64bit kernel.  Here is a quick fix.

But we compensate for not storing $f0 by restoring it twice ;-)

> Or moving "sdc1 $f0" to fpu_save_16even might be better fix.

And while we're at it eleminating the special handling for
CONFIG_MIPS32 / CONFIG_MIPS64.


  Ralf
