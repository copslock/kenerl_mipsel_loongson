Received:  by oss.sgi.com id <S42240AbQGYSrR>;
	Tue, 25 Jul 2000 11:47:17 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:12391 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42210AbQGYSrD>;
	Tue, 25 Jul 2000 11:47:03 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id LAA22287
	for <linux-mips@oss.sgi.com>; Tue, 25 Jul 2000 11:39:07 -0700 (PDT)
	mail_from (ehab@aia067.aia.RWTH-Aachen.DE)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA48949
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 25 Jul 2000 11:46:16 -0700 (PDT)
	mail_from (ehab@aia067.aia.RWTH-Aachen.DE)
Received: from aia067.aia.RWTH-Aachen.DE (aia067.aia.RWTH-Aachen.DE [134.130.140.67]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA01102
	for <linux@cthulhu.engr.sgi.com>; Tue, 25 Jul 2000 11:46:13 -0700 (PDT)
	mail_from (ehab@aia067.aia.RWTH-Aachen.DE)
Received: from localhost (localhost [[UNIX: localhost]])
	by aia067.aia.RWTH-Aachen.DE (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) id UAA04975;
	Tue, 25 Jul 2000 20:46:07 +0200
From:   Ehab Fares <ehab@aia.rwth-aachen.de>
To:     michael.j.lewis@db.com
Subject: Re: SGI-Linux VisualWorkstations
Date:   Tue, 25 Jul 2000 20:31:56 +0200
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain
References: <85256927.0048395E.00@nysmtp4001.svc.btco.com>
In-Reply-To: <85256927.0048395E.00@nysmtp4001.svc.btco.com>
Cc:     linux@cthulhu.engr.sgi.com, adi@mr-happy.com
MIME-Version: 1.0
Message-Id: <00072520460700.04813@aia067>
Content-Transfer-Encoding: 8bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, 25 Jul 2000, you wrote:
> Has anyone managed to get Linux (any distribution) onto the Visual
> Workstation? Personally, had a no. of problems
> with the Visual Workstation and my last gasp effort to use the machine
> (apart from as a dust magnet) is to run Linux on
> them .... any info. pls. let me know. (linux.sgi.com ... used to have a
> couple of pages as I recall, but dont think they are there now....)
> 
> 
> rgds & thnks,
> 
> 
> Michael L
-- 
We've been runnung Linux on a Visual Workstation 540 for some time now.. We
used a SuSE 6.3 Distribution and there was a lot to do to get the mahine
booting for first installation. The Information we used was on the
www.linux.sgi.com... For some reasons (perhaps the new Visual workastation
from SGI) only the mips architecture is now present there! Unfortunatley I
don't have these Information anymore...  

I also have only been able to boot the 2.2.10 Kernel. The system is integrated
into a Linux cluster. We are not using the CD-ROM or the floppy much, so I
don't know of any  problems there. The machine hangs every now and then
(sometimes once per 2 weeks and sometimes one per day). The hanging seem to
stop if the X server is not activated. Our biggest problem is the Memory, we
are only using 960MB of the 2GB. I believe this is only a problem of the arc
loader. It is even mentioned in the sources of that loader. I haven't figured
out a way to get around that yet...  

I personally find it discouraging that there is no further development for
these machines. They would make a great linux visualization machines (as SGI
apparently noticed already and giving a linux option for the newer Visual
Workstation)... What is needed is a better support for the hardware including
the graphics... 

regards,
Ehab.
