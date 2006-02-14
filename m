Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Feb 2006 02:09:41 +0000 (GMT)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:3355 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S3467609AbWBNCJc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 14 Feb 2006 02:09:32 +0000
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Tue, 14 Feb 2006 11:15:51 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 370DF20181;
	Tue, 14 Feb 2006 11:15:48 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 21D671F711;
	Tue, 14 Feb 2006 11:15:48 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k1E2Fl4D074010;
	Tue, 14 Feb 2006 11:15:47 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Tue, 14 Feb 2006 11:15:47 +0900 (JST)
Message-Id: <20060214.111547.21591480.nemoto@toshiba-tops.co.jp>
To:	yoichi_yuasa@tripeaks.co.jp
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] fix cache coherency issues
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060214105928.0cd46e6f.yoichi_yuasa@tripeaks.co.jp>
References: <20060214.011508.41198724.anemo@mba.ocn.ne.jp>
	<20060214105928.0cd46e6f.yoichi_yuasa@tripeaks.co.jp>
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
X-archive-position: 10430
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Tue, 14 Feb 2006 10:59:28 +0900, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> said:
yuasa> VR41xx cannot be booted with 2.6.16-rc2 + patch.  It freeze
yuasa> after "Freeing unused kernel memory: 168k freed".

Good morning!  Thank you very much for testing.

Could you give me a full boot log and some other informations?
(icache/dcache size/associativity, highmem/preempt/smp enabled?)

---
Atsushi Nemoto
