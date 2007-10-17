Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Oct 2007 17:08:58 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:20978 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20037631AbXJQQIt (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 17 Oct 2007 17:08:49 +0100
Received: from localhost (p2023-ipad307funabasi.chiba.ocn.ne.jp [123.217.180.23])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 78B5D993B; Thu, 18 Oct 2007 01:08:45 +0900 (JST)
Date:	Thu, 18 Oct 2007 01:10:33 +0900 (JST)
Message-Id: <20071018.011033.115643462.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: Re: [MIPS] Probe for usability of cp0 compare interrupt.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <S20022491AbXJQLKE/20071017111004Z+82239@ftp.linux-mips.org>
References: <S20022491AbXJQLKE/20071017111004Z+82239@ftp.linux-mips.org>
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
X-archive-position: 17094
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 17 Oct 2007 12:09:59 +0100, linux-mips@linux-mips.org wrote:
> Author: Ralf Baechle <ralf@linux-mips.org> Tue Oct 16 23:20:48 2007 +0100
> Commit: b2c9797919e6997e284e30a1e6e443543eb7a1e1
> Gitweb: http://www.linux-mips.org/g/linux/b2c97979
> Branch: master
> 
> Some processors offer the option of using the interrupt on which
> normally the count / compare interrupt would be signaled as a normal
> interupt pin.  Previously this required some ugly hackery for each
> system which is much easier done by a quick and simple probe.

It seems write_c0_compare(0) will not work as expected if c0_count was
near 0xffffffff.  How about write_c0_compare(read_c0_compare()) (or
c0_timer_ack()) ?

Also something calculated from mips_hpt_frequency would be better than
the magic number 0x300000.

---
Atsushi Nemoto
