Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Feb 2005 13:38:34 +0000 (GMT)
Received: from p3EE07C05.dip.t-dialin.net ([IPv6:::ffff:62.224.124.5]:26995
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225462AbVBCNiT>; Thu, 3 Feb 2005 13:38:19 +0000
Received: from fluff.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j13DcINs009830;
	Thu, 3 Feb 2005 14:38:18 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id j13DcDut009829;
	Thu, 3 Feb 2005 14:38:13 +0100
Date:	Thu, 3 Feb 2005 14:38:13 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Nishanth Aravamudan <nacc@us.ibm.com>
Cc:	linux-mips@linux-mips.org, kernel-janitors@lists.osdl.org
Subject: Re: [PATCH 20/20] mips/bcm1250_tbprof: remove interruptible_sleep_on() usage
Message-ID: <20050203133813.GA9796@linux-mips.org>
References: <20050202230853.GA2546@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050202230853.GA2546@us.ibm.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7130
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Feb 02, 2005 at 03:08:53PM -0800, Nishanth Aravamudan wrote:

> Please consider applying.
> 
> Description: Remove deprecated interruptible_sleep_on() function call
> and replace with direct wait-queue usage.

Thanks,

  Ralf
