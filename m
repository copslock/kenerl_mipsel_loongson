Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4749DwJ000964
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 6 May 2002 21:09:13 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4749Dvt000963
	for linux-mips-outgoing; Mon, 6 May 2002 21:09:13 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dtla2.teknuts.com (adsl-66-125-62-110.dsl.lsan03.pacbell.net [66.125.62.110])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g47499wJ000960
	for <linux-mips@oss.sgi.com>; Mon, 6 May 2002 21:09:09 -0700
Received: from delllaptop ([208.187.134.77])
	(authenticated)
	by dtla2.teknuts.com (8.11.3/8.10.1) with ESMTP id g474ASE05822
	for <linux-mips@oss.sgi.com>; Mon, 6 May 2002 21:10:28 -0700
From: "Robert Rusek" <robru@teknuts.com>
To: <linux-mips@oss.sgi.com>
Subject: depmod help !
Date: Mon, 6 May 2002 21:09:11 -0700
Message-ID: <001501c1f57c$f2188e90$6601a8c0@delllaptop>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I am running his on an Indy. I have kernel 2.4.17 and modutils 2.4.16.
When a depmod is performed I get the following message:

depmod: cannot read ELF header from /lib/modules/2.4.17/modules.dep
depmod: cannot read ELF header from
/lib/modules/2.4.17/modules.generic_string
depmod: /lib/modules/2.4.17/modules.ieee1394map is not an ELF file
depmod: /lib/modules/2.4.17/modules.isapnpmap is not an ELF file
depmod: cannot read ELF header from
/lib/modules/2.4.17/modules.parportmap
depmod: /lib/modules/2.4.17/modules.pcimap is not an ELF file
depmod: cannot read ELF header from
/lib/modules/2.4.17/modules.pnpbiosmap
depmod: /lib/modules/2.4.17/modules.usbmap is not an ELF file

How can I correct this?  I am trying to clean up my startup before I
start using the machine.

Thank you in advance.
--
Robert Rusek
