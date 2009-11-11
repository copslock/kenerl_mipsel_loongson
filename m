Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Nov 2009 14:47:47 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:55851 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1492756AbZKKNro (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 11 Nov 2009 14:47:44 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nABDljce012595;
	Wed, 11 Nov 2009 14:47:45 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nABDlj8e012593;
	Wed, 11 Nov 2009 14:47:45 +0100
Date:	Wed, 11 Nov 2009 14:47:45 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] TXx9: update rbtx49xx_defconfig
Message-ID: <20091111134745.GB12249@linux-mips.org>
References: <1257943126-26776-1-git-send-email-anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1257943126-26776-1-git-send-email-anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24861
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Nov 11, 2009 at 09:38:46PM +0900, Atsushi Nemoto wrote:

> Enable following features:
> * MTD (RBTX4939, NAND_TXX9NDFMC)
> * HW_RANDOM (HW_RANDOM_TX4939)
> * SOUND (SND_SOC_TXX9ACLC)
> * DMADEVICE (TXX9_DMAC)
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

Thanks, applied!

  Ralf
