Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Oct 2005 10:37:31 +0100 (BST)
Received: from extgw-uk.mips.com ([62.254.210.129]:52244 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S3465584AbVJTJhO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 20 Oct 2005 10:37:14 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j9K9ahLN007557;
	Thu, 20 Oct 2005 10:36:43 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j9K9afb5007556;
	Thu, 20 Oct 2005 10:36:41 +0100
Date:	Thu, 20 Oct 2005 10:36:41 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Mitchell, Earl" <earlm@mips.com>
Cc:	kernel coder <lhrkernelcoder@gmail.com>, linux-mips@linux-mips.org
Subject: Re: Fwd: How to improve performance of 2.6 kernel
Message-ID: <20051020093641.GL2616@linux-mips.org>
References: <3CB54817FDF733459B230DD27C690CEC01049446@Exchange.MIPS.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3CB54817FDF733459B230DD27C690CEC01049446@Exchange.MIPS.COM>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9302
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 19, 2005 at 11:12:22AM -0700, Mitchell, Earl wrote:

> If you are looking at network performance ...
> A while back I briefly looked at this and it
> looked like the per packet processing time had
> gone up significantly between 2.4.20 and
> 2.6.x. Problem was not NAPI which switches
> from interrupt to polling mode when you get a burst 
> of packets. I actually traced a single packet from Rx 
> to Tx. Unfortunately I didn't save my data and did 
> not isolate where increased time was being spent. 

A common cause for low networking performance is connection tracking.  Just
loading the module will have serious impact.

  Ralf
