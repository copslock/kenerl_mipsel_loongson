Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g48EO4wJ029523
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 8 May 2002 07:24:04 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g48EO4qA029522
	for linux-mips-outgoing; Wed, 8 May 2002 07:24:04 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from the-village.bc.nu (lightning.swansea.linux.org.uk [194.168.151.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g48ENwwJ029515
	for <linux-mips@oss.sgi.com>; Wed, 8 May 2002 07:24:00 -0700
Received: from alan by the-village.bc.nu with local (Exim 3.33 #5)
	id 175RdX-0001aT-00; Wed, 08 May 2002 14:37:43 +0100
Subject: Re: indy scsi
To: trial@ugyvitelszolgaltato.hu (Szabo Attila)
Date: Wed, 8 May 2002 14:37:43 +0100 (BST)
Cc: linux-mips@oss.sgi.com
In-Reply-To: <20020508144247.A2023@ugyvitelszolgaltato.hu> from "Szabo Attila" at May 08, 2002 02:42:47 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E175RdX-0001aT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> Yes, I know all of that, and I've expected only max 3-5 MB/sec but not
> 1.7.
> The scsi bandwith on indy is 10MB/s, the disk is above 10 MB/s.
> Maybe I expect too much

An old 2Gb 5400 RPM drive ought to deliver about 2Mbytes/second data rates.
The 1.7 sounds suprisingly low unless the driver code doesn't support 
disconnect and scsi2 tagged stuff. For an old NCR538x/9x device without
those it sounds all too believable.

Alan
