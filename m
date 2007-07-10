Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Jul 2007 18:36:52 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:20235 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20021828AbXGJRgu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 10 Jul 2007 18:36:50 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 4BAEAE1CFF;
	Tue, 10 Jul 2007 19:36:45 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XD5IEqfYY5vA; Tue, 10 Jul 2007 19:36:45 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id E6863E1C65;
	Tue, 10 Jul 2007 19:36:44 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l6AHaqsd015399;
	Tue, 10 Jul 2007 19:36:52 +0200
Date:	Tue, 10 Jul 2007 18:36:50 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Peter Watkins <pwatkins@sicortex.com>
cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] [MIPS] Fix resume for 64K page size
In-Reply-To: <11840880513393-git-send-email-pwatkins@sicortex.com>
Message-ID: <Pine.LNX.4.64N.0707101834570.18036@blysk.ds.pg.gda.pl>
References: <11840880513393-git-send-email-pwatkins@sicortex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.90.3/3621/Tue Jul 10 15:01:04 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15674
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 10 Jul 2007, pwatkins@sicortex.com wrote:

> @@ -85,7 +85,7 @@ #endif
>  	move	$28, a2
>  	cpu_restore_nonscratch a1
>  
> -#if (_THREAD_SIZE - 32) < 0x10000
> +#if (_THREAD_SIZE) < 0x10000
>  	PTR_ADDIU	t0, $28, _THREAD_SIZE - 32
>  #else
>  	PTR_LI		t0, _THREAD_SIZE - 32

 It looks wrong to me.  Shouldn't that be:

#if (_THREAD_SIZE - 32) < 0x8000

  Maciej
