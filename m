Received:  by oss.sgi.com id <S305163AbQDSXUF>;
	Wed, 19 Apr 2000 16:20:05 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:54886 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305172AbQDSXTm>;
	Wed, 19 Apr 2000 16:19:42 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id QAA25260; Wed, 19 Apr 2000 16:14:57 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA02098
	for linux-list;
	Wed, 19 Apr 2000 16:04:39 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from dhcp-163-154-5-221.engr.sgi.com (dhcp-163-154-5-221.engr.sgi.com [163.154.5.221])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA03616
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 19 Apr 2000 16:04:38 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received:  by lappi.waldorf-gmbh.de id <S1405654AbQDSXB0>;
	Wed, 19 Apr 2000 16:01:26 -0700
Date:   Wed, 19 Apr 2000 16:01:26 -0700
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Florian Lohoff <flo@rfc822.org>
Cc:     linux@cthulhu.engr.sgi.com, debian-mips@lists.debian.org
Subject: Re: 2.3.99pre5 on Decstation 5000/150 Was: CVS Update@oss.sgi.com: linux
Message-ID: <20000419160126.C709@uni-koblenz.de>
References: <20000419135535Z305163-391+262@oss.sgi.com> <20000419184812.I7793@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20000419184812.I7793@paradigm.rfc822.org>; from flo@rfc822.org on Wed, Apr 19, 2000 at 06:48:13PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Wed, Apr 19, 2000 at 06:48:13PM +0200, Florian Lohoff wrote:

> [flo@repeat flo]$ uname -a
> Linux repeat 2.3.99-pre5 #1 Wed Apr 19 18:34:20 CEST 2000 mips unknown
> [flo@repeat flo]$ cat /proc/cpuinfo 
> cpu: MIPS
> cpu model               : R4000SC V3.0

Btw, that's a fairly old piece of silicon, you may be interested in walking
through the errata and fix all the bugs that have workarounds ...

  Ralf
