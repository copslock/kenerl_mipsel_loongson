Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Sep 2008 17:12:19 +0100 (BST)
Received: from kirk.serum.com.pl ([213.77.9.205]:43517 "EHLO serum.com.pl")
	by ftp.linux-mips.org with ESMTP id S29562185AbYISQJZ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 19 Sep 2008 17:09:25 +0100
Received: from serum.com.pl (IDENT:macro@localhost [127.0.0.1])
	by serum.com.pl (8.12.11/8.12.11) with ESMTP id m8JG9NbS031545;
	Fri, 19 Sep 2008 18:09:23 +0200
Received: from localhost (macro@localhost)
	by serum.com.pl (8.12.11/8.12.11/Submit) with ESMTP id m8JG9Hwo031541;
	Fri, 19 Sep 2008 17:09:18 +0100
Date:	Fri, 19 Sep 2008 17:09:17 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
cc:	u1@terran.org, linux-mips@linux-mips.org
Subject: Re: MIPS checksum bug
In-Reply-To: <20080920.004319.93205397.anemo@mba.ocn.ne.jp>
Message-ID: <Pine.LNX.4.55.0809191656030.29711@cliff.in.clinika.pl>
References: <20080917.222350.41199051.anemo@mba.ocn.ne.jp>
 <BD7F24AB-4B0C-4FA4-ADB3-5A86E7A4624F@terran.org> <20080919.011704.59652451.anemo@mba.ocn.ne.jp>
 <20080920.004319.93205397.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20563
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, 20 Sep 2008, Atsushi Nemoto wrote:

> @@ -229,6 +239,9 @@ LEAF(csum_partial)
>  
>  	/* Still a full word to go  */
>  	ulw	t1, (src)
> +#ifdef USE_DOUBLE
> +	add	t1, zero	/* clear upper 32bit */
> +#endif
>  	PTR_ADDIU	src, 4
>  	ADDC(sum, t1)
>  

 Unfortunately you can't zero-extend with a single instruction (you can
use a single sll(v) to sign-extend), unless the R2 ISA provides some
suitable oddity (which I haven't checked).  You want something like:

	dsll32	t1, t1, 0
	dsrl32	t1, t1, 0

instead.

  Maciej
