Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jun 2006 22:24:01 +0100 (BST)
Received: from adsl-71-128-175-242.dsl.pltn13.pacbell.net ([71.128.175.242]:10157
	"EHLO build.embeddedalley.com") by ftp.linux-mips.org with ESMTP
	id S8134095AbWFOVXx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 15 Jun 2006 22:23:53 +0100
Received: from localhost.localdomain (build.embeddedalley.com [127.0.0.1])
	by build.embeddedalley.com (8.13.1/8.13.1) with ESMTP id k5FLJnIG027822;
	Thu, 15 Jun 2006 14:19:54 -0700
Subject: Re: i2c-algo-ite and i2c-ite planned for removal
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
To:	Jean Delvare <khali@linux-fr.org>
Cc:	linux-mips@linux-mips.org, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060615225723.012c82be.khali@linux-fr.org>
References: <20060615225723.012c82be.khali@linux-fr.org>
Content-Type: text/plain
Organization: Embedded Alley Solutions, Inc
Date:	Fri, 16 Jun 2006 00:23:17 +0300
Message-Id: <1150406598.1193.73.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11741
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

On Thu, 2006-06-15 at 22:57 +0200, Jean Delvare wrote:
> Hi all,
> 
> I noticed today that we have an i2c bus driver named i2c-ite,
> supposedly useful on some MIPS systems which have an ITE8172 chip,
> which doesn't compile. It is based on an i2c algorithm driver named
> i2c-algo-ite, which doesn't compile either, due to some changes made to
> the i2c core which weren't properly reflected there. Going back trough
> the versions, I found that the bus driver was previously named
> i2c-adap-ite, and was introduced in 2.4.10. And I don't think it even
> compiled back then either, as it uses a structure (iic_ite) which isn't
> defined anywhere.
> 
> So basically we have two drivers in the kernel tree for 5 years or so,
> which never were usable, and nobody seemed to care. 

For historical correctness, this driver was once upon a time usable,
though it was a few years ago. It was written by MV for some ref board
that had the ITE chip and it did work. That ref board is no longer
around so it's probably safe to nuke the driver. 

Pete

> It's about time to
> get rid of these 1296 lines of code, don't you think? So, unless someone
> volunteers to take care of these drivers, or otherwise has a very
> strong reason to object, I'm going to delete them from the tree soon.
> 
> Thanks,
