Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Oct 2009 23:00:13 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:34705 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493642AbZJMVAI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Oct 2009 23:00:08 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n9DL1PB3016790;
	Tue, 13 Oct 2009 23:01:25 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n9DL1Pds016789;
	Tue, 13 Oct 2009 23:01:25 +0200
Date:	Tue, 13 Oct 2009 23:01:25 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manuel Lauss <manuel.lauss@googlemail.com>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>,
	Manuel Lauss <manuel.lauss@gmail.com>
Subject: Re: [PATCH 2/2] MIPS: Alchemy: change dbdma to accept physical
	memory addresses
Message-ID: <20091013210125.GB16628@linux-mips.org>
References: <1255458155-14469-1-git-send-email-manuel.lauss@gmail.com> <1255458155-14469-2-git-send-email-manuel.lauss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1255458155-14469-2-git-send-email-manuel.lauss@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24286
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 13, 2009 at 08:22:35PM +0200, Manuel Lauss wrote:

> DMA can only be done from physical addresses;
> move the "virt_to_phys" source/destination buffer address translation
> from the dbdma queueing functions (since the hardware can only DMA
> to/from physical addresses) to their respective users.
> 
> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
> ---
> All affected drivers still run fine on the DB1200, so I assume it's
> working right (au1550_ac97.c is untested).

Queued for 2.6.32.  Thanks,

  Ralf
