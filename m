Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jun 2006 21:29:12 +0100 (BST)
Received: from smtp-105-friday.nerim.net ([62.4.16.105]:2573 "HELO
	kraid.nerim.net") by ftp.linux-mips.org with SMTP id S8134121AbWFPU3D
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 16 Jun 2006 21:29:03 +0100
Received: from arrakis.delvare (jdelvare.pck.nerim.net [62.212.121.182])
	by kraid.nerim.net (Postfix) with SMTP id 8178440F59;
	Fri, 16 Jun 2006 22:28:59 +0200 (CEST)
Date:	Fri, 16 Jun 2006 22:29:08 +0200
From:	Jean Delvare <khali@linux-fr.org>
To:	Pete Popov <ppopov@embeddedalley.com>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: i2c-algo-ite and i2c-ite planned for removal
Message-Id: <20060616222908.f96e3691.khali@linux-fr.org>
In-Reply-To: <1150406598.1193.73.camel@localhost.localdomain>
References: <20060615225723.012c82be.khali@linux-fr.org>
	<1150406598.1193.73.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <khali@linux-fr.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11751
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khali@linux-fr.org
Precedence: bulk
X-list: linux-mips

Hi Pete,

> > So basically we have two drivers in the kernel tree for 5 years or so,
> > which never were usable, and nobody seemed to care. 
> 
> For historical correctness, this driver was once upon a time usable,
> though it was a few years ago. It was written by MV for some ref board
> that had the ITE chip and it did work. That ref board is no longer
> around so it's probably safe to nuke the driver. 

In which kernel version? In every version I checked (2.4.12, 2.4.30,
2.6.0 and 2.6.16) it wouldn't compile due to struct iic_ite being used
but never defined (and possibly other errors, but I can't test-compile
the driver.)

-- 
Jean Delvare
