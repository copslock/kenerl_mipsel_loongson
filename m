Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 May 2005 11:50:05 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:39695 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8226195AbVEQKtu>; Tue, 17 May 2005 11:49:50 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id C014EF5A39; Tue, 17 May 2005 12:49:44 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 05584-07; Tue, 17 May 2005 12:49:44 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 8AC03F5A2C; Tue, 17 May 2005 12:49:44 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id j4HAnkls004589;
	Tue, 17 May 2005 12:49:46 +0200
Date:	Tue, 17 May 2005 11:49:52 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Michael Belamina <belamina1@yahoo.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: 64 bit kernel for BCM1250
In-Reply-To: <20050517093633.76783.qmail@web32507.mail.mud.yahoo.com>
Message-ID: <Pine.LNX.4.61L.0505171145040.17529@blysk.ds.pg.gda.pl>
References: <20050517093633.76783.qmail@web32507.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.83/882/Tue May 17 08:48:03 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7921
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 17 May 2005, Michael Belamina wrote:

>   I have built a 64 bit kernel for BCM1250.
>   When the kernel is loaded and control is passed to
> kernel_entry there is an exception:
> 
> CFE> boot -elf LinuxServer:vmlinux.64
[...]

 I'm assuming vmlinux.64 is a 64-bit ELF file.  If so, then, well, 
depending on the version of CFE you have, this may or may not work.  The 
workaround is to always use 32-bit ELF files.  You should get one after 
your Linux build -- if not (which may depend on how you do builds), then 
try `make vmlinux.32' and use the result.

  Maciej
