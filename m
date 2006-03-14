Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Mar 2006 11:59:05 +0000 (GMT)
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:22431 "EHLO
	lxorguk.ukuu.org.uk") by ftp.linux-mips.org with ESMTP
	id S8133528AbWCNL6x (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 14 Mar 2006 11:58:53 +0000
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.13.4/8.13.4) with ESMTP id k2ECEF4f001552;
	Tue, 14 Mar 2006 12:14:15 GMT
Received: (from alan@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id k2ECED1n001550;
	Tue, 14 Mar 2006 12:14:13 GMT
X-Authentication-Warning: localhost.localdomain: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: BCM91x80A/B PCI DMA problems
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	Mark E Mason <mark.e.mason@broadcom.com>, linux-mips@linux-mips.org
In-Reply-To: <20060314033439.GP29285@deprecation.cyrius.com>
References: <7E000E7F06B05C49BDBB769ADAF44D07868120@NT-SJCA-0750.brcm.ad.broadcom.com>
	 <20060314033439.GP29285@deprecation.cyrius.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date:	Tue, 14 Mar 2006 12:14:12 +0000
Message-Id: <1142338452.1510.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10808
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Maw, 2006-03-14 at 03:34 +0000, Martin Michlmayr wrote:
> Does this information help?  Also, we were wondering how to find out
> whether a driver is okay with 64-bit dma addresses.

All drivers set a PCI DMA mask. If the kernel is not bouncing buffers
and ensuring the buffers are below the 32bit bus address limit by
default then the architecture kernel code needs fixing. The drivers
don't deal with this matter beyond setting their PCI DMA range mask.

Alan
