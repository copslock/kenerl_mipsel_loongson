Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Oct 2005 17:01:51 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:7949 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S8133470AbVJDQBb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 4 Oct 2005 17:01:31 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 8ABCAF59C8; Tue,  4 Oct 2005 18:01:24 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 23821-01; Tue,  4 Oct 2005 18:01:24 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 49F69E1CD3; Tue,  4 Oct 2005 18:01:24 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j94G1ST0012171;
	Tue, 4 Oct 2005 18:01:28 +0200
Date:	Tue, 4 Oct 2005 17:01:37 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Franck <vagabon.xyz@gmail.com>
Cc:	"Kevin D. Kissell" <kevink@mips.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] Add support for 4KS cpu.
In-Reply-To: <cda58cb80510040818v6d93fe53w@mail.gmail.com>
Message-ID: <Pine.LNX.4.61L.0510041651150.10696@blysk.ds.pg.gda.pl>
References: <cda58cb80510040149p690397afo@mail.gmail.com> 
 <Pine.LNX.4.61L.0510041219500.10696@blysk.ds.pg.gda.pl>  <434277D5.1090603@mips.com>
  <Pine.LNX.4.61L.0510041358300.10696@blysk.ds.pg.gda.pl>  <434289A7.50007@mips.com>
 <cda58cb80510040818v6d93fe53w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.86.2/1109/Tue Oct  4 00:06:28 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9138
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 4 Oct 2005, Franck wrote:

> should I pass these options to GCC for 4KSc ?
> 
> cflags-$(CONFIG_CPU_4KSC)      += \
>                        $(call set_gccflags,4kc,mips32r1,r4600,mips3,mips2) \
>                        -msmartmips -Wa,--trap

 s/mips32r1/mips32/, otherwise OK.

 But since you seem to use SDE, you may as well just use "4ksc" (and 
possibly skip "-msmartmips" as it's implied); similarly for "4ksd".  
Unfortunately documentation on what CPU types are accepted seems to be 
incomplete -- use `gcc -v --help' to see which ones are actually 
available.

  Maciej
