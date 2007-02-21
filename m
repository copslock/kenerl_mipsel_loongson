Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Feb 2007 17:47:04 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:65039 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20038165AbXBURq7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 21 Feb 2007 17:46:59 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 958B8E1CBB;
	Wed, 21 Feb 2007 18:46:12 +0100 (CET)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CmQXiSDZcPxN; Wed, 21 Feb 2007 18:46:12 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 0C432E1C81;
	Wed, 21 Feb 2007 18:46:11 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l1LHkOKm005763;
	Wed, 21 Feb 2007 18:46:25 +0100
Date:	Wed, 21 Feb 2007 17:46:18 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] Fix mmiowb() for MIPS I
In-Reply-To: <20070222.021014.85684636.anemo@mba.ocn.ne.jp>
Message-ID: <Pine.LNX.4.64N.0702211727530.29504@blysk.ds.pg.gda.pl>
References: <20070222.021014.85684636.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.90/2618/Wed Feb 21 15:07:53 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14191
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 22 Feb 2007, Atsushi Nemoto wrote:

> The SYNC instruction is not available on MIPS I.  Use __sync() instead.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> ---
> diff --git a/include/asm-mips/io.h b/include/asm-mips/io.h
> index 92ec261..855c304 100644
> --- a/include/asm-mips/io.h
> +++ b/include/asm-mips/io.h
> @@ -502,8 +502,7 @@ BUILDSTRING(q, u64)
>  #endif
>  
>  
> -/* Depends on MIPS II instruction set */
> -#define mmiowb() asm volatile ("sync" ::: "memory")
> +#define mmiowb() __sync()
>  
>  static inline void memset_io(volatile void __iomem *addr, unsigned char val, int count)
>  {

 That's still not correct -- it should probably be defined like mb() 
currently is as the write-back buffer may defeat strong ordering (IIRC, 
the R2020 can do byte merging).  Also the semantics of mmiowb() does not 
seem to be well specified -- I gather a sequence of:

	writeb(mmioreg, val);
	mmiowb();
	readb(mmioreg);

should guarantee "val" has reached the register (mmiowb() replacing 
incorrect mb() used in many places like this), but with either definition 
of mmiowb() and a MIPS-I-style external write-back buffer it will not 
work.

  Maciej
