Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Nov 2006 13:24:28 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:35342 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20038643AbWKANYW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 1 Nov 2006 13:24:22 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 6666AF5970;
	Wed,  1 Nov 2006 14:24:13 +0100 (CET)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZrZpi4uLvOPT; Wed,  1 Nov 2006 14:24:13 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 1445FF5966;
	Wed,  1 Nov 2006 14:24:12 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.1) with ESMTP id kA1DOHBE023574;
	Wed, 1 Nov 2006 14:24:22 +0100
Date:	Wed, 1 Nov 2006 13:24:13 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Kaz Kylheku <kaz@zeugmasystems.com>
cc:	linux-mips@linux-mips.org
Subject: Re: Cannot run N32 binaries.
In-Reply-To: <66910A579C9312469A7DF9ADB54A8B7D44D290@exchange.ZeugmaSystems.local>
Message-ID: <Pine.LNX.4.64N.0611011314520.15824@blysk.ds.pg.gda.pl>
References: <66910A579C9312469A7DF9ADB54A8B7D44D290@exchange.ZeugmaSystems.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.88.5/2137/Wed Nov  1 09:39:47 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13135
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 31 Oct 2006, Kaz Kylheku wrote:

> I've built an N32 root filesystem: all binaries and libs are "ELF 32-bit
> N32 MSB MIPS-III ..."
> 
> The kernel (2.6.17.7, 64 bit) that I built does have:
> 
> CONFIG_MIPS32_N32=y
> 
> The filesystem doesn't boot: init cannot be found.
[...]
> Basically, for any executable that I try to run, the error is: "No such
> file or directory".

 For a start you could try running a statically linked shell as your 
"init", like specifying "init=/bin/bash.static" at your kernel command 
line.  If that works, check that your shared libraries are where the 
shared loader expects them to be -- for n32 that could be "/lib32", 
"/usr/lib32", etc., but it depends on how it has been built.  Note you can 
invoke the loader manually to examine its behaviour (run it without 
arguments to get some help) and then there are a couple of LD_* 
environment variables that it recognizes that may aid you with figuring 
out what is wrong (you may have to look at the sources for how to use them 
though).

  Maciej
