Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Aug 2005 17:31:08 +0100 (BST)
Received: from rwcrmhc14.comcast.net ([IPv6:::ffff:204.127.198.54]:47248 "EHLO
	rwcrmhc12.comcast.net") by linux-mips.org with ESMTP
	id <S8224979AbVHZQau>; Fri, 26 Aug 2005 17:30:50 +0100
Received: from ba3pi (pcp0010731669pcs.howard01.md.comcast.net[69.243.71.130])
          by comcast.net (rwcrmhc14) with SMTP
          id <2005082616362701400hfmq0e>; Fri, 26 Aug 2005 16:36:27 +0000
From:	"Bryan Althouse" <bryan.althouse@3phoenix.com>
To:	"'Ralf Baechle'" <ralf@linux-mips.org>
Cc:	<linux-mips@linux-mips.org>
Subject: RE: custom ide driver causes "Badness in smp_call_function"
Date:	Fri, 26 Aug 2005 12:36:26 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcWqWzeC/+HCp/FoTVCO9YZvOG8WzwAAFvxA
In-Reply-To: <20050826162832.GB2712@linux-mips.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Message-Id: <20050826163050Z8224979-3678+7593@linux-mips.org>
Return-Path: <bryan.althouse@3phoenix.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8824
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bryan.althouse@3phoenix.com
Precedence: bulk
X-list: linux-mips

I still get the SMP badness when hwif->irq is set to 0 in my driver.

Bryan

-----Original Message-----
From: Ralf Baechle [mailto:ralf@linux-mips.org] 
Sent: Friday, August 26, 2005 12:29 PM
To: Bryan Althouse
Cc: linux-mips@linux-mips.org
Subject: Re: custom ide driver causes "Badness in smp_call_function"

On Fri, Aug 26, 2005 at 10:58:40AM -0400, Bryan Althouse wrote:

> The patch doesn't seem to make any difference. :(

To clarify, the patch wasn't meant to resolve your interrupt problems but
the SMP cacheflush issues only.

  Ralf
