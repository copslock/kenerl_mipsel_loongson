Received: (from majordomo@localhost)
	by oss.sgi.com (8.10.1/8.10.1) id e4JMtFe03149
	for linuxmips-outgoing; Fri, 19 May 2000 15:55:15 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linuxmips@oss.sgi.com using -f
Received: from pneumatic-tube.sgi.com (pneumatic-tube.sgi.com [204.94.214.22])
	by oss.sgi.com (8.10.1/8.10.1) with ESMTP id e4JMtEU03144;
	Fri, 19 May 2000 15:55:14 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id PAA05431; Fri, 19 May 2000 15:59:49 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA12361
	for linux-list;
	Fri, 19 May 2000 15:45:10 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA06284
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 19 May 2000 15:45:09 -0700 (PDT)
	mail_from (wesolows@rotor.chem.unr.edu)
Received: from rotor.chem.unr.edu (rotor.chem.unr.edu [134.197.32.176]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA08872
	for <linux@cthulhu.engr.sgi.com>; Fri, 19 May 2000 15:45:08 -0700 (PDT)
	mail_from (wesolows@rotor.chem.unr.edu)
Received: (from wesolows@localhost)
	by rotor.chem.unr.edu (8.9.3/8.9.3) id PAA23333
	for linux@cthulhu.engr.sgi.com; Fri, 19 May 2000 15:45:11 -0700
Date: Fri, 19 May 2000 15:45:11 -0700
From: Keith M Wesolowski <wesolows@chem.unr.edu>
To: linux@cthulhu.engr.sgi.com
Subject: New mini-distribution
Message-ID: <20000519154511.B21086@chem.unr.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
X-Complaints-To: postmaster@chem.unr.edu
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk

Hi all,

I got bored last week and put together a new mini-distribution for
SGIs. I know it works on Indigo2 at least. It's a lot smaller and has
some more up to date components than Hard Hat. Perhaps it would be a
good starting point for someone to use, or maybe it will be of no use
to anyone but me. :) Those interested can read a quick HOWTO at
http://foobazco.org/~wesolows/Install-HOWTO.html; the necessary files
are at ftp://ftp.foobazco.org/pub/people/wesolows/mips-linux/.

Quick rundown:

Kernel 2.2.14 from CVS
glibc 2.0.6 with patches
egcs 1.1.2 with patches
binutils 000425 with patches
bash 2.04
vim 5.6
barebones initscripts
miscellaneous useful software
NFS-based installation

Plans:

Not much. I will probably try to get gcc 2.96 and glibc 2.2 working
with it, those being the least up to date parts of it all. I don't
really think this is going anywhere; Debian will hopefully be finished
soon.

-- 
Keith M Wesolowski			wesolows@chem.unr.edu
University of Nevada			http://www.chem.unr.edu
Chemistry Department Systems and Network Administrator
