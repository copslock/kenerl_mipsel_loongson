Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Feb 2007 15:49:36 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:52223 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038909AbXBPPtb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 16 Feb 2007 15:49:31 +0000
Received: from localhost (p2199-ipad213funabasi.chiba.ocn.ne.jp [124.85.67.199])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP id 98A83BC41
	for <linux-mips@linux-mips.org>; Sat, 17 Feb 2007 00:48:12 +0900 (JST)
Date:	Sat, 17 Feb 2007 00:48:12 +0900 (JST)
Message-Id: <20070217.004812.03978264.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Subject: Re: fadvise on MIPS
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070217.004329.108739438.anemo@mba.ocn.ne.jp>
References: <20070217.004329.108739438.anemo@mba.ocn.ne.jp>
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
X-archive-position: 14121
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sat, 17 Feb 2007 00:43:29 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> 2) On O32, glibc pass a 'long long' argument by hi and lo words, but
> kernel needs padding word between 'fd' and 'offset' argument.
> 
> 3) On N32, glibc pass a 'long long' argument by hi and lo words, but
> kernel expects a single register value for 'long long' argument.

And sync_file_range() has some problem too.

---
Atsushi Nemoto
