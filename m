Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6I7Z3v09140
	for linux-mips-outgoing; Wed, 18 Jul 2001 00:35:03 -0700
Received: from chakotay.allgaeu.org (chakotay.allgaeu.org [213.182.8.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6I7Z1V09134
	for <linux-mips@oss.sgi.com>; Wed, 18 Jul 2001 00:35:01 -0700
Received: from tuvok.allgaeu.org (tuvok.allgaeu.org [213.182.8.4])
	by chakotay.allgaeu.org (8.9.3/8.9.3) with ESMTP id JAA20313
	for <linux-mips@oss.sgi.com>; Wed, 18 Jul 2001 09:34:59 +0200
Received: by tuvok.allgaeu.org (Postfix, from userid 1000)
	id CC54E31C; Wed, 18 Jul 2001 09:34:58 +0200 (CEST)
Date: Wed, 18 Jul 2001 09:34:58 +0200
From: Robert Einsle <robert@einsle.de>
To: linux-mips@oss.sgi.com
Subject: Booting an SGI Indy from Harddisk
Message-ID: <20010718093458.A27749@tuvok.allgaeu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hy all

I've a little Problem booting an SGI Indy from Harddisk.
There is Linux Debian installen, and i made with dvhtool
an korrekt Startfile.
While starting, the indy loads the Kernel, and boots.
But then, it mounts my root-Partition from the remote
Server where i had the install-Partition. 
How can I tell the Indy to boot from /dev/sda1
I think i must set an StartOS ... but i dont knew
what, and i don't knew where to search.
TNX for help.

-- 
MFG

Robert Einsle
BNA Technik, Postmaster

>>Warum muss ich bei "Verwaltung von Problemloesungen
fuer eine EDV-Abteilung" an einen Waffenschrank denken?<<
(Robin S. Socha in de.comp.os.unix.linux.misc)
