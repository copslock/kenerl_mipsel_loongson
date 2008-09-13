Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Sep 2008 14:36:59 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:42479 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28598898AbYIMNg5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 13 Sep 2008 14:36:57 +0100
Received: from localhost (p1248-ipad201funabasi.chiba.ocn.ne.jp [222.146.64.248])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id CA47DBD08; Sat, 13 Sep 2008 22:36:51 +0900 (JST)
Date:	Sat, 13 Sep 2008 22:37:03 +0900 (JST)
Message-Id: <20080913.223703.108120497.anemo@mba.ocn.ne.jp>
To:	alan@lxorguk.ukuu.org.uk
Cc:	linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
	bzolnier@gmail.com, ralf@linux-mips.org, sshtylyov@ru.mvista.com
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20080911.000649.39154743.anemo@mba.ocn.ne.jp>
References: <20080910.010824.07456636.anemo@mba.ocn.ne.jp>
	<20080909174459.2aa9808a@lxorguk.ukuu.org.uk>
	<20080911.000649.39154743.anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20484
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 11 Sep 2008 00:06:49 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> The dmatable_cpu is allocated by pci_alloc_consistent so that flush is
> not needed.  But... this is not PCI device.  I should not use
> ide_allocate_dma_engine().  I'll fix it.

Fortunately such a fix will not be needed.  A patch making
ide_allocate_dma_engine() independent from PCI already posted (
"[PATCH 4/8] ide: switch to DMA-mapping API part 2").  I can use
ide_allocate_dma_engine() with non-PCI device safely.  Thanks.

---
Atsushi Nemoto
