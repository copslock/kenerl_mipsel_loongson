Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g487sYwJ024588
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 8 May 2002 00:54:34 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g487sYQa024587
	for linux-mips-outgoing; Wed, 8 May 2002 00:54:34 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from tarzan.ugyvitelszolgaltato.hu ([213.163.26.102])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g487sQwJ024581
	for <linux-mips@oss.sgi.com>; Wed, 8 May 2002 00:54:28 -0700
Received: from atti.ugyvitelszolgaltato.hu (atti.ugyvitelszolgaltato.hu [193.80.82.9])
	by tarzan.ugyvitelszolgaltato.hu (8.9.3/8.9.3/Debian 8.9.3-21) with ESMTP id KAA04987
	for <linux-mips@oss.sgi.com>; Wed, 8 May 2002 10:21:25 +0200
Received: from root by atti.ugyvitelszolgaltato.hu with local (Exim 3.12 #1 (Debian))
	id 175MI0-0000U6-00
	for <linux-mips@oss.sgi.com>; Wed, 08 May 2002 09:55:08 +0200
Date: Wed, 8 May 2002 09:55:08 +0200
From: Szabo Attila <trial@ugyvitelszolgaltato.hu>
To: linux-mips@oss.sgi.com
Subject: indy scsi
Message-ID: <20020508095508.A1682@ugyvitelszolgaltato.hu>
Mail-Followup-To: linux-mips@oss.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Ugyvitelszolgaltato Kft.
X-OS: Linux 2.4.17, Debian 2.2
X-Sys: MSI K7TM Pro, AMD Tbird 850MHz, 256MB RAM, Gef2 MX, 10GB Hdd
X-WM: Blackbox 0.61
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi !

I've put a WD enterprise 4360 Ultra3 scsi disk into my Indy.
It is the only disk, and I disabled the wide negotiating on the disk.
But it is too slow.I'm running debian woody and I've tested it
with hdparm, but the buffered disk reads is just 1.7 MB/sec.
It is very slow !!
Is there any way to make it faster ??

Thanks

-- 
------------------------------------------------------
A t t i l a | trial@ugyvitelszolgaltato.hu | S z a b o
------------------------------------------------------
