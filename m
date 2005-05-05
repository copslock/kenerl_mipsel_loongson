Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 May 2005 16:09:09 +0100 (BST)
Received: from rwcrmhc11.comcast.net ([IPv6:::ffff:204.127.198.35]:9203 "EHLO
	rwcrmhc11.comcast.net") by linux-mips.org with ESMTP
	id <S8224990AbVEEPIx>; Thu, 5 May 2005 16:08:53 +0100
Received: from ba3pi (pcp0010731669pcs.howard01.md.comcast.net[69.243.71.130])
          by comcast.net (rwcrmhc11) with SMTP
          id <200505051508450130050on3e>; Thu, 5 May 2005 15:08:45 +0000
From:	"Bryan Althouse" <bryan.althouse@3phoenix.com>
To:	"'Ralf Baechle'" <ralf@linux-mips.org>
Cc:	<linux-mips@linux-mips.org>
Subject: RE: 
Date:	Thu, 5 May 2005 11:08:39 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcVRgnWRf9gRuQGhQ7S4aOEaCBKtJAAAJxWQ
In-Reply-To: <20050505145508.GJ17119@linux-mips.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Message-Id: <20050505150853Z8224990-1340+6554@linux-mips.org>
Return-Path: <bryan.althouse@3phoenix.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7856
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bryan.althouse@3phoenix.com
Precedence: bulk
X-list: linux-mips

Ralf,

Right, there is no AGP.  At first, I was unable to locate the
yosemite_defconfig, so I was running xconfig without a properly defaulted
.config.  I inadvertently left the AGP support enabled.  Now that I am
starting with yosemite_defcofig as a base-line, I have no problems compiling
the kernel.

Thanks,
Bryan

-----Original Message-----
From: Ralf Baechle [mailto:ralf@linux-mips.org] 
Sent: Thursday, May 05, 2005 10:55 AM
To: Alex Gonzalez
Cc: Bryan Althouse; linux-mips@linux-mips.org; TheNop@gmx.net
Subject: Re:

On Wed, May 04, 2005 at 02:55:49PM +0100, Alex Gonzalez wrote:

> Do you need AGP support? My kernel is configured without it.

I'm not aware of any AGP bridge for MIPS systems.

  Ralf
