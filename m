Received:  by oss.sgi.com id <S305161AbQEPKkW>;
	Tue, 16 May 2000 10:40:22 +0000
Received: from deliverator.sgi.com ([204.94.214.10]:30500 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305154AbQEPKkH>;
	Tue, 16 May 2000 10:40:07 +0000
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id DAA15945; Tue, 16 May 2000 03:35:16 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id DAA01964; Tue, 16 May 2000 03:39:36 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id DAA95016
	for linux-list;
	Tue, 16 May 2000 03:26:48 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id DAA70853
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 16 May 2000 03:26:47 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id DAA07274
	for <linux@cthulhu.engr.sgi.com>; Tue, 16 May 2000 03:26:45 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id CF3377F3; Tue, 16 May 2000 12:26:48 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 225BA8FA7; Tue, 16 May 2000 12:26:06 +0200 (CEST)
Date:   Tue, 16 May 2000 12:26:06 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     Eric Watkins <watkinse@attens.com>
Cc:     linux@cthulhu.engr.sgi.com
Subject: Re: SGI-Linux port progress?
Message-ID: <20000516122606.I2191@paradigm.rfc822.org>
References: <003801bfbeae$6ccffc20$540ed7c0@hq.sd.cerf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <003801bfbeae$6ccffc20$540ed7c0@hq.sd.cerf.net>; from watkinse@attens.com on Mon, May 15, 2000 at 01:44:54PM -0700
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Mon, May 15, 2000 at 01:44:54PM -0700, Eric Watkins wrote:
> Hello,
> 
> I was just gifted/given an Indigo 2.
> 
> It's working so I don't need any parts but I do want to know what the status
> of the hardhat project is. The files I found on the sgi site seemed out of
> date. Is any progress being made here?

Yep it is - The current CVS kernel is basically ok (Same errors as on
i386 with memory leaks) - You will need some more hacking to get some
useful output - I am by far a kernel hacker but i and Klaus Naumann
try to fix the tiny bits to get everything to run out of the box.

> How soon till I can install linux without having IRIX on my harddrive? All
> of the FAQs/docs I could find seemed to have IRIX as a requirement to
> partition the HD properly.

Nope - no irix requirement - You need an NFS Root - Kernel Level autoconfig
kernel - Then enter

bootp():vmlinux console=ttyS0 root=/dev/nfs nfsroot=<ipadr>:<bootpath> rw

on your indigo2 bootprom command line - Afterwards
if the hardhat is installed on the boot/tftp/nfs server you will
see your indigo2 booting on the serial (No Prom Console/Framebuffer
support yet)

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-subject-2-change
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
