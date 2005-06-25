Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Jun 2005 03:28:43 +0100 (BST)
Received: from p549F6AC1.dip.t-dialin.net ([IPv6:::ffff:84.159.106.193]:12417
	"EHLO bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225564AbVFYC22>; Sat, 25 Jun 2005 03:28:28 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.1/8.13.1) with ESMTP id j5P2R2sN031641;
	Sat, 25 Jun 2005 03:27:02 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j5P2R0N3031640;
	Sat, 25 Jun 2005 04:27:00 +0200
Date:	Sat, 25 Jun 2005 04:27:00 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	rolf liu <rolfliu@gmail.com>
Cc:	linux-mips@linux-mips.org, Pete Popov <ppopov@embeddedalley.com>
Subject: Re: adding another PCI based serial port board causing errors on db1550
Message-ID: <20050625022659.GJ6953@linux-mips.org>
References: <2db32b72050624155127a383a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2db32b72050624155127a383a7@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8189
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jun 24, 2005 at 03:51:06PM -0700, rolf liu wrote:
> Date:	Fri, 24 Jun 2005 15:51:06 -0700
> From:	rolf liu <rolfliu@gmail.com>
> To:	linux-mips@linux-mips.org
> Subject: adding another PCI based serial port board causing errors on db1550
> Content-Type:	text/plain; charset=US-ASCII
> 
> the driver for the board also has function "register_serial" and
> "unregister_serial", which are already defined by au1x00-serial.c. So
> there comes "multiple deginition" of these functions. Any idea on this
> issue?

The driver is basically a copy of the 8250 driver with everything including
all the unused gunk.

Pete, the driver really needs a cleanup ...

  Ralf
