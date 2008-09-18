Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Sep 2008 17:17:00 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:20680 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28646661AbYIRQQw (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 18 Sep 2008 17:16:52 +0100
Received: from localhost (p7111-ipad213funabasi.chiba.ocn.ne.jp [124.85.72.111])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id EFC53B0CE; Fri, 19 Sep 2008 01:16:45 +0900 (JST)
Date:	Fri, 19 Sep 2008 01:17:04 +0900 (JST)
Message-Id: <20080919.011704.59652451.anemo@mba.ocn.ne.jp>
To:	u1@terran.org
Cc:	macro@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: MIPS checksum bug
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <BD7F24AB-4B0C-4FA4-ADB3-5A86E7A4624F@terran.org>
References: <Pine.LNX.4.55.0809171104290.17103@cliff.in.clinika.pl>
	<20080917.222350.41199051.anemo@mba.ocn.ne.jp>
	<BD7F24AB-4B0C-4FA4-ADB3-5A86E7A4624F@terran.org>
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
X-archive-position: 20533
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 17 Sep 2008 15:52:45 -0700, Bryan Phillippe <u1@terran.org> wrote:
> I tested the simplified patch below (ADDC32), and it does not address  
> the checksum bug.  I suspect the problem is that we're still leaving  
> the carry bit in the upper 16 bits of the 32 bit csum returned, and  
> this is resulting in a computed checksum that is 1 greater than it  
> should be.  The upper 16 bits of the return value of this function  
> must be 0, right?

Thank you for testing.  Though this patch did not fixed your problem,
I still have a doubt on 64-bit optimization.

If your hardware could run 32-bit kernel, could you confirm the
problem can happens in 32-bit too or not?

---
Atsushi Nemoto
