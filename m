Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 May 2004 14:50:57 +0100 (BST)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:62186 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8225794AbUEKNu4>; Tue, 11 May 2004 14:50:56 +0100
Received: from localhost (p6029-ipad29funabasi.chiba.ocn.ne.jp [221.184.73.29])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 12023555B; Tue, 11 May 2004 22:50:52 +0900 (JST)
Date: Tue, 11 May 2004 22:53:05 +0900 (JST)
Message-Id: <20040511.225305.55510293.anemo@mba.ocn.ne.jp>
To: ralf@linux-mips.org
Cc: geert@linux-m68k.org, jsun@mvista.com, linux-mips@linux-mips.org
Subject: Re: semaphore woes in 2.6, 32bit
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20040510140606.GA9312@linux-mips.org>
References: <20040509164835.GA28011@linux-mips.org>
	<20040510.222845.78701815.anemo@mba.ocn.ne.jp>
	<20040510140606.GA9312@linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4976
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Mon, 10 May 2004 16:06:06 +0200, Ralf Baechle <ralf@linux-mips.org> said:

>> I see.  Thank you for pointing out it.  I must learn 2.6 DMA API
>> quickly ...

ralf> This also applies to the 2.4 PCI DMA API.

But 2.4 PCI DMA API does not have dma_get_cache_alignment() (or
equivalent), or am I missing something?

---
Atsushi Nemoto
