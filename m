Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Jan 2005 16:00:14 +0000 (GMT)
Received: from pD95620DD.dip.t-dialin.net ([IPv6:::ffff:217.86.32.221]:49727
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225239AbVATQAH>; Thu, 20 Jan 2005 16:00:07 +0000
Received: from fluff.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j0KG06JR005973;
	Thu, 20 Jan 2005 17:00:06 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id j0KG05C4005972;
	Thu, 20 Jan 2005 17:00:05 +0100
Date:	Thu, 20 Jan 2005 17:00:05 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Chris Wright <chrisw@osdl.org>
Cc:	akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] mips default mlock limit fix
Message-ID: <20050120160005.GA5672@linux-mips.org>
References: <20050119175945.K469@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050119175945.K469@build.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6964
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jan 19, 2005 at 05:59:45PM -0800, Chris Wright wrote:

> Mips RLIMIT_MEMLOCK incorrectly defaults to unlimited, it was confused
> with RLIMIT_NPROC.  Found while consolidating resource.h headers.

Thanks, I applied a recent change off by one line.  To avoid this I've
changed the code to use named initializers, see

http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-cvs-patches&i=95f18dfc8e770c9885b796a676935677%40NO-ID-FOUND.mhonarc.org

  Ralf
