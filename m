Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id BAA24946
	for <pstadt@stud.fh-heilbronn.de>; Thu, 19 Aug 1999 01:12:45 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA03618; Wed, 18 Aug 1999 16:10:02 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA65827
	for linux-list;
	Wed, 18 Aug 1999 16:01:20 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA75757
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 18 Aug 1999 16:01:10 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1] (may be forged)) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA05477
	for <linux@cthulhu.engr.sgi.com>; Wed, 18 Aug 1999 16:01:07 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-3.uni-koblenz.de [141.26.131.3])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id BAA19668
	for <linux@cthulhu.engr.sgi.com>; Thu, 19 Aug 1999 01:00:51 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.9.3/8.9.3) id NAA08977;
	Wed, 18 Aug 1999 13:39:32 +0200
Date: Wed, 18 Aug 1999 13:39:32 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Cory Jon Hollingsworth <cory@real-time.com>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: Hard Hat and Tandem.
Message-ID: <19990818133932.A8965@uni-koblenz.de>
References: <37B70CDF.D938EA0D@real-time.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <37B70CDF.D938EA0D@real-time.com>; from Cory Jon Hollingsworth on Sun, Aug 15, 1999 at 01:54:24PM -0500
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sun, Aug 15, 1999 at 01:54:24PM -0500, Cory Jon Hollingsworth wrote:

>     I have a Tandem model number CMN B006S that I'm trying to get Hard
> Hat up and running on.  This is a machine build for Tandem by SGI and,
> based on the descriptions I have read, I believe it is a close cousin to
> the Challenge S.

>     For instance an hinv returns:
> Syestem: IP22
> Processor: 150 Mhz R4400, with FPU
> Primary I-cache size: 16 Kbytes
> Primary D-cache size: 16 Kbytes
> Secondary cache size: 1024 Kbytes
> Memory size: 256 Mbytes
> SCSI Disk: scsi(0)disk(1)

Could you send me a the full hinv output, just to verify that this
system is really an IP22 with no Tandem specific specials?

Further, what is the product name under which this Tandem was marketed?
Is it CMN B006S?  I'd like to document the fact that this machine is
(un?)supported in the Linux/MIPS docs.

>      Now I have spent a some time browsing the archives and I know this
> was a common problem some time ago on certain models of Indys.

Yep, but it's fixed.

>     I can get the system to boot by replacing the Hard Hat vmlinux image
> with the vmlinux-indy-initrd-990313.gz image found in
> ftp.linux.sgi.com/pub/linux/mips/test.  But that leaves me with a
> crippled RAM disk image and a root prompt.  I can NFS mount my Hard Hat
> file system, but that doesn't help me run the installation.

That particular kernel was on there for testing the initrd functionality,
so you're experiencing exactly what is supposed to happen.

>     My question is: Can I get a precompiled vmlinux replacement for the
> Hard Hat distribution which will allow me to continue with the
> installation?   Or, since Tandem is not officially supported,  do I
> spend the next couple of months hand assembling a root partition on the
> machine from the bits I currently have working via NFS?

There are several kernels in exactly the directory you got the initrd
image from.

I have never heared about these Tandem machine but I assume that it it
identical to the Indy rsp. Challenge S.

  Ralf
