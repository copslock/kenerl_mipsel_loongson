Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Mar 2007 15:54:56 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:45541 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022977AbXC2Oyx (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 29 Mar 2007 15:54:53 +0100
Received: from localhost (p2077-ipad209funabasi.chiba.ocn.ne.jp [58.88.113.77])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id AF332C074; Thu, 29 Mar 2007 23:53:32 +0900 (JST)
Date:	Thu, 29 Mar 2007 23:53:33 +0900 (JST)
Message-Id: <20070329.235333.25910277.anemo@mba.ocn.ne.jp>
To:	kumba@gentoo.org
Cc:	linux-mips@linux-mips.org, ths@networkno.de, ralf@linux-mips.org
Subject: Re: [PATCH]: Remove CONFIG_BUILD_ELF64 entirely
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <460B1B64.1040401@gentoo.org>
References: <460A6CED.1070308@gentoo.org>
	<20070329.002453.18311528.anemo@mba.ocn.ne.jp>
	<460B1B64.1040401@gentoo.org>
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
X-archive-position: 14767
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 28 Mar 2007 21:50:28 -0400, Kumba <kumba@gentoo.org> wrote:
> Doing some tests, I found out that by commenting out one or more of the 
> daddui/dsll instructions for IP32 produced a kernel that still booted, but hung 
> at running init/freeing kernel memory.  Using the single lui booted once, but I 
> suspect that was my fault on not doing something proper, cause the next time 
> around, it didn't boot at all.  I tested this all on a real console, versus 
> serial, case there was an early panic or something.  But I see nothing to 
> indicate why IP32 dislikes the lui->ld sequence versus the 
> lui->daddui->dsll->etc->ld sequence.

Hmm... really strange.

This is OK:
		lui	k1, %highest(kernelsp)
		daddiu	k1, %higher(kernelsp)
		dsll	k1, k1, 16
		daddiu	k1, %hi(kernelsp)
		dsll	k1, k1, 16

This is NG:
		lui	k1, %hi(kernelsp)

So, could you try this one?

		nop
		nop
		nop
		nop
		lui	k1, %hi(kernelsp)

If it booted, the problem should be in something irrelevant place.
I.e. this optimization just triggers other bug by code/data movement.

---
Atsushi Nemoto
