Received:  by oss.sgi.com id <S42247AbQFUVlT>;
	Wed, 21 Jun 2000 14:41:19 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:3870 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42245AbQFUVlB>; Wed, 21 Jun 2000 14:41:01 -0700
Received: from nodin.corp.sgi.com (fddi-nodin.corp.sgi.com [198.29.75.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id OAA03379
	for <linux-mips@oss.sgi.com>; Wed, 21 Jun 2000 14:46:09 -0700 (PDT)
	mail_from (paul@clubi.ie)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id OAA48744 for <linux-mips@oss.sgi.com>; Wed, 21 Jun 2000 14:40:27 -0700 (PDT)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA22725
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 21 Jun 2000 14:38:25 -0700 (PDT)
	mail_from (paul@clubi.ie)
Received: from hibernia.jakma.org (hibernia.clubi.ie [212.17.32.129]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA07499
	for <linux@cthulhu.engr.sgi.com>; Wed, 21 Jun 2000 14:38:18 -0700 (PDT)
	mail_from (paul@clubi.ie)
Received: from fogarty.jakma.org (IDENT:root@fogarty.jakma.org [192.168.0.4])
	by hibernia.jakma.org (8.10.0/8.10.0) with ESMTP id e5LLchf18658;
	Wed, 21 Jun 2000 22:38:43 +0100
Received: from localhost (paul@localhost)
	by fogarty.jakma.org (8.10.0/8.10.0) with ESMTP id e5LLcgE05213;
	Wed, 21 Jun 2000 22:38:42 +0100
X-Authentication-Warning: fogarty.jakma.org: paul owned process doing -bs
Date:   Wed, 21 Jun 2000 22:38:42 +0100 (IST)
From:   Paul Jakma <paul@clubi.ie>
X-Sender: paul@fogarty.jakma.org
To:     Ian Chilton <mailinglist@ichilton.co.uk>
cc:     spock@mgnet.de, Linux Debian MIPS <debian-mips@lists.debian.org>,
        Linux MIPS cthulhu <linux@cthulhu.engr.sgi.com>,
        Linux MIPS <linux-mips@fnet.fr>,
        MIPS vger <linux-mips@vger.rutgers.edu>
Subject: RE: Problems with multiple harddisks on my Indigo2
In-Reply-To: <NAENLMKGGBDKLPONCDDOAELFCNAA.mailinglist@ichilton.co.uk>
Message-ID: <Pine.LNX.4.21.0006212234190.5050-100000@fogarty.jakma.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, 21 Jun 2000, Ian Chilton wrote:

> I have an SGI Indy, with 2 internal hard disks, a 4GB and a 1GB
> 
> I get the same thing!
> 
> 
> > Also I'm getting a message
> > sc1,2,0: cmd=0x12 timeout after 2 sec.  Resetting SCSI bus
> 
> I started getting this when I added the 2nd HD (1GB).
> 

fwiw, i got this too on my indy when i added a Quantum Empire 1GB.

>From cold boot the PROM doesn't recognise the second disk, but IRIX
does (PROM gives me the exact same error message as the one you wrote
above - but prints it twice). If i halt back to PROM then the PROM
does see the second disk. (and only prints that error message once)

my theories are:

1. PROM controller driver is minimal and doesn't init the
controller/disks properly whereas the IRIX driver does. 

2. disk spin up times.. ??

3. Perhaps cause the outboard SCSI port is not terminated. (least not
on my indy)

> 
-- 
Paul Jakma	paul@clubi.ie
PGP5 key: http://www.clubi.ie/jakma/publickey.txt
-------------------------------------------
Fortune:
Give me a fish and I will eat today.

Teach me to fish and I will eat forever.
