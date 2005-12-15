Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Dec 2005 15:02:20 +0000 (GMT)
Received: from extgw-uk.mips.com ([62.254.210.129]:22555 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133389AbVLOPCC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 15 Dec 2005 15:02:02 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id jBFExZwc003526;
	Thu, 15 Dec 2005 14:59:35 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id jBFExLEV003489;
	Thu, 15 Dec 2005 14:59:21 GMT
Date:	Thu, 15 Dec 2005 14:59:21 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Jordan Crouse <jordan.crouse@AMD.com>
Cc:	bora.sahin@ttnet.net.tr, linux-mips@linux-mips.org
Subject: Re: Au1200 & IDE
Message-ID: <20051215145921.GB2812@linux-mips.org>
References: <200512142356.14417.bora.sahin@ttnet.net.tr> <20051214235031.GD23276@cosmic.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051214235031.GD23276@cosmic.amd.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9676
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Dec 14, 2005 at 04:50:31PM -0700, Jordan Crouse wrote:

> > But that directory doesnt contain "ide-timing.h" so compiler complains from 
> > it. ide-timing.h is in ide folder. I did a grep and saw that some other 
> > dirs under ide also includes that file in the same manner as in mips but 
> > doesnt contain it in its own folder. After I did a sym link, compile was 
> > successfull. What's the concept behind this? Can we move it to 
> > include/linux.
> 
> I'm not sure about that - thats probably more of a question for the core
> folks.  For your particular error, however, it should be sufficient to add
> 
> EXTRA_CFLAGS += -Idrivers/ide
> 
> To drivers/ide/mips/Makefile.  I do believe that the most recent patches
> had that fix attached.

I nuked it - it just isn't necessary to force this for all drivers.  So
if anything, make that

  CFLAGS_au1xxx-ide.o += -Idrivers/ide

  Ralf
