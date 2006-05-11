Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 May 2006 20:14:31 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:48400 "HELO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with SMTP
	id S8133646AbWEKSOX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 11 May 2006 20:14:23 +0200
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 7A7CEF5F46;
	Thu, 11 May 2006 20:14:17 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 03649-06; Thu, 11 May 2006 20:14:17 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 21C48F5EDE;
	Thu, 11 May 2006 20:14:17 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.6/8.13.1) with ESMTP id k4BIESus012304;
	Thu, 11 May 2006 20:14:28 +0200
Date:	Thu, 11 May 2006 19:14:22 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Martin Michlmayr <tbm@cyrius.com>
cc:	Karel van Houten <Karel@vhouten.xs4all.nl>,
	debian-mips@lists.debian.org, linux-mips@linux-mips.org
Subject: Re: 2.6 for DECstation, d-i
In-Reply-To: <20060511173350.GM7827@deprecation.cyrius.com>
Message-ID: <Pine.LNX.4.64N.0605111853500.20004@blysk.ds.pg.gda.pl>
References: <44635C0D.7040901@vhouten.xs4all.nl> <20060511173350.GM7827@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.88.2/1457/Thu May 11 19:25:16 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11404
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 11 May 2006, Martin Michlmayr wrote:

> >    * You don't seem to have included the DEC serial drivers and console
> >      support for the /260, because after the prom-io I loose all output
> >      on the serial line (my /260 has serial console only).
> 
> Zilog Z8530 support for DECstation hasn't been ported to 2.6 yet.

 Well, not exactly ported, but hacked up enough it worked the last time I 
tried, but you have to disable the virtual terminal (CONFIG_VT) as it is 
the keyboard driver (lk201) that has not been ported at all.  If in doubt, 
please start with "decstation_defconfig", that should build and boot 
successfully, and work from there.

> >    * When I let it boot without console, it will happily go multiuser.
> >      See boot messages below.
> >    * My second SCSI card does not seem to work as it should. Works OK
> >      under 2.4.27.
> 
> Maciej, do you have any idea?

 I have a PMAZ-A around, though I am not sure if I have everything needed 
to wire it to a device (hmm, I should probably make sure if I am to be 
serious about adding support for the PMAZC...).  Meanwhile I can have a 
look at the source code to see if there is anything obviously wrong there.

  Maciej
