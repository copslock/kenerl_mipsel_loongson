Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Sep 2004 00:35:56 +0100 (BST)
Received: from p508B68F0.dip.t-dialin.net ([IPv6:::ffff:80.139.104.240]:42033
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225218AbUIAXfw>; Thu, 2 Sep 2004 00:35:52 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i81NZpe1007215;
	Thu, 2 Sep 2004 01:35:51 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i81NZour007214;
	Thu, 2 Sep 2004 01:35:50 +0200
Date: Thu, 2 Sep 2004 01:35:50 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Dominic Sweetman <dom@mips.com>
Cc: Emmanuel Michon <em@realmagic.fr>, linux-mips@linux-mips.org
Subject: Re: TLB dimensioning
Message-ID: <20040901233550.GA5721@linux-mips.org>
References: <1094033224.20643.1402.camel@nikita.france.sdesigns.com> <16693.52862.859233.198626@doms-laptop.algor.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16693.52862.859233.198626@doms-laptop.algor.co.uk>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5765
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Sep 01, 2004 at 02:28:30PM +0100, Dominic Sweetman wrote:

> 1. Your application has a non-trivial user space of any size;
> 
> 2. The performance of userland code is significant;

The kernel's performance also relies on TLB performance.

The wired register is making it easy to test performance of kernel and
application with a reduced size TLB; maybe I should make that a kernel
feature.

  Ralf
