Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Oct 2002 04:04:55 +0200 (CEST)
Received: from p508B6FF8.dip.t-dialin.net ([80.139.111.248]:15295 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S1123891AbSJQCEy>; Thu, 17 Oct 2002 04:04:54 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g9H24iq26685;
	Thu, 17 Oct 2002 04:04:44 +0200
Date: Thu, 17 Oct 2002 04:04:44 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Kip Walker <kwalker@broadcom.com>
Cc: linux-mips@linux-mips.org
Subject: Re: break_cow and cache flushing
Message-ID: <20021017040444.A26285@linux-mips.org>
References: <3DADFC0B.81C8C058@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DADFC0B.81C8C058@broadcom.com>; from kwalker@broadcom.com on Wed, Oct 16, 2002 at 04:53:47PM -0700
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 464
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 16, 2002 at 04:53:47PM -0700, Kip Walker wrote:

> BUT either my understanding of (1) or (2) is wrong, or 'break_cow' needs
> to do a 'flush_icache_page' when the page is executable.  Consider the
> following (evil) case.

Ok, didn't get hold of Rik but another mm guy.  He agrees that fix is what
should be used.

Coincidentally that also explains a problem the ia64 guys were seeing :-)

  Ralf
