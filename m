Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id KAA52164; Fri, 15 Aug 1997 10:15:37 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id KAA03099 for linux-list; Fri, 15 Aug 1997 10:15:04 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA03092; Fri, 15 Aug 1997 10:15:01 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id KAA11879; Fri, 15 Aug 1997 10:14:56 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61]) by informatik.uni-koblenz.de (8.8.6/8.6.9) with SMTP id TAA18835; Fri, 15 Aug 1997 19:14:54 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199708151714.TAA18835@informatik.uni-koblenz.de>
Received: by thoma (SMI-8.6/KO-2.0)
	id TAA05773; Fri, 15 Aug 1997 19:14:52 +0200
Subject: Re: Booting Linux from second disk
To: jeremyw@motown.detroit.sgi.com
Date: Fri, 15 Aug 1997 19:14:51 +0200 (MET DST)
Cc: linux@cthulhu.engr.sgi.com, linux-progress@cthulhu.engr.sgi.com
In-Reply-To: <Pine.SGI.3.94.970815111008.12486A-100000@motown.detroit.sgi.com> from "Jeremy Welling" at Aug 15, 97 11:26:18 am
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> 
> -rwxr-xr-x 1 root sys 1137360 Aug 15 10:54 vmlinux
> 
> which came from:
> 
> ftp://ftp.linux.sgi.com/pub/test/vmlinux-970813-jwr.gz
> 
> We have extracted the root cpio and this is what the root dir of the
> second disk looks like:
> linux 8# cd /d
> linux 9# ls -la
> total 212785
[...]

I you can do this under IRIX the problem is very easy to find - you're
using XFS which Linux can't read.  Stupid enough IRIX can't read ext2fs.

  Ralf
