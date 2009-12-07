Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Dec 2009 14:45:11 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:55696 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1493900AbZLGNpI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 7 Dec 2009 14:45:08 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nB7Dj3Jd022229;
        Mon, 7 Dec 2009 13:45:03 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nB7Dj2Zp022227;
        Mon, 7 Dec 2009 13:45:02 GMT
Date:   Mon, 7 Dec 2009 13:45:02 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     figo zhang <figo1802@gmail.com>
Cc:     David Daney <ddaney@caviumnetworks.com>, macro@linux-mips.org,
        linux-mips@linux-mips.org
Subject: Re: Dma addr should use Kuseg1 for MIPS32?
Message-ID: <20091207134502.GB5119@linux-mips.org>
References: <c6ed1ac50912070455n736af31fuf2c981fc182b494f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6ed1ac50912070455n736af31fuf2c981fc182b494f@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25351
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Dec 07, 2009 at 08:55:12PM +0800, figo zhang wrote:

> I am writing a driver for MIPS32. i wirte this code for DMA addr:
> 
> dma_vaddr =(char*) __get_free_pages(GFP_KERNEL|
> GFP_DMA, order);

You probably don't want to use GFP_DMA - unless your hardware has DMA
restrictions such as the ISA's bus's 16MB limit.

> dma_phy = virt_to_phy(dma_vaddr);

Ouch.  Don't.  See Documentation/DMA-API.txt for how to do it.

> i write dma_phy to DMA base register, but why it cannot work? it should
> write Kseg1 space to DMA register?
> I remember that it is ok for ARM/X86 .

It's only happens to work on some systems.

  Ralf
