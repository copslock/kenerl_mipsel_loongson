Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Feb 2006 22:53:59 +0000 (GMT)
Received: from [81.2.110.250] ([81.2.110.250]:16620 "EHLO lxorguk.ukuu.org.uk")
	by ftp.linux-mips.org with ESMTP id S8133642AbWB1Wxw (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 28 Feb 2006 22:53:52 +0000
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.13.4/8.13.4) with ESMTP id k1SN6Rm7014356;
	Tue, 28 Feb 2006 23:06:28 GMT
Received: (from alan@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id k1SN6QdW014355;
	Tue, 28 Feb 2006 23:06:26 GMT
X-Authentication-Warning: localhost.localdomain: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: RE: BCM91x80A/B PCI DMA problems
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	Mark E Mason <mark.e.mason@broadcom.com>
Cc:	Martin Michlmayr <tbm@cyrius.com>, linux-mips@linux-mips.org
In-Reply-To: <7E000E7F06B05C49BDBB769ADAF44D077D643F@NT-SJCA-0750.brcm.ad.broadcom.com>
References: <7E000E7F06B05C49BDBB769ADAF44D077D643F@NT-SJCA-0750.brcm.ad.broadcom.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date:	Tue, 28 Feb 2006 23:06:23 +0000
Message-Id: <1141167984.12291.39.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10687
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Maw, 2006-02-28 at 14:15 -0800, Mark E Mason wrote:
> Hello,
> 
> Is this driver known to work with 64-bit kernels (specifically: 64-bit
> DMA addresses)?  It sounds like that might be the problem.

The standard ATA IDE hardware supports only 32bit addressing. However if
your I/O mapping logic is correctly implemented for the architecture
that should cause no problems as the buffers will be bounced.

The SIL680 hardware actually can support 64bit DMA using a private
non-standard PRD format and the data sheet is available if someone wants
to do the work. Probably best to do it for the new libata driver but its
doable for either
