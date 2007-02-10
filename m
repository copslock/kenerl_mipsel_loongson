Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Feb 2007 16:05:03 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:25800 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20037425AbXBJQE4 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 10 Feb 2007 16:04:56 +0000
Received: from localhost (p3173-ipad210funabasi.chiba.ocn.ne.jp [58.88.122.173])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 854DAB8DB; Sun, 11 Feb 2007 01:03:36 +0900 (JST)
Date:	Sun, 11 Feb 2007 01:03:36 +0900 (JST)
Message-Id: <20070211.010336.15248113.anemo@mba.ocn.ne.jp>
To:	djohnson+linux-mips@sw.starentnetworks.com
Cc:	linux-mips@linux-mips.org
Subject: Re: problems booting sb1250, page fault issue?
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <17869.2075.900049.547334@zeus.sw.starentnetworks.com>
References: <17869.2075.900049.547334@zeus.sw.starentnetworks.com>
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
X-archive-position: 14026
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 9 Feb 2007 18:47:39 -0500, Dave Johnson <djohnson+linux-mips@sw.starentnetworks.com> wrote:
> I've got 2.6.18 from linux-mips.org's git tree at the 'linux-2.6.18'
> TAG built and almost booting.

You mean 2.6.18 is OK and more recent kernel has problem?  Or 2.6.18
has problem?

> After taking the fault, I also examined the page that took the
> fault and verified it is full of 'addiu $8,$8,1' including the
> instruction that the kernel thinks a SEGV occurred on.
> 
> Since the page contains correct data, I tried adding gratuitous icache
> flushes after each page fault before returning to userspace to rule
> out any issues there, but with no help.
> 
> Has issues like this been seen before?  If not, does anyone have ideas
> that I could try next?

Is this problem still happen in 2.6.20?

Please refer this thread:

http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=710F16C36810444CA2F5821E5EAB7F230A0DFA%40NT-SJCA-0752.brcm.ad.broadcom.com

---
Atsushi Nemoto
