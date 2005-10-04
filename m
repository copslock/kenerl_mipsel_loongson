Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Oct 2005 14:29:48 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:54536 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S8133463AbVJDN3d (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 4 Oct 2005 14:29:33 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id DF498F59BA; Tue,  4 Oct 2005 15:29:27 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 31526-05; Tue,  4 Oct 2005 15:29:27 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id A8404E1CA1; Tue,  4 Oct 2005 15:29:27 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j94DTVAF003188;
	Tue, 4 Oct 2005 15:29:31 +0200
Date:	Tue, 4 Oct 2005 14:29:38 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	"Kevin D. Kissell" <kevink@mips.com>
Cc:	Franck <vagabon.xyz@gmail.com>, Ralf Baechle <ralf@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] Add support for 4KS cpu.
In-Reply-To: <434277D5.1090603@mips.com>
Message-ID: <Pine.LNX.4.61L.0510041358300.10696@blysk.ds.pg.gda.pl>
References: <cda58cb80510040149p690397afo@mail.gmail.com>
 <Pine.LNX.4.61L.0510041219500.10696@blysk.ds.pg.gda.pl> <434277D5.1090603@mips.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.86.2/1109/Tue Oct  4 00:06:28 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9131
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 4 Oct 2005, Kevin D. Kissell wrote:

> FWIW, the 4KSc is a strict superset of the 4Kc (anticipating
> *some* of the Release 2 features, but not requiring them to be
> used) and the 4KSd is a strict superset of the 4KE.  I would
> not recommend configuring CPU_MIPS32_R2 for the 4KSc.

 Well, the patch asked GCC to use the instruction set of the "4kec" CPU 
for both (and also the "mips32r2" ISA, but that's overridden by the 
former), so it must have been incorrect in the first place -- I have only 
referred to this.

> They also have some physical security and cryptography accelleration
> features, some of which use extended CPU state that would
> require some kernel context management support if anyone wanted
> to actually use them in Linux applications. The real point of
> having a CPU_4KSC config flag would be to enable building-in
> such support.

 This would make sense, but I'm afraid the proposal was far from that... 

  Maciej
