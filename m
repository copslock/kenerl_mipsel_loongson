Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Sep 2005 17:56:11 +0100 (BST)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:61124 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8225352AbVISQzx>; Mon, 19 Sep 2005 17:55:53 +0100
Received: from localhost (p8077-ipad27funabasi.chiba.ocn.ne.jp [220.107.199.77])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id CBBEC46A9; Tue, 20 Sep 2005 01:55:50 +0900 (JST)
Date:	Tue, 20 Sep 2005 01:54:24 +0900 (JST)
Message-Id: <20050920.015424.41632255.anemo@mba.ocn.ne.jp>
To:	ths@networkno.de
Cc:	linux-mips@linux-mips.org
Subject: Re: Performance bug in c-r4k.c cache handling code
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20050919154056.GG3386@hattusa.textio>
References: <20050919154056.GG3386@hattusa.textio>
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
X-archive-position: 8978
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Mon, 19 Sep 2005 17:40:56 +0200, Thiemo Seufer <ths@networkno.de> said:

ths> I found an performance bug in c-r4k.c:r4k_dma_cache_inv, where a
ths> Hit_Writeback_Inv instead of Hit_Invalidate is done. Ralf
ths> mentioned this is probably due to broken Hit_Invalidate cache ops
ths> on some CPUs, does anybody have more information about this? The
ths> appended patch works apparently fine on R4400, R4600v2.0, R5000.

Just a question: Are there any performance advantage of using
Hit_Invalidate instead of Hit_Writeback_Inv if the target line was
CLEAN?

---
Atsushi Nemoto
