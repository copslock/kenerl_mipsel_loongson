Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Mar 2007 15:43:44 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:46866 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20021486AbXCUPnm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 21 Mar 2007 15:43:42 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 20097E1C8B;
	Wed, 21 Mar 2007 16:42:57 +0100 (CET)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K0zIEvUjo0wX; Wed, 21 Mar 2007 16:42:56 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id AEB13E1C6E;
	Wed, 21 Mar 2007 16:42:56 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l2LFh8fH019935;
	Wed, 21 Mar 2007 16:43:09 +0100
Date:	Wed, 21 Mar 2007 15:43:03 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Florian Fainelli <florian.fainelli@int-evry.fr>
cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix a warning in lib-64/dump_tlb.c
In-Reply-To: <45FABA5A.5000007@int-evry.fr>
Message-ID: <Pine.LNX.4.64N.0703211540520.2628@blysk.ds.pg.gda.pl>
References: <45FABA5A.5000007@int-evry.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.90.1/2892/Wed Mar 21 11:40:09 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14608
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 16 Mar 2007, Florian Fainelli wrote:

> This patch suppresses a warning in arch/mips/lib-64/dump_tlb.c
> 
> Signed-off-by: Florian Fainelli <florian.fainelli@int-evry.fr>
> 
> -----
> diff --git a/arch/mips/lib-64/dump_tlb.c b/arch/mips/lib-64/dump_tlb.c
> index 8232900..60a87c5 100644
> --- a/arch/mips/lib-64/dump_tlb.c
> +++ b/arch/mips/lib-64/dump_tlb.c
> @@ -30,6 +30,7 @@ static inline const char *msk2str(unsigned int mask)
>         case PM_64M:    return "64Mb";
>         case PM_256M:   return "256Mb";
>  #endif
> +       default:        return NULL;
>         }
>  }

 I guess BUG() would be appropriate here.

  Maciej
