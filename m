Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Aug 2005 14:51:37 +0100 (BST)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:42198 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8224982AbVH0NvW>; Sat, 27 Aug 2005 14:51:22 +0100
Received: from localhost (p7002-ipad11funabasi.chiba.ocn.ne.jp [219.162.42.2])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id EBE3B84F3; Sat, 27 Aug 2005 22:57:07 +0900 (JST)
Date:	Sat, 27 Aug 2005 22:57:40 +0900 (JST)
Message-Id: <20050827.225740.07645519.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: Re: 64bit unaligned access on 32bit kernel
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20050825.003548.41199755.anemo@mba.ocn.ne.jp>
References: <20050825.003548.41199755.anemo@mba.ocn.ne.jp>
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
X-archive-position: 8830
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Thu, 25 Aug 2005 00:35:48 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> said:

anemo> MIPS kernel has been using asm-generic/unaligned.h since
anemo> 2.6.12-rc2.  But the generic unaligned.h is not suitable for
anemo> 32bit kernel because it uses 'unsigned long' for 64bit values.

FYI, I found this problem while debugging why usbhid does not work
with 2.6.12 kernel (though it worked with 2.6.11) on big endian
platform.  The usbhid use put_unaligned/get_unaligned for __u64
variables.

---
Atsushi Nemoto
