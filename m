Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Apr 2004 03:57:14 +0100 (BST)
Received: from p508B780A.dip.t-dialin.net ([IPv6:::ffff:80.139.120.10]:52515
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225754AbUDOC5L>; Thu, 15 Apr 2004 03:57:11 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i3F2v8xr028364;
	Thu, 15 Apr 2004 04:57:08 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i3F2v8UX028363;
	Thu, 15 Apr 2004 04:57:08 +0200
Date: Thu, 15 Apr 2004 04:57:08 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Ashley Evans <ashley@seamlessrecruitment.com>
Cc: linux-mips@linux-mips.org
Subject: Re: R4400MC
Message-ID: <20040415025708.GA27738@linux-mips.org>
References: <407BC212.8000303@seamlessrecruitment.com> <20040414125200.GA9206@linux-mips.org> <407D5CDA.6070407@seamlessrecruitment.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <407D5CDA.6070407@seamlessrecruitment.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4785
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Apr 14, 2004 at 04:46:34PM +0100, Ashley Evans wrote:

> Thanks, just thought I'd ask.
> 
> I believe it's the cache controller that's the problem? I don't have the 
> skills to do it myself but if somebody could explain the issue i'd like 
> to know?

No, the cache controller is really the same as in the SC CPU which is
already supported.  The problem is everything else around the CPU ...

  Ralf
