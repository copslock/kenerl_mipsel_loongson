Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Jan 2005 15:36:26 +0000 (GMT)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:17883 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8225549AbVALPgW>; Wed, 12 Jan 2005 15:36:22 +0000
Received: from localhost (p7213-ipad203funabasi.chiba.ocn.ne.jp [222.146.86.213])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 11D8789A7; Thu, 13 Jan 2005 00:36:16 +0900 (JST)
Date: Thu, 13 Jan 2005 00:42:58 +0900 (JST)
Message-Id: <20050113.004258.25909217.anemo@mba.ocn.ne.jp>
To: yuasa@hh.iij4u.or.jp
Cc: ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 2.6] add iomap funtions
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20050112012433.382a97dd.yuasa@hh.iij4u.or.jp>
References: <20050112012433.382a97dd.yuasa@hh.iij4u.or.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6892
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Wed, 12 Jan 2005 01:24:33 +0900, Yoichi Yuasa <yuasa@hh.iij4u.or.jp> said:

yuasa> This patch adds iomap functions to MIPS system.
yuasa> Some MIPS systems are unable to define PIO space by
yuasa> PIO_MASK/PIO_RESERVED.  This is the reason that I didn't use
yuasa> the general iomap implementation.

How about defining ioreadN/iowriteN macros in io.h ?

#define ioread8(addr)	readb(addr)
#define ioread8_rep(port, buf, count)	readsb(port, buf, count)
etc.

Then ioport_map and io{read,write}{8,16,32} will be more efficient
than {in,out}[bwl].

---
Atsushi Nemoto
