Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id GAA1638273 for <linux-archive@neteng.engr.sgi.com>; Thu, 26 Mar 1998 06:56:37 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id GAA4067032
	for linux-list;
	Thu, 26 Mar 1998 06:55:59 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id GAA3782858
	for <linux@engr.sgi.com>;
	Thu, 26 Mar 1998 06:55:58 -0800 (PST)
Received: from lorraine.loria.fr (lorraine.loria.fr [152.81.1.17]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id GAA02277
	for <linux@engr.sgi.com>; Thu, 26 Mar 1998 06:55:56 -0800 (PST)
	mail_from (Olivier.Galibert@loria.fr)
Received: from renaissance.loria.fr (renaissance.loria.fr [152.81.4.102])
	by lorraine.loria.fr (8.8.7/8.8.7/8.8.7/JCG) with ESMTP id PAA11418
	for <linux@engr.sgi.com>; Thu, 26 Mar 1998 15:55:00 +0100 (MET)
Received: (from galibert@localhost) by renaissance.loria.fr (8.8.2/8.8.2) id PAA13523; Thu, 26 Mar 1998 15:54:59 +0100 (MET)
Message-ID: <19980326155458.34557@loria.fr>
Date: Thu, 26 Mar 1998 15:54:58 +0100
From: Olivier Galibert <galibert@pobox.com>
To: linux@cthulhu.engr.sgi.com
Subject: Boot
Mail-Followup-To: linux@engr.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.88.14i
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Within  a timeline of   around one month,   I'll probably  be  able to
install a linux  on an external drive  on an indy  I use. I won't have
the possibility to boot through bootp/tfpd. I use irix 6.2 (i.e. xfs).

So the first thing I'll have to do, it seems, is either:
- give  the kernel the possibility  to boot on  one  disk and find its
  files  on another, and  then  put the linux kernel   on the xfs root
  filesystem.
- find a way to boot on an ext2fs partition

The  nicest way would be  the second one,  of course. I'm ready to try
and code for that but I'd like to know:
- if the current kernel would be able to handle that
- if someone has tools format a disk in ext2fs under irix and transfer
  files on it
- if someone has an idea  on how to  have the prom  boot on an  ext2fs
  filesystem

I don't consider reprogramming the prom a viable option.

Any reading recommendation for the meantime is welcome too :-)

  OG.
