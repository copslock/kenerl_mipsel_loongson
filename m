Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Oct 2005 12:34:26 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:25361 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S8133464AbVJDLeJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 4 Oct 2005 12:34:09 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 2B80CF59BA; Tue,  4 Oct 2005 13:34:04 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 27403-05; Tue,  4 Oct 2005 13:34:04 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id E2C5FF5995; Tue,  4 Oct 2005 13:34:03 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j94BY6hX029176;
	Tue, 4 Oct 2005 13:34:07 +0200
Date:	Tue, 4 Oct 2005 12:34:12 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Franck <vagabon.xyz@gmail.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] Add support for 4KS cpu.
In-Reply-To: <cda58cb80510040149p690397afo@mail.gmail.com>
Message-ID: <Pine.LNX.4.61L.0510041219500.10696@blysk.ds.pg.gda.pl>
References: <cda58cb80510040149p690397afo@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.86.2/1109/Tue Oct  4 00:06:28 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9128
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 4 Oct 2005, Franck wrote:

> This patch adds support for both 4ksc and 4ksd cpus. These cpu are
> mainly used in embedded system such as smartcard or point of sell
> devices as they provide some extra security features.

 Please send patches inline.

 Apart from the change to "arch/mips/kernel/cpu-probe.c", which is useful, 
what's the benefit of the changes?  Specifically how is selecting e.g. 
"CPU_4KSC" meant to be different from "CPU_MIPS32_R2"?  Do you want to 
make GCC tune your code according to a specific's CPU pipeline 
description?  If so, then it should probably be done a bit differently and 
there is actually no need to differentiate between specific members of the 
4K family.

> Signed-off-by: Franck <vagabon.xyz@gmail.com>

 You should rather use your real name here.  [Hmm, why am I responding to 
an anonym in the first place?...]

  Maciej
