Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBEKqMi08544
	for linux-mips-outgoing; Fri, 14 Dec 2001 12:52:22 -0800
Received: from mail.ivivity.com (user-vc8ftn3.biz.mindspring.com [216.135.246.227])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBEKqKo08541
	for <linux-mips@oss.sgi.com>; Fri, 14 Dec 2001 12:52:20 -0800
Received: by ATLOPS with Internet Mail Service (5.5.2448.0)
	id <QMJC3GDT>; Fri, 14 Dec 2001 14:52:12 -0500
Message-ID: <25369470B6F0D41194820002B328BDD21423EC@ATLOPS>
From: Dinesh Nagpure <dinesh_nagpure@ivivity.com>
To: "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Subject: 2.4.16 on mips-malta, networking fails...
Date: Fri, 14 Dec 2001 14:52:12 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hello,
I am trying kernel v2.4.16 on mips-malta, but networking does not seem to be
working for me.
ping errors out saying sendto: Network is unreachable.
I have AMD PCNet32 PCI support enabled under Network device support-Ethernet
(10 or 100)- EISA, VLB, PCI and onboard controllers. 
Any ideas?

Dinesh
iVIVITY Inc.
