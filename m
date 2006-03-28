Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Mar 2006 14:26:32 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:50654 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133508AbWC1N0Y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 28 Mar 2006 14:26:24 +0100
Received: from localhost (p7044-ipad03funabasi.chiba.ocn.ne.jp [219.160.87.44])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id A2844B5A3; Tue, 28 Mar 2006 22:36:46 +0900 (JST)
Date:	Tue, 28 Mar 2006 22:36:59 +0900 (JST)
Message-Id: <20060328.223659.07643634.anemo@mba.ocn.ne.jp>
To:	ralf.roesch@rw-gmbh.de
Cc:	linux-mips@linux-mips.org
Subject: Re: Assember error in arch/mips/kernel/r4k_switch.S / latest git
 2.6.16
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <44292D57.3060400@rw-gmbh.de>
References: <44292D57.3060400@rw-gmbh.de>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10958
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Tue, 28 Mar 2006 14:34:31 +0200, Ralf Rösch <ralf.roesch@rw-gmbh.de> said:

> Since a few days I have following compiler / assembler problem:

Try a patch I posted yesterday:

> Subject: [PATCH] Fix sed regexp to generate asm-offset.h

---
Atsushi Nemoto
