Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g49GV2wJ003827
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 9 May 2002 09:31:02 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g49GV2ie003826
	for linux-mips-outgoing; Thu, 9 May 2002 09:31:02 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dtla2.teknuts.com (adsl-66-125-62-110.dsl.lsan03.pacbell.net [66.125.62.110])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g49GUtwJ003821
	for <linux-mips@oss.sgi.com>; Thu, 9 May 2002 09:30:56 -0700
Received: from whrrusek (whnat1.weiderpub.com [65.115.104.67] (may be forged))
	(authenticated)
	by dtla2.teknuts.com (8.11.3/8.10.1) with ESMTP id g49GVMT01926;
	Thu, 9 May 2002 09:31:22 -0700
From: "Robert Rusek" <rrusek@teknuts.com>
To: "'Florian Lohoff'" <flo@rfc822.org>
Cc: <linux-mips@oss.sgi.com>
Subject: RE: Indy SCSI Errors
Date: Thu, 9 May 2002 09:31:01 -0700
Message-ID: <C0F41630CD8B9C4680F2412914C1CF070164C2@WH-EXCHANGE1.AD.WEIDERPUB.COM>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
In-Reply-To: <20020509154327.GB6197@paradigm.rfc822.org>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I am familiar with the error that you are referring to.  I just fixed it
by upgrading to kernel 2.4.17.  The error that I am describing, should I
just ignore it and just do a fsck on my main drive every month?  I have
three drives sda1, sdb1, and sdc1 and it only seems to happened on the
sda1.  My sda2 is the swap drive, would that be affecting my sda1 ?

Thanks,
Rob.
     -----Original Message-----
     From: owner-linux-mips@oss.sgi.com 
     [mailto:owner-linux-mips@oss.sgi.com] On Behalf Of Florian Lohoff
     Sent: Thursday, May 09, 2002 8:43 AM
     To: Robert Rusek
     Cc: linux-mips@oss.sgi.com
     Subject: Re: Indy SCSI Errors
     
     
     On Wed, May 08, 2002 at 10:23:18AM -0700, Robert Rusek wrote:
     > I am currently running kernel 2.4.17 and am getting 
     sparatice errors 
     > like the following.  I seen that there had been bugs in the scsi 
     > driver in the earlier kernel versions.  Has anyone 
     encountered this?  
     > Is there a newer kernal that maybe addresses this?
     > 
     > EXT2-fs error (device sd(8,1)): ext2_check_page: bad entry in 
     > directory
     > #110030: unaligned
     >  directory entry - offset=0, inode=6226015, rec_len=95, 
     name_len=95
     > 
     
     The SCSI errors we had on the Indy and Indigo2 happened 
     with multiple disks, disconnects and were pure "read" 
     errors. Filesystem corruption was quite rare. Mostly we 
     had file data corruption on copy. The bug is fixed for at 
     least half a year now.
     
     Do you see any other errors than that ? SCSI errors ?
     
     Flo
     -- 
     Florian Lohoff                  flo@rfc822.org             
     +49-5201-669912
                             Heisenberg may have been here.
     
