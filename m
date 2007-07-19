Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jul 2007 16:31:46 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:3592 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20022638AbXGSPbn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 19 Jul 2007 16:31:43 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id B0475E1C77;
	Thu, 19 Jul 2007 17:31:39 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ISl7PG-EduC2; Thu, 19 Jul 2007 17:31:39 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 6576EE1C65;
	Thu, 19 Jul 2007 17:31:39 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l6JFVm9V003840;
	Thu, 19 Jul 2007 17:31:49 +0200
Date:	Thu, 19 Jul 2007 16:31:43 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Daniel Laird <daniel.j.laird@nxp.com>
cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix known HW bug with MIPS core on NXP/Philips PNX8550
In-Reply-To: <469F822D.9040209@nxp.com>
Message-ID: <Pine.LNX.4.64N.0707191629200.1861@blysk.ds.pg.gda.pl>
References: <469F822D.9040209@nxp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.1/3700/Thu Jul 19 15:13:47 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15820
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 19 Jul 2007, Daniel Laird wrote:

> @@ -435,6 +435,9 @@
>     label_nopage_tlbm,
>     label_smp_pgtable_change,
>     label_r3000_write_probe_fail,
> +#ifdef CONFIG_PNX8550
> +    label_pnx8550_bac_reset
> +#endif
> };
> 
> struct label {

 You have formatting problems (mailer suspected), a comma is missing from 
the above fragment and the whole proposal is a horrible #ifdef maze.  Can 
you please rewrite it in a more orderly fashion?

  Maciej
