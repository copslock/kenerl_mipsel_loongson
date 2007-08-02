Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Aug 2007 12:26:59 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:13576 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20022066AbXHBL0x (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 2 Aug 2007 12:26:53 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id E593EE1C75;
	Thu,  2 Aug 2007 13:26:19 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rAuGmHRvQvv1; Thu,  2 Aug 2007 13:26:19 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 9CA94E1C71;
	Thu,  2 Aug 2007 13:26:19 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l72BQQDm012808;
	Thu, 2 Aug 2007 13:26:26 +0200
Date:	Thu, 2 Aug 2007 12:26:22 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	Imre Kaloz <kaloz@openwrt.org>,
	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: Sync SiByte system code to the new DUART driver
In-Reply-To: <20070802111314.GA25949@linux-mips.org>
Message-ID: <Pine.LNX.4.64N.0708021218280.22591@blysk.ds.pg.gda.pl>
References: <op.twfh4cuw2s3iss@ecaz.afh.b-m.hu> <20070802111314.GA25949@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.1/3846/Wed Aug  1 09:27:07 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16018
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 2 Aug 2007, Ralf Baechle wrote:

> Hmm...  You just found the tip of the iceberg ...
> 
> $ git grep -w CONFIG_SIBYTE_SB1250_DUART | cat -
> arch/mips/configs/bigsur_defconfig:CONFIG_SIBYTE_SB1250_DUART=y
> arch/mips/configs/sb1250-swarm_defconfig:CONFIG_SIBYTE_SB1250_DUART=y
> arch/mips/sibyte/bcm1480/irq.c:#ifdef CONFIG_SIBYTE_SB1250_DUART
> arch/mips/sibyte/bcm1480/irq.c:#ifdef CONFIG_SIBYTE_SB1250_DUART
> arch/mips/sibyte/cfe/console.c:#ifdef CONFIG_SIBYTE_SB1250_DUART
> arch/mips/sibyte/sb1250/irq.c:#ifdef CONFIG_SIBYTE_SB1250_DUART
> arch/mips/sibyte/sb1250/irq.c:#ifdef CONFIG_SIBYTE_SB1250_DUART

 Most of that stuff does not work anymore anyway and now you risk link 
errors. ;-)  I do not think there is place for driver-related #ifdefs 
under arch/ anyway, the answer being platform devices.  Though chances are 
nobody might be bothered to ever implement them here.

 Also the #ifdefs in arch/mips/sibyte/cfe/console.c do not make sense to 
me.

  Maciej
