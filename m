Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jul 2007 16:27:58 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:61960 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20023036AbXGEP1w (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 5 Jul 2007 16:27:52 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id D3009E1CB6;
	Thu,  5 Jul 2007 17:27:11 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g+WwrKbmqPEN; Thu,  5 Jul 2007 17:27:11 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 8514DE1C67;
	Thu,  5 Jul 2007 17:27:11 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l65FRN7N008439;
	Thu, 5 Jul 2007 17:27:23 +0200
Date:	Thu, 5 Jul 2007 16:27:21 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	linux-mips@linux-mips.org,
	"Robert P. J. Day" <rpjday@mindspring.com>
Subject: Re: dead(?) MIPS config stuff
In-Reply-To: <20070705144641.GA20210@linux-mips.org>
Message-ID: <Pine.LNX.4.64N.0707051621570.13346@blysk.ds.pg.gda.pl>
References: <20070705144641.GA20210@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.90.3/3604/Thu Jul  5 12:33:34 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15614
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 5 Jul 2007, Ralf Baechle wrote:

> ========== CPU_R4000 ==========
> arch/mips/kernel/Makefile:20:obj-$(CONFIG_CPU_R4000)		+= r4k_fpu.o r4k_switch.o
> arch/mips/kernel/cpu-bugs64.c:159:#ifndef CONFIG_CPU_R4000
> arch/mips/kernel/cpu-bugs64.c:237:#if !defined(CONFIG_CPU_R4000) && !defined(CONFIG_CPU_R4400)
> arch/mips/kernel/cpu-bugs64.c:307:#if !defined(CONFIG_CPU_R4000) && !defined(CONFIG_CPU_R4400)
> ========== CPU_R4400 ==========
> arch/mips/kernel/cpu-bugs64.c:237:#if !defined(CONFIG_CPU_R4000) && !defined(CONFIG_CPU_R4400)
> arch/mips/kernel/cpu-bugs64.c:307:#if !defined(CONFIG_CPU_R4000) && !defined(CONFIG_CPU_R4400)

 I should at last port that patch with a workaround for R4000/R4400 errata 
-- it has been long overdue now.  Let's make it the item #3 on my to-do 
list. ;-)  I'm not sure that'll keep the names of the options though.

 Thanks for the reminder.

  Maciej
