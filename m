Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Apr 2003 13:12:23 +0100 (BST)
Received: from p508B5981.dip.t-dialin.net ([IPv6:::ffff:80.139.89.129]:12251
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225208AbTDXMMW>; Thu, 24 Apr 2003 13:12:22 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h3OCCHn24242;
	Thu, 24 Apr 2003 14:12:17 +0200
Date: Thu, 24 Apr 2003 14:12:17 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
Cc: linux-mips@linux-mips.org
Subject: Re: [patch] simulate_llsc
Message-ID: <20030424141217.A23893@linux-mips.org>
References: <20030424162749.325b4533.yuasa@hh.iij4u.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030424162749.325b4533.yuasa@hh.iij4u.or.jp>; from yuasa@hh.iij4u.or.jp on Thu, Apr 24, 2003 at 04:27:49PM +0900
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2162
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Apr 24, 2003 at 04:27:49PM +0900, Yoichi Yuasa wrote:

> I found a problem in traps.c .
> The simulate_llsc does not have return values.
> 
> Please apply these patches.

Thanks, applied.

  Ralf
