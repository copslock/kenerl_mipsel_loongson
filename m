Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jun 2006 17:46:22 +0100 (BST)
Received: from adsl-71-128-175-242.dsl.pltn13.pacbell.net ([71.128.175.242]:16327
	"EHLO build.embeddedalley.com") by ftp.linux-mips.org with ESMTP
	id S8133657AbWFSQqM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 19 Jun 2006 17:46:12 +0100
Received: from localhost.localdomain (build.embeddedalley.com [127.0.0.1])
	by build.embeddedalley.com (8.13.1/8.13.1) with ESMTP id k5JGfhTK009745;
	Mon, 19 Jun 2006 09:41:45 -0700
Subject: Re: i2c-algo-ite and i2c-ite planned for removal
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
To:	Jean Delvare <khali@linux-fr.org>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060616222908.f96e3691.khali@linux-fr.org>
References: <20060615225723.012c82be.khali@linux-fr.org>
	 <1150406598.1193.73.camel@localhost.localdomain>
	 <20060616222908.f96e3691.khali@linux-fr.org>
Content-Type: text/plain
Organization: Embedded Alley Solutions, Inc
Date:	Mon, 19 Jun 2006 19:45:58 +0300
Message-Id: <1150735558.8413.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11773
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

On Fri, 2006-06-16 at 22:29 +0200, Jean Delvare wrote:
> Hi Pete,
> 
> > > So basically we have two drivers in the kernel tree for 5 years or so,
> > > which never were usable, and nobody seemed to care. 
> > 
> > For historical correctness, this driver was once upon a time usable,
> > though it was a few years ago. It was written by MV for some ref board
> > that had the ITE chip and it did work. That ref board is no longer
> > around so it's probably safe to nuke the driver. 
> 
> In which kernel version? In every version I checked (2.4.12, 2.4.30,
> 2.6.0 and 2.6.16) it wouldn't compile due to struct iic_ite being used
> but never defined (and possibly other errors, but I can't test-compile
> the driver.)

Honestly, I don't remember. I think it was one of the very first 2.6
kernels because when MV first released a 2.6 product, 2.6 was still
'experimental'. It's quite possible of course that the driver was never
properly merged upstream in the community tree(s). But I do know that it
worked in the internal MV tree and an effort was made to get the driver
accepted upstream.

Pete
