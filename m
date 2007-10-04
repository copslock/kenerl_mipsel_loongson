Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2007 18:40:01 +0100 (BST)
Received: from real.realitydiluted.com ([66.43.201.61]:8095 "EHLO
	real.realitydiluted.com") by ftp.linux-mips.org with ESMTP
	id S20026399AbXJDRjw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 4 Oct 2007 18:39:52 +0100
Received: from sjhill by real.realitydiluted.com with local (Exim 4.67)
	(envelope-from <sjhill@real.realitydiluted.com>)
	id 1IdUfY-0008L3-S6; Thu, 04 Oct 2007 12:39:28 -0500
Date:	Thu, 4 Oct 2007 12:39:28 -0500
From:	"Steven J. Hill" <sjhill@realitydiluted.com>
To:	veerasena reddy <veerasena_b@yahoo.co.in>
Cc:	linux-mips <linux-mips@linux-mips.org>,
	"linux-kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: unresoved symbol _gp_disp
Message-ID: <20071004173928.GA32033@real.realitydiluted.com>
References: <230962.51223.qm@web8408.mail.in.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <230962.51223.qm@web8408.mail.in.yahoo.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <sjhill@real.realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16856
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

> I have written a loadble module ( which gets complied
> along with kernel) which does some floating point
> operation.
>  
NO FLOATING POINT in the kernel PERIOD. Either use integer
operations, or redo your software architecture and do the
floating point in userspace.

-Steve
