Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id GAA2411976 for <linux-archive@neteng.engr.sgi.com>; Tue, 31 Mar 1998 06:56:29 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id GAA5934800
	for linux-list;
	Tue, 31 Mar 1998 06:55:19 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id GAA5875445
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 31 Mar 1998 06:55:18 -0800 (PST)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id GAA09557
	for <linux@cthulhu.engr.sgi.com>; Tue, 31 Mar 1998 06:55:07 -0800 (PST)
	mail_from (ralf@mailhost.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with SMTP id QAA17039;
	Tue, 31 Mar 1998 16:55:06 +0200 (MEST)
Received: by thoma (SMI-8.6/KO-2.0)
	id QAA15963; Tue, 31 Mar 1998 16:55:02 +0200
Message-ID: <19980331165502.28021@uni-koblenz.de>
Date: Tue, 31 Mar 1998 16:55:02 +0200
From: ralf@uni-koblenz.de
To: Oliver Frommel <oliver@aec.at>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: compile problem with kernel
References: <19980331163848.49537@uni-koblenz.de> <Pine.LNX.3.96.980331164509.17524B-100000@web.aec.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.84e
In-Reply-To: <Pine.LNX.3.96.980331164509.17524B-100000@web.aec.at>; from Oliver Frommel on Tue, Mar 31, 1998 at 04:46:53PM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Tue, Mar 31, 1998 at 04:46:53PM +0200, Oliver Frommel wrote:

> i installed the binutils-2.8.1 with the following configuration:
> 
> ./configure --prefix=/tmp/binutils-xcompile-root/usr/local --program-prefix=mips
> -linux- --enable-shared --target=mips-linux

You loose.  You install software in /tmp???

  Ralf
