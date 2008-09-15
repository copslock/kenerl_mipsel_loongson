Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Sep 2008 15:01:27 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:1763 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S62078578AbYIOOBX (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 15 Sep 2008 15:01:23 +0100
Received: from localhost (p1190-ipad401funabasi.chiba.ocn.ne.jp [123.217.235.190])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 88ABAAA22; Mon, 15 Sep 2008 23:01:17 +0900 (JST)
Date:	Mon, 15 Sep 2008 23:01:32 +0900 (JST)
Message-Id: <20080915.230132.126142464.anemo@mba.ocn.ne.jp>
To:	sshtylyov@ru.mvista.com
Cc:	linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
	bzolnier@gmail.com, ralf@linux-mips.org
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <48CD7A2F.9020306@ru.mvista.com>
References: <20080910.010824.07456636.anemo@mba.ocn.ne.jp>
	<48CC3516.9080404@ru.mvista.com>
	<48CD7A2F.9020306@ru.mvista.com>
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
X-archive-position: 20493
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 15 Sep 2008 00:55:11 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> >    Hum... but is it really correct to convert from/to LE order above? 
> > I'm prett sure that data is expected in LE order -- look ar 
> > ide_fix_driveid() for example...
> >
> 
>    Assuming that the IDE data words' MSB appears at offset 6 and LSB at 
> offset 7 (which would seem logical), the data is actually in BE (CPU) 
> orger, so
> mm_insw_swap() should use cpu_to_le16() and mm_outsw_swap() le16_to_cpu()...

Thanks, I see.

---
Atsushi Nemoto
