Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Jan 2006 15:52:26 +0000 (GMT)
Received: from [62.38.108.96] ([62.38.108.96]:18404 "EHLO pfn3.pefnos")
	by ftp.linux-mips.org with ESMTP id S8133373AbWAJPwJ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 10 Jan 2006 15:52:09 +0000
Received: from xorhgos2.pefnos (xorhgos2.pefnos [192.168.0.3])
	by pfn3.pefnos (Postfix) with ESMTP id 3995B1F101;
	Tue, 10 Jan 2006 17:55:06 +0200 (EET)
From:	"P. Christeas" <p_christ@hol.gr>
To:	linux-mips@linux-mips.org
Subject: Re: QEMU and kernel 2.6.15
Date:	Tue, 10 Jan 2006 17:54:52 +0200
User-Agent: KMail/1.9
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
References: <20060111.002431.93019846.anemo@mba.ocn.ne.jp>
In-Reply-To: <20060111.002431.93019846.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601101754.53791.p_christ@hol.gr>
Return-Path: <p_christ@hol.gr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9844
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: p_christ@hol.gr
Precedence: bulk
X-list: linux-mips

On Tuesday 10 January 2006 5:24 pm, Atsushi Nemoto wrote:
> Hi.  I'm a QEMU newbie.  Does anybody tried QEMU 0.8.0 with recent
> linux-mips kernel ?
>
> I got following output and the kernel hangs.
>
>...
> Memory: 13916k/16384k available (1702k kernel code, 2468k reserved, 321k 
> data, 112k init, 0k highmem) Calibrating delay loop... 478.41 BogoMIPS
> (lpj=2392064)
> Mount-cache hash table entries: 512
> Checking for 'wait' instruction...  available.
>
>
However, this *does* resemble the bug I'm having in real hw.
I generally get instablilities nearly always after the memory mapping and 
'wait' instruction on a 4Kc core with 2.6.15.
I'm not a MIPS expert nor have I the time to learn its internals. So, anything 
that might give me a hint is worth investigating..
