Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jan 2006 11:06:37 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:17413 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S8133443AbWAYLGU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 25 Jan 2006 11:06:20 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id D4EF1F5B7E;
	Wed, 25 Jan 2006 12:10:39 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 18900-09; Wed, 25 Jan 2006 12:10:39 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 70C01F5B78;
	Wed, 25 Jan 2006 12:10:39 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id k0PBAVoq030442;
	Wed, 25 Jan 2006 12:10:33 +0100
Date:	Wed, 25 Jan 2006 11:10:39 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	"Peter 'p2' De Schrijver" <p2@mind.be>
Cc:	Martin Michlmayr <tbm@cyrius.com>, linux-mips@linux-mips.org
Subject: Re: DECstation R3000 boot error
In-Reply-To: <20060124232117.GA4165@codecarver>
Message-ID: <Pine.LNX.4.64N.0601251103020.7675@blysk.ds.pg.gda.pl>
References: <20060123225040.GA23576@deprecation.cyrius.com>
 <Pine.LNX.4.64N.0601241059140.11021@blysk.ds.pg.gda.pl>
 <20060124122700.GA8527@deprecation.cyrius.com>
 <Pine.LNX.4.64N.0601241227290.11021@blysk.ds.pg.gda.pl> <20060124232117.GA4165@codecarver>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.87.1/1248/Tue Jan 24 11:54:38 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10124
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 25 Jan 2006, Peter 'p2' De Schrijver wrote:

> Code: 00000000  00000000  24861000 <fc800000> fc800008  fc800010 fc800018  24840040  fc80ffe0
> Kernel panic - not syncing: Attempted to kill the idle task!

 Hmm, the code is:

00000000	nop
00000000	nop
24861000	addiu	a2,a0,4096
fc800000	sd	zero,0(a0)
fc800008	sd	zero,8(a0)
fc800010	sd	zero,16(a0)
fc800018	sd	zero,24(a0)
24840040	addiu	a0,a0,64
fc80ffe0	sd	zero,-32(a0)

and it obviously cannot work on a MIPS I processor.  That's probably from 
broken assembly code somewhere -- I should have my sources updated within 
a few days and I'll see if I can reproduce the problem.

  Maciej
