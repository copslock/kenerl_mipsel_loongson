Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id EAA78856 for <linux-archive@neteng.engr.sgi.com>; Tue, 16 Mar 1999 04:01:07 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id EAA84529
	for linux-list;
	Tue, 16 Mar 1999 04:00:13 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from deliverator.sgi.com (deliverator.sgi.com [150.166.91.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id EAA39959
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 16 Mar 1999 04:00:11 -0800 (PST)
	mail_from (eedthwo@eede.ericsson.se)
Received: from penguin.wise.edt.ericsson.se (penguin-ext.wise.edt.ericsson.se [194.237.142.5]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id DAA25590
	for <linux@cthulhu.engr.sgi.com>; Tue, 16 Mar 1999 03:59:54 -0800 (PST)
	mail_from (eedthwo@eede.ericsson.se)
Received: from eede.ericsson.se (eede.eede.ericsson.se [164.48.127.16])
	by penguin.wise.edt.ericsson.se (8.9.0/8.9.0/WIREfire-1.2) with SMTP id MAA24431;
	Tue, 16 Mar 1999 12:59:44 +0100 (MET)
Received: from sun168.eu (sun168.eede.ericsson.se) by eede.ericsson.se (4.1/SMI-4.1)
	id AA02071; Tue, 16 Mar 99 12:59:52 +0100
Received: by sun168.eu (SMI-8.6/SMI-SVR4)
	id MAA12251; Tue, 16 Mar 1999 12:59:52 +0100
Date: Tue, 16 Mar 1999 12:59:52 +0100
Message-Id: <199903161159.MAA12251@sun168.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Tom Woelfel <eedthwo@eede.ericsson.se>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux@cthulhu.engr.sgi.com
Subject: initrd is working and new test image
In-Reply-To: <19990313131944.A809@alpha.franken.de>
References: <19990313131944.A809@alpha.franken.de>
X-Mailer: VM 6.31 under 20.2 XEmacs Lucid
Reply-To: eedthwo@eede.ericsson.se
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Thomas Bogendoerfer writes:
 > Hi,

Hi,

 > For now, I've built a new kernel with an attached initrd. This initrd
 > contains a shell (ash) and some utilities (ls, mount, etc.) plus the
 > needed shared libraries. When you boot this kernel, you should see
 > the message will "Welcome to Linux/MIPS" and should be dropped into a single 
 > user shell.
 > 
 > So people with the problem seeing only "Freeing unused kernel memory",
 > please try it, and report your experiences.

Yesss, this works. After netbooting I find myself in the shell. The
included prog's are working. Well, actually I've rearranded my desk a
little bit, and while 'the X-files' are running in the background I
played a little bit ;-)

I was furthermore able to create a directory (/mnt) and
(straightforward) I tried to mount the root-dir from the server. This
works too, but whith some error-messages (RPC sendmsg returned error
code 128). After setting LD_LIBRARY_PATH it was aslo possible to
execute /misc/installinit/init. The following mount-request for /proc
ended the program. 

Hope this helps,

Tom
