Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Apr 2006 11:25:02 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:22027 "HELO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with SMTP
	id S8133464AbWD1KYw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 28 Apr 2006 11:24:52 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id E7B17F5D94;
	Fri, 28 Apr 2006 12:24:47 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 14778-08; Fri, 28 Apr 2006 12:24:47 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id A5C9AF5D93;
	Fri, 28 Apr 2006 12:24:47 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.6/8.13.1) with ESMTP id k3SAOm8T017396;
	Fri, 28 Apr 2006 12:24:52 +0200
Date:	Fri, 28 Apr 2006 11:24:45 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	"Kevin D. Kissell" <kevink@mips.com>
cc:	gowri@bitel.co.kr, linux-mips@linux-mips.org
Subject: Re: Java virtual machine on linux MIPS
In-Reply-To: <000d01c66a9c$c6686290$10eca8c0@grendel>
Message-ID: <Pine.LNX.4.64N.0604281120510.32041@blysk.ds.pg.gda.pl>
References: <1146188366.3034.6.camel@localhost.localdomain>
 <000d01c66a9c$c6686290$10eca8c0@grendel>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.88.1/1428/Thu Apr 27 20:39:31 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11234
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 28 Apr 2006, Kevin D. Kissell wrote:

> It's been several years, but at one point I successfully tested
> and benchmarked commercail JVMs from Insignia (now part
> of Esmertec, www.esmertec.com) and Skelmir (www.skelmir.com),
> and managed to get the open source Kaffe VM (www.kaffe.org) 
> running on MIPS Linux as well.  Kaffe has a JIT that has, alas,
> been broken for MIPS and most other RISC architectures for
> the last couple of years, but the JVM still works OK in interpreted 
> mode. I'm sure that there are other options - those are just the ones
> I've had hands-on experience with.

 And there is of course GIJ -- a part of GCC (which is also able to 
compile Java source code to native machine code and link it with Java 
bytecode if necessary).  I'm not sure how capable it is these days though.

  Maciej
