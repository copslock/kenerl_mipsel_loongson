Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Jan 2008 12:18:11 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.235.107]:40669 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20031622AbYALMSC (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 12 Jan 2008 12:18:02 +0000
Received: from localhost (p4042-ipad307funabasi.chiba.ocn.ne.jp [123.217.182.42])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 8D8A69ABB; Sat, 12 Jan 2008 21:17:57 +0900 (JST)
Date:	Sat, 12 Jan 2008 21:17:49 +0900 (JST)
Message-Id: <20080112.211749.25909440.anemo@mba.ocn.ne.jp>
To:	gregor.waltz@raritan.com
Cc:	linux-mips@linux-mips.org
Subject: Re: Toshiba JMR 3927 working setup?
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <4787AC3D.2020604@raritan.com>
References: <477E7DAE.2080005@raritan.com>
	<20080106.000725.75184768.anemo@mba.ocn.ne.jp>
	<4787AC3D.2020604@raritan.com>
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
X-archive-position: 17999
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 11 Jan 2008 12:49:49 -0500, Gregor Waltz <gregor.waltz@raritan.com> wrote:
> I built linux-2.6.23.9 with the above, but the results are still the 
> same and the EPC is not in System.map.

Are you searching the exact EPC value in System.map?
Usually you should find a function symbol which contains the EPC value in it.

Or you can do "mipsel-linux-objdump -d vmlinux" and search the EPC value.

> Exception! EPC=8005625c CAUSE=30000008(TLBL)
> 8005625c 8e020098 lw      v0,152(s0)                        # 0x98
> 
> I presume that 8e020098 is the full instruction, so I have tried 
> searching for it in vmlinux.bin. The first occurrence is around 0x869b, 
> which is more than 32k into the file. There is also nearly 1k worth of 
> zero padding at the start of vmlinux.bin.

The 1k zero padding is normal.  Please refer arch/mips/kernel/head.S.

---
Atsushi Nemoto
