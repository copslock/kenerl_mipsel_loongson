Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Dec 2004 13:18:09 +0000 (GMT)
Received: from pD9562F66.dip.t-dialin.net ([IPv6:::ffff:217.86.47.102]:62226
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225005AbULONSF>; Wed, 15 Dec 2004 13:18:05 +0000
Received: from fluff.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id iBFDHsEO028336;
	Wed, 15 Dec 2004 14:17:54 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id iBFDHrXe028335;
	Wed, 15 Dec 2004 14:17:53 +0100
Date: Wed, 15 Dec 2004 14:17:53 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Tatsuya Koseki <koseki@shimafuji.co.jp>
Cc: Linux MIPS mailing list <linux-mips@linux-mips.org>
Subject: Re: kernel 2.6.9 patch
Message-ID: <20041215131753.GC27935@linux-mips.org>
References: <009001c4e1ba$54a431f0$2100a8c0@koseki>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <009001c4e1ba$54a431f0$2100a8c0@koseki>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6666
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Dec 14, 2004 at 05:53:02PM +0900, Tatsuya Koseki wrote:

> Subject: kernel 2.6.9 patch
> Date: Tue, 14 Dec 2004 17:53:02 +0900
> Content-Type: text/plain;
> 	charset="iso-2022-jp"
> 
> Please review 
> 
> 
> --- linux/include/asm/stackframe.h.old Tue Dec 14 17:49:38 2004
> +++ linux/include/asm/stackframe.h Tue Dec 14 17:50:35 2004
> @@ -244,6 +244,10 @@
>    nor v1, $0, v1
>    and v0, v1
>    or v0, a0
> +
> +  li v1,2
> +  or v0,v1
> +
>    mtc0 v0, CP0_STATUS
>    LONG_L v1, PT_EPC(sp)
>    MTC0 v1, CP0_EPC

 o Your patch got corrupted by using a differnet indentation so couldn't be
   applied anyway
 o When posting a patch, post an explanation.  If the purpose of a patch
   isn't obvious it'll likely be ignroed.
 o This bug was already fixed in CVS.
 o The issue only affected new-born processes, so there is no reason to
   burden the fix on every exception taken.
 o Why using two instruction if one would be sufficient.

  Ralf
