Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 27 Apr 2003 23:54:16 +0100 (BST)
Received: from p508B65B8.dip.t-dialin.net ([IPv6:::ffff:80.139.101.184]:61635
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225245AbTD0WyM>; Sun, 27 Apr 2003 23:54:12 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h3RMs8013385;
	Mon, 28 Apr 2003 00:54:08 +0200
Date: Mon, 28 Apr 2003 00:54:08 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Guido Guenther <agx@sigxcpu.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH]: asm-mips/sgi/mc.h register padding broken
Message-ID: <20030428005408.A13382@linux-mips.org>
References: <20030427144730.GB24352@bogon.ms20.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030427144730.GB24352@bogon.ms20.nix>; from agx@sigxcpu.org on Sun, Apr 27, 2003 at 04:47:30PM +0200
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Spam-Checker-Version: SpamAssassin 2.50 (1.173-2003-02-20-exp)
X-archive-position: 2210
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Apr 27, 2003 at 04:47:30PM +0200, Guido Guenther wrote:

> the register layout of the IP22s mc is missing some paddings which
> results in some nice bus error exceptions. Please apply this patch
> against 2.4. and 2.5:

Applied,

  Ralf
