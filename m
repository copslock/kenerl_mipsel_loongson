Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Mar 2007 14:12:11 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.175.29]:35548 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022185AbXCTOLe (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 20 Mar 2007 14:11:34 +0000
Received: from localhost (p1076-ipad02funabasi.chiba.ocn.ne.jp [61.214.21.76])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id A6C1AAA80; Tue, 20 Mar 2007 23:10:13 +0900 (JST)
Date:	Tue, 20 Mar 2007 23:10:13 +0900 (JST)
Message-Id: <20070320.231013.128618011.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: Re: ZONE_DMA on MIPS
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070319222031.GB8707@linux-mips.org>
References: <20070319154821.GA31766@linux-mips.org>
	<20070320.013608.103777227.anemo@mba.ocn.ne.jp>
	<20070319222031.GB8707@linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14584
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 19 Mar 2007 22:20:31 +0000, Ralf Baechle <ralf@linux-mips.org> wrote:
> It's probably reasonable to do something like:
> 
> config GENERIC_ISA_DMA
> 	bool
> 	select ZONE_DMA
> 
> I don't think we should expose such deep technical details to the Kconfig
> user.

Thanks.  I'll try.  GENERIC_ISA_DMA_SUPPORT_BROKEN also should select
ZONE_DMA, right?

---
Atsushi Nemoto
