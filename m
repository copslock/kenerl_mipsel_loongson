Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f788PJp21994
	for linux-mips-outgoing; Wed, 8 Aug 2001 01:25:19 -0700
Received: from fenris.scrooge.dk (213.237.12.36.adsl.ynoe.worldonline.dk [213.237.12.36])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f788PHV21979
	for <linux-mips@oss.sgi.com>; Wed, 8 Aug 2001 01:25:17 -0700
Received: from athlon-800 (athlon-pc [10.0.0.2])
	by fenris.scrooge.dk (8.9.3/8.8.7) with ESMTP id KAA06296;
	Wed, 8 Aug 2001 10:25:33 +0200
From: "Soeren Laursen" <soeren.laursen@scrooge.dk>
To: <linux-mips@oss.sgi.com>, Ian <ian@WPI.EDU>
Date: Wed, 8 Aug 2001 10:25:44 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Subject: Re: HELP can't boot
Reply-to: soeren.laursen@scrooge.dk
Message-ID: <3B7113A8.1719.52C999@localhost>
In-reply-to: <Pine.OSF.4.33.0108071650040.27293-100000@grover.WPI.EDU>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from Quoted-printable to 8bit by oss.sgi.com id f788PIV21984
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

You need (as I know) to use irix to prepare the disk.

But read the following links:

http://black.hole.org/indy-boot.html
http://foobazco.org/~wesolows/Install-HOWTO.html
http://www.stafwag.f2s.com/indy/index.php?lang=eng


Søren,

> OK I'm having some problems here.
> 
> I recently received an SGI Indy (complete with all hardware except disk)
> and I installed a blank 1-GB scsi disk (no disk errors reported on bootup)
> but without sash I cannot netboot linux.
> 
> My question is this:  How can I netboot linux (using bootp, tftp, and nfs,
> all confirmed working)?  I the kernel and the hardhat kit, but I can't get
> the Indy to load the kernel.
> 
> I have no IRIX kits available, nor a CD-writer (although I have
> access to a CD-writer if needed).  PLEASE help!
> 
> Thanks in advance!
> 
> --
> Ian Cooper
> ian@wpi.edu
