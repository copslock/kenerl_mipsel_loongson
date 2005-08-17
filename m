Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Aug 2005 10:57:53 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:16650 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224982AbVHQJ5e>; Wed, 17 Aug 2005 10:57:34 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 61E2BE1C69; Wed, 17 Aug 2005 12:02:17 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 16612-10; Wed, 17 Aug 2005 12:02:17 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id EA191E1C63; Wed, 17 Aug 2005 12:02:16 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j7HA2IeU022419;
	Wed, 17 Aug 2005 12:02:19 +0200
Date:	Wed, 17 Aug 2005 11:02:23 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Andrew Isaacson <adi@broadcom.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] casts in TLB macros
In-Reply-To: <20050817030608.GM24444@broadcom.com>
Message-ID: <Pine.LNX.4.61L.0508171053150.10940@blysk.ds.pg.gda.pl>
References: <20050817030608.GM24444@broadcom.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/1027/Wed Aug 17 01:44:00 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8758
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 16 Aug 2005, Andrew Isaacson wrote:

> @@ -748,7 +748,7 @@
>  do {									\
>  	__asm__ __volatile__(						\
>  		"ctc0\t%z0, " #register "\n\t"				\
> -		: : "Jr" ((unsigned int)value));			\
> +		: : "Jr" (unsigned int)(value));			\
>  } while (0)
>  
>  /*

 I'm surprised it works, but please don't drop the outer brackets in asm 
operands anyway.  Otherwise it's an obvious fix, thanks.

  Maciej
