Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jan 2004 22:14:32 +0000 (GMT)
Received: from p508B7260.dip.t-dialin.net ([IPv6:::ffff:80.139.114.96]:61048
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225562AbUA2WOb>; Thu, 29 Jan 2004 22:14:31 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i0TMERex008580;
	Thu, 29 Jan 2004 23:14:27 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i0TMERRK008579;
	Thu, 29 Jan 2004 23:14:27 +0100
Date: Thu, 29 Jan 2004 23:14:27 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Jerry Walden <jerry.walden@lantronix.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Gcc - can't branch to undefined symbol
Message-ID: <20040129221426.GA8465@linux-mips.org>
References: <603BA0CFF3788E46A0DB0918D9AA95100A0E3088@sj580004wcom.int.lantronix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <603BA0CFF3788E46A0DB0918D9AA95100A0E3088@sj580004wcom.int.lantronix.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4196
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jan 29, 2004 at 12:25:16PM -0800, Jerry Walden wrote:

> I am using gcc 3.3.2 - when I assemble a file that has a branch to a
> label, and the label is not defined in the .S file (i.e. there is no
> extern - the label exists in another .S file) the error "cannot branch
> to an undefined symbol" results.  Using an older version of
> mipsel-gnu-linux-gcc does not report this error.  Any idea what I am
> doing wrong?

This construct is illegal because it cannot be represented in MIPS ELF.

  Ralf
