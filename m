Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Oct 2004 04:18:31 +0100 (BST)
Received: from p508B6D7E.dip.t-dialin.net ([IPv6:::ffff:80.139.109.126]:11053
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224907AbUJTDS0>; Wed, 20 Oct 2004 04:18:26 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i9K3IF40014932;
	Wed, 20 Oct 2004 05:18:15 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i9K3IDAA014931;
	Wed, 20 Oct 2004 05:18:13 +0200
Date: Wed, 20 Oct 2004 05:18:13 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org,
	Dominic Sweetman <dom@mips.com>,
	Nigel Stephens <nigel@mips.com>
Subject: Re: [patch] glibc 2.3: Memory clobber missing from syscalls
Message-ID: <20041020031813.GA13811@linux-mips.org>
References: <Pine.LNX.4.61.0410151318550.8084@perivale.mips.com> <20041018.103737.74754888.nemoto@toshiba-tops.co.jp> <Pine.LNX.4.58L.0410200227140.13131@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0410200227140.13131@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6111
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 20, 2004 at 04:05:40AM +0100, Maciej W. Rozycki wrote:

>  Ralf, may I ask for approval?  Please -- this has waited for too long 
> already IMHO...

This looks right, go ahead.  And don't expect any further approvals for
the next 8 hours ;-)

  Ralf
