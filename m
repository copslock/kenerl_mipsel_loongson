Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Dec 2004 14:36:29 +0000 (GMT)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:7655 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8225243AbUL0OgW>; Mon, 27 Dec 2004 14:36:22 +0000
Received: from localhost (p1021-ipad11funabasi.chiba.ocn.ne.jp [219.162.36.21])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 7F0044BDC; Mon, 27 Dec 2004 23:36:08 +0900 (JST)
Date: Mon, 27 Dec 2004 23:41:55 +0900 (JST)
Message-Id: <20041227.234155.59462250.anemo@mba.ocn.ne.jp>
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org
Subject: Re: please export probe_irq_mask
From: anemo@mba.sphere.ne.jp
In-Reply-To: <20041227120344.GA25442@linux-mips.org>
References: <20041227.144804.30188040.nemoto@toshiba-tops.co.jp>
	<20041227120344.GA25442@linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.sphere.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6770
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.sphere.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Mon, 27 Dec 2004 13:03:44 +0100, Ralf Baechle <ralf@linux-mips.org> said:
ralf> I think so but for the time being each arch is exporting the
ralf> thing itself.  You're using probe_irq_mask for ISA, I assume?

Thank you.  I'm using it for CardBus (yenta_socket).

Also, it seems something wrong with yenta_allocate_resources() on
mips.  Nullifying the yenta_allocate_resources() works well but I'm not
sure why.  Does anyone know what is a problem?  

---
Atsushi Nemoto
