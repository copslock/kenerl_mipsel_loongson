Received:  by oss.sgi.com id <S305192AbQDXTKp>;
	Mon, 24 Apr 2000 12:10:45 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:64857 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305191AbQDXTKR>;
	Mon, 24 Apr 2000 12:10:17 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id MAA21192; Mon, 24 Apr 2000 12:05:31 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA30251
	for linux-list;
	Mon, 24 Apr 2000 11:58:14 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from calypso.engr.sgi.com (calypso.engr.sgi.com [163.154.5.113])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA17891;
	Mon, 24 Apr 2000 11:57:47 -0700 (PDT)
	mail_from (ulfc@calypso.engr.sgi.com)
Received: from localhost (localhost [127.0.0.1])
	by calypso.engr.sgi.com (Postfix) with ESMTP
	id 33A58A7904; Mon, 24 Apr 2000 11:57:13 -0700 (PDT)
Date:   Mon, 24 Apr 2000 11:57:13 -0700 (PDT)
From:   Ulf Carlsson <ulfc@calypso.engr.sgi.com>
To:     Florian Lohoff <flo@rfc822.org>
Cc:     linux@cthulhu.engr.sgi.com
Subject: Re: early crash on indigo2 fix breaks indy ...
In-Reply-To: <20000424132221.D2583@paradigm.rfc822.org>
Message-ID: <Pine.LNX.4.21.0004241152170.23887-100000@calypso.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

> Indigo2 - I had the problem that the first alloc_bootmem i think
> got back pages in the kernel marked as "free" - The resulting memset
> let the kernel crash. My solution was to mark the kernel pages
> as reserved.
> 
> BTW: What does break on indy ? Does it crash ? Does it hang in SCSI Detection ?

Yeah, I noted that it didn't make any difference to revert your change except
that the algorithm breaks and I get spammed with zillions of ``hm, page
already marked as reserved'' messages when we try to reserve the already
reserved memory.  Is it possible to detect this with the PROM version or
something?

Ulf
