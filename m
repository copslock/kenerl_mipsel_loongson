Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jun 2005 17:39:49 +0100 (BST)
Received: from ylpvm43-ext.prodigy.net ([IPv6:::ffff:207.115.57.74]:17037 "EHLO
	ylpvm43.prodigy.net") by linux-mips.org with ESMTP
	id <S8225339AbVFJQjc>; Fri, 10 Jun 2005 17:39:32 +0100
Received: from pimout2-ext.prodigy.net (pimout2-int.prodigy.net [207.115.4.217])
	by ylpvm43.prodigy.net (8.12.10 outbound/8.12.10) with ESMTP id j5AGddKd011675;
	Fri, 10 Jun 2005 12:39:39 -0400
X-ORBL:	[63.202.173.158]
Received: from taniwha.stupidest.org (adsl-63-202-173-158.dsl.snfc21.pacbell.net [63.202.173.158])
	by pimout2-ext.prodigy.net (8.12.10 milter /8.12.10) with ESMTP id j5AGdOM3371188;
	Fri, 10 Jun 2005 12:39:24 -0400
Received: by taniwha.stupidest.org (Postfix, from userid 38689)
	id 656CC528F22; Fri, 10 Jun 2005 09:39:24 -0700 (PDT)
Date:	Fri, 10 Jun 2005 09:39:24 -0700
From:	Chris Wedgwood <cw@f00f.org>
To:	Greg Weeks <greg.weeks@timesys.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: another 4kc machine check.
Message-ID:  <494028.547d3e99fefb72449a89b8d1daf681ec.ANY@taniwha.stupidest.org>
References: <42553E49.7080004@timesys.com> <4256991C.4020601@timesys.com> <20050408161357.GB19166@linux-mips.org> <4256B524.2080509@timesys.com> <425AD440.5050600@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425AD440.5050600@timesys.com>
Return-Path: <cw@f00f.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8064
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cw@f00f.org
Precedence: bulk
X-list: linux-mips

On Mon, Apr 11, 2005 at 03:47:12PM -0400, Greg Weeks wrote:

> This patch appears to fix my machine check problem on the 4kc. The
> 4kc shouldn't need an ssnop here, but this appears to fix it.

This fix is working for me too --- but I've not heard what the
official status of this is and what (if anything) will eventually be
committed.

Does anyone havean update on this from the MIPS people?
