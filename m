Received:  by oss.sgi.com id <S42225AbQGYQT6>;
	Tue, 25 Jul 2000 09:19:58 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:12094 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42210AbQGYQTp>;
	Tue, 25 Jul 2000 09:19:45 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id JAA01008
	for <linux-mips@oss.sgi.com>; Tue, 25 Jul 2000 09:11:50 -0700 (PDT)
	mail_from (adi@mr-happy.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id JAA67380 for <linux-mips@oss.sgi.com>; Tue, 25 Jul 2000 09:17:35 -0700 (PDT)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA82244
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 25 Jul 2000 09:16:03 -0700 (PDT)
	mail_from (adi@mr-happy.com)
Received: from brainguy.tc.mtu.edu (brainguy.tc.mtu.edu [141.219.5.85]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id JAA09237
	for <linux@cthulhu.engr.sgi.com>; Tue, 25 Jul 2000 09:15:54 -0700 (PDT)
	mail_from (adi@mr-happy.com)
Received: from crow.mr-happy.com (crow.mr-happy.com [172.19.3.81])
	by brainguy.tc.mtu.edu (Postfix) with ESMTP
	id CF54A1A196; Tue, 25 Jul 2000 12:15:37 -0400 (EDT)
Received: by crow.mr-happy.com (Postfix, from userid 22448)
	id 93A5F8D58; Tue, 25 Jul 2000 12:15:35 -0400 (EDT)
Date:   Tue, 25 Jul 2000 11:15:35 -0500
From:   Andy Isaacson <adi@mr-happy.com>
To:     michael.j.lewis@db.com
Cc:     linux@cthulhu.engr.sgi.com
Subject: Re: SGI-Linux VisualWorkstations
Message-ID: <20000725111535.A13121@mr-happy.com>
References: <85256927.0048395E.00@nysmtp4001.svc.btco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <85256927.0048395E.00@nysmtp4001.svc.btco.com>; from michael.j.lewis@db.com on Tue, Jul 25, 2000 at 02:08:52PM +0100
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.mr-happy.com/~adi/pgp.txt
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Jul 25, 2000 at 02:08:52PM +0100, michael.j.lewis@db.com wrote:
> Has anyone managed to get Linux (any distribution) onto the Visual
> Workstation? Personally, had a no. of problems
> with the Visual Workstation and my last gasp effort to use the machine
> (apart from as a dust magnet) is to run Linux on
> them .... any info. pls. let me know. (linux.sgi.com ... used to have a
> couple of pages as I recall, but dont think they are there now....)

I have the instructions I used up at
http://www.lcse.umn.edu/~adi/visws/
The detailed (but only correct for the LCSE setup) instructions are at
http://www.lcse.umn.edu/~adi/visws/lcse-setup.html

It's not terribly useful, though... we had a lot of problems with our
setup and the systems are back to running NT full time.

Off the top of my head
 - XFree86 4.0 fbdev driver had color problems
 - only the first bank of memory was usable (256 of our 1024 MB)
 - accessing the floppy or CD-ROM was likely to hang the machine
 - 2.2.10 was the only kernel I could get running

-andy
-- 
Andy Isaacson <adi@mr-happy.com> http://web.mr-happy.com/~adi/
