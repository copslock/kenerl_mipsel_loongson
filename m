Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Nov 2006 13:36:18 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:20956 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20039216AbWKBNgJ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 2 Nov 2006 13:36:09 +0000
Received: from localhost (p8101-ipad207funabasi.chiba.ocn.ne.jp [222.145.90.101])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 6B9D2AE6B; Thu,  2 Nov 2006 22:36:05 +0900 (JST)
Date:	Thu, 02 Nov 2006 22:38:36 +0900 (JST)
Message-Id: <20061102.223836.59465708.anemo@mba.ocn.ne.jp>
To:	macro@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] mips irq cleanups
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <Pine.LNX.4.64N.0611021134030.7700@blysk.ds.pg.gda.pl>
References: <20061102.020836.25912635.anemo@mba.ocn.ne.jp>
	<Pine.LNX.4.64N.0611021134030.7700@blysk.ds.pg.gda.pl>
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
X-archive-position: 13151
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 2 Nov 2006 11:39:12 +0000 (GMT), "Maciej W. Rozycki" <macro@linux-mips.org> wrote:
>  You have removed a couple of spinlocks protecting accesses to some 
> resources on the DECstation.  This makes me suspicious -- after all I put 
> all of them there for a reason, e.g. to make sure shadow variables are 
> consistent with write-only registers.  But perhaps you had a valid reason 
> to believe with your changes in place they are no needed anymore.  I'll 
> have a closer look as soon as possible and will let you know if the 
> changes are fine.  Thanks for your work.
> 
>  But for now it's a NAK for the DECstation part.

Thanks you your review.

Yes, I removed ioasic_lock and kn02_lock.  These were used in:

dec_kn02_be_init
enable_ioasic_irq
disable_ioasic_irq
ack_ioasic_irq
enable_kn02_irq
disable_kn02_irq
ack_kn02_irq
init_kn02_irqs

IIUC All of these are called interrupt disabled.  These callers are in
lowlevel interrupt context, or having irq_desc lock with
spin_lock_irqsave, or in early stage of bootstrap.  And DECstation is
not SMP system, so no further protection would be needed.

---
Atsushi Nemoto
