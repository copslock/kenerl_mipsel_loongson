Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Apr 2006 16:56:24 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:56562 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133522AbWDFP4O (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 6 Apr 2006 16:56:14 +0100
Received: from localhost (p7200-ipad30funabasi.chiba.ocn.ne.jp [221.184.82.200])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP id 16E57AF42
	for <linux-mips@linux-mips.org>; Fri,  7 Apr 2006 01:07:29 +0900 (JST)
Date:	Fri, 07 Apr 2006 01:07:47 +0900 (JST)
Message-Id: <20060407.010747.54918087.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Subject: Re: [MIPS] MIPS boards: Set HZ to 100.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <S8133487AbWDEP4Q/20060405155616Z+46@ftp.linux-mips.org>
References: <S8133487AbWDEP4Q/20060405155616Z+46@ftp.linux-mips.org>
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
X-archive-position: 11050
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 05 Apr 2006 16:56:10 +0100, linux-mips@linux-mips.org wrote:
> Author: Ralf Baechle <ralf@linux-mips.org> Wed Apr 5 09:45:48 2006 +0100
> Commit: 6cd1d4d23e7c16ba914ae458d205c3298f3183a7
> Gitweb: http://www.linux-mips.org/g/linux/6cd1d4d2
> Branch: master
> 
> 1000Hz will bring an FPGA CPU down on it's knees and it's even worse on
> multithreaded cores.

How about using Kconfig.hz to make HZ configurable?  I'll send a patch.
---
Atsushi Nemoto
