Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id RAA38802 for <linux-archive@neteng.engr.sgi.com>; Sun, 27 Dec 1998 17:35:41 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA77176
	for linux-list;
	Sun, 27 Dec 1998 17:34:52 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA59685
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 27 Dec 1998 17:34:50 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA04668
	for <linux@cthulhu.engr.sgi.com>; Sun, 27 Dec 1998 17:34:49 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (pmport-14.uni-koblenz.de [141.26.249.14])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id CAA08590
	for <linux@cthulhu.engr.sgi.com>; Mon, 28 Dec 1998 02:34:46 +0100 (MET)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id CAA28349;
	Mon, 28 Dec 1998 02:34:04 +0100
Message-ID: <19981228023404.H5905@uni-koblenz.de>
Date: Mon, 28 Dec 1998 02:34:04 +0100
From: ralf@uni-koblenz.de
To: Richard Hartensveld <richard@infopact.nl>,
        "linux@cthulhu.engr.sgi.com" <linux@cthulhu.engr.sgi.com>
Subject: Re: return of the console on serial
References: <36860751.B3725CD@infopact.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <36860751.B3725CD@infopact.nl>; from Richard Hartensveld on Sun, Dec 27, 1998 at 02:09:21AM -0800
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sun, Dec 27, 1998 at 02:09:21AM -0800, Richard Hartensveld wrote:

> Compilation is all going well now, and when i boot my new kernel, it
> says:
> 
> 'console is ttyS0' (or ttyS1, that depends on the boot option)
> 
> But doesn't do anything with it it seems.
> 
> i'm still getting the 'unable to open initial console', which should be
> the terminal on the serial port. Is this not supported yet??

[...]
  5.1.  NFS booting fails.

  Usually the reason for this is that people used unpacked the tar
  archive under IRIX, not Linux.  Since the representation of device
  files over NFS is not standardized between various Unices this fails.
  The sympthom is that the system dies with the error message ,,Warning:
  unable to open an initial console.'' right after mounting the NFS
  filesystem.

  For now the workaround is to use a Linux system (doesn't need to be a
  MIPS) to unpack the installation archive onto the NFS server.  The NFS
  server itself may be any type of UNIX.
[...]

  Ralf
