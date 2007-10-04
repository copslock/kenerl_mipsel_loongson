Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2007 18:50:30 +0100 (BST)
Received: from real.realitydiluted.com ([66.43.201.61]:29350 "EHLO
	real.realitydiluted.com") by ftp.linux-mips.org with ESMTP
	id S20026403AbXJDRuV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 4 Oct 2007 18:50:21 +0100
Received: from sjhill by real.realitydiluted.com with local (Exim 4.67)
	(envelope-from <sjhill@real.realitydiluted.com>)
	id 1IdUsj-0008Md-VW; Thu, 04 Oct 2007 12:53:06 -0500
Date:	Thu, 4 Oct 2007 12:53:05 -0500
From:	"Steven J. Hill" <sjhill@realitydiluted.com>
To:	David Daney <ddaney@avtrex.com>
Cc:	"Steven J. Hill" <sjhill@realitydiluted.com>,
	veerasena reddy <veerasena_b@yahoo.co.in>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: unresoved symbol _gp_disp
Message-ID: <20071004175305.GB32033@real.realitydiluted.com>
References: <230962.51223.qm@web8408.mail.in.yahoo.com> <20071004173928.GA32033@real.realitydiluted.com> <4705272D.7050801@avtrex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4705272D.7050801@avtrex.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <sjhill@real.realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16858
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

> Unless you compile your code with -msoft-float *and* also have a version 
> of libgcc compiled with -mlong-calls -mno-abicalls -G0.  If you do it 
> that way, floating point works fine in the kernel (as long as you don't 
> try to call sprintf with floating point parameters).
> 
I won't even concede that solution. It's bad practice and design to have
floating point in the kernel.

-Steve
