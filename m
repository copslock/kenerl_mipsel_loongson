Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id UAA175207 for <linux-archive@neteng.engr.sgi.com>; Thu, 22 Jan 1998 20:15:33 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id UAA27910 for linux-list; Thu, 22 Jan 1998 20:14:09 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id UAA27882 for <linux@cthulhu.engr.sgi.com>; Thu, 22 Jan 1998 20:13:56 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id UAA09023
	for <linux@cthulhu.engr.sgi.com>; Thu, 22 Jan 1998 20:13:54 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-25.uni-koblenz.de [141.26.249.25])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id FAA02915
	for <linux@cthulhu.engr.sgi.com>; Fri, 23 Jan 1998 05:13:51 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id FAA08546;
	Fri, 23 Jan 1998 05:08:31 +0100
Message-ID: <19980123050831.56248@uni-koblenz.de>
Date: Fri, 23 Jan 1998 05:08:31 +0100
To: mdhill@interlog.com
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: wd33c93 errors.
References: <m0xvVCP-0005FsC@lightning.swansea.linux.org.uk> <Pine.LNX.3.95.980122175054.21753I-100000@lager.engsoc.carleton.ca> <199801230128.UAA02293@mdhill.interlog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <199801230128.UAA02293@mdhill.interlog.com>; from Michael Hill on Thu, Jan 22, 1998 at 08:28:50PM -0500
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, Jan 22, 1998 at 08:28:50PM -0500, Michael Hill wrote:

> Alex deVries writes:
>  > 
>  > On Thu, 22 Jan 1998, Alan Cox wrote:
>  > > > repartitioned it from Irix, and mounted it as an EFS partition under Irix
>  > > > just fine.  That would seem to indicate that everything is alright with
>  > > Including rewriting it ?
>  > 
>  > Ah, I tried that specifically, and had problems too with Irix.  So, the
>  > disk is toast, and it'll go back to the storage room I found it in (along
>  > with an AXP).
>  > 
> 
> The 1 G drive I posted about last week was made visible to IRIX by
> modifying wd93_syncenable and wd93_syncperiod in
> /var/sysgen/master.d/wd93 before recompiling the IRIX kernel.  Does
> anyone know of similar changes to the Linux source that would prevent
> the system from hanging on startup with the following message?
> 
>  sending SDTR 0103013f0csync_xfer=2cscsi : aborting command due to timeout : pid 7, scsi0, channel 0, id 3, lun 0 Inquiry 00 00
> scsi0: Aborting connected command 7 - stopping DMA - sending wd33c93 ABORT command - flushing fifo - asr - 20, sr=ff, 16777215 by
>  - sending wd33c93 DISCONNECT command - asr = 20, sr=18.
> 
> If this is a bug, as Alan said, maybe there's hope for my drive, as
> well as the one Alex has.

Use boot arguments to the kernel.  Below the comments from the driver
source documenting the possible arguments.  Actually we should implement
a blacklist feature; the current blacklist doesn't support a nosync or
nodisconnect feature.

/*
 * 'setup_strings' is a single string used to pass operating parameters and
 * settings from the kernel/module command-line to the driver. 'setup_args[]'
 * is an array of strings that define the compile-time default values for
 * these settings. If Linux boots with an amiboot or insmod command-line,
 * those settings are combined with 'setup_args[]'. Note that amiboot
 * command-lines are prefixed with "wd33c93=" while insmod uses a
 * "setup_strings=" prefix. The driver recognizes the following keywords
 * (lower case required) and arguments:
 *
 * -  nosync:bitmask -bitmask is a byte where the 1st 7 bits correspond with
 *                    the 7 possible SCSI devices. Set a bit to negotiate for
 *                    asynchronous transfers on that device. To maintain
 *                    backwards compatibility, a command-line such as
 *                    "wd33c93=255" will be automatically translated to
 *                    "wd33c93=nosync:0xff".
 * -  nodma:x        -x = 1 to disable DMA, x = 0 to enable it. Argument is
 *                    optional - if not present, same as "nodma:1".
 * -  period:ns      -ns is the minimum # of nanoseconds in a SCSI data transfer
 *                    period. Default is 500; acceptable values are 250 - 1000.
 * -  disconnect:x   -x = 0 to never allow disconnects, 2 to always allow them.
 *                    x = 1 does 'adaptive' disconnects, which is the default
 *                    and generally the best choice.
 * -  debug:x        -If 'DEBUGGING_ON' is defined, x is a bit mask that causes
 *                    various types of debug output to printed - see the DB_xxx
 *                    defines in wd33c93.h
 * -  clock:x        -x = clock input in MHz for WD33c93 chip. Normal values
 *                    would be from 8 through 20. Default is 8.
 * -  next           -No argument. Used to separate blocks of keywords when
 *                    there's more than one host adapter in the system.
 *
 * Syntax Notes:
 * -  Numeric arguments can be decimal or the '0x' form of hex notation. There
 *    _must_ be a colon between a keyword and its numeric argument, with no
 *    spaces.
 * -  Keywords are separated by commas, no spaces, in the standard kernel
 *    command-line manner.
 * -  A keyword in the 'nth' comma-separated command-line member will overwrite
 *    the 'nth' element of setup_args[]. A blank command-line member (in
 *    other words, a comma with no preceding keyword) will _not_ overwrite
 *    the corresponding setup_args[] element.
 * -  If a keyword is used more than once, the first one applies to the first
 *    SCSI host found, the second to the second card, etc, unless the 'next'
 *    keyword is used to change the order.
 *
 * Some amiboot examples (for insmod, use 'setup_strings' instead of 'wd33c93'):
 * -  wd33c93=nosync:255
 * -  wd33c93=nodma
 * -  wd33c93=nodma:1
 * -  wd33c93=disconnect:2,nosync:0x08,period:250
 * -  wd33c93=debug:0x1c
 */

  Ralf
