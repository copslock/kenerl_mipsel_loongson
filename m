Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id QAA887770 for <linux-archive@neteng.engr.sgi.com>; Tue, 30 Sep 1997 16:42:52 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id QAA09624 for linux-list; Tue, 30 Sep 1997 16:42:40 -0700
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA09620; Tue, 30 Sep 1997 16:42:38 -0700
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id QAA14355; Tue, 30 Sep 1997 16:42:37 -0700
Date: Tue, 30 Sep 1997 16:42:37 -0700
Message-Id: <199709302342.QAA14355@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: Ralf Baechle <ralf@cobaltmicro.com>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: IRIX ELF docs
In-Reply-To: <199709302336.QAA22417@dns.cobaltmicro.com>
References: <199709302336.QAA22417@dns.cobaltmicro.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Ralf Baechle writes:
 > Hi all,
 > 
 > our current linker is producing IRIX flavored ELF binaries, not MIPS
 > ABI.  We still seem to have some bugs in the dynamic linker and these
 > are now pretty close to the top on my to do list.  However I've got
 > not documentation about the IRIX binary format, so I'm pretty much
 > relying on reverse engineering for fixing them.  Does anybody have
 > a pointer to documentation or documentation about IRIX ELF flavoured
 > o32 bit object file format?

      IRIX ELF O32 (dynamic) object files are MIPS ABI object files.
There are optional extra sections, to support features such as "quickstart"
(which allows RLD to skip some of the fixups at startup time), but the
required parts are as defined by the MIPS ABI.
