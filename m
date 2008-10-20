Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Oct 2008 13:20:59 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:31987 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S21913619AbYJTMU4 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 20 Oct 2008 13:20:56 +0100
Received: from localhost (p1245-ipad307funabasi.chiba.ocn.ne.jp [123.217.179.245])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 48AAFAA01; Mon, 20 Oct 2008 21:20:48 +0900 (JST)
Date:	Mon, 20 Oct 2008 21:21:01 +0900 (JST)
Message-Id: <20081020.212101.106262120.anemo@mba.ocn.ne.jp>
To:	sshtylyov@ru.mvista.com
Cc:	linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
	bzolnier@gmail.com, ralf@linux-mips.org
Subject: Re: [PATCH] ide: Add tx4939ide driver (v4)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <48FB2B27.3090906@ru.mvista.com>
References: <20081017.230825.95059872.anemo@mba.ocn.ne.jp>
	<48FB2B27.3090906@ru.mvista.com>
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
X-archive-position: 20812
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sun, 19 Oct 2008 16:42:15 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> > This is the driver for the Toshiba TX4939 SoC ATA controller.
> >
> > This controller has standard ATA taskfile registers and DMA
> > command/status registers, but the register layout is swapped on big
> > endian.  There are some other endian issue and some special registers
> > which requires many custom dma_ops/tp_ops routines and build_dmatable.
> >
> > Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> >   
> 
>    Again, mostly ACK but there are some things that I haven't noticed 
> before...

Thanks, I'll address all and send v5 patch soon.

---
Atsushi Nemoto
