Received:  by oss.sgi.com id <S305167AbQBRWTN>;
	Fri, 18 Feb 2000 14:19:13 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:57369 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305163AbQBRWSt>;
	Fri, 18 Feb 2000 14:18:49 -0800
Received: from nodin.corp.sgi.com (fddi-nodin.corp.sgi.com [198.29.75.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id OAA23247; Fri, 18 Feb 2000 14:14:18 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id OAA18295; Fri, 18 Feb 2000 14:18:48 -0800 (PST)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA60650
	for linux-list;
	Thu, 17 Feb 2000 17:32:55 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from liveoak.engr.sgi.com (liveoak.engr.sgi.com [163.154.5.24])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA48331;
	Thu, 17 Feb 2000 17:32:50 -0800 (PST)
	mail_from (wje@liveoak.engr.sgi.com)
Received: (from wje@localhost)
	by liveoak.engr.sgi.com (8.9.3/8.8.7) id RAA24858;
	Thu, 17 Feb 2000 17:32:44 -0800
X-Authentication-Warning: liveoak.engr.sgi.com: wje set sender to wje@liveoak.engr.sgi.com using -f
From:   "William J. Earl" <wje@cthulhu.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14508.41276.408855.988727@liveoak.engr.sgi.com>
Date:   Thu, 17 Feb 2000 17:32:44 -0800 (PST)
To:     brett <brett@madhouse.org>
Cc:     Bruce Leggett <bleggett@sofamordanek.com>,
        linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: Linux on O2?
In-Reply-To: <Pine.LNX.3.96.1000217171401.908G-100000@caligula.madhouse.org>
References: <BDDC26ED91ACD1118D4E00805F9FDAC3B027F2@broomfield01.sofamordanek.com>
	<Pine.LNX.3.96.1000217171401.908G-100000@caligula.madhouse.org>
X-Mailer: VM 6.74 under Emacs 20.3.1
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

brett writes:
 > Im still wainting to hear anything about the indigo i hear alot of talk
 > about the indigo2 but nothing about the original blue boxes
...

      The original Indigo was R3000-based.  The I/O is an earlier generation
of that used in Indy and Indigo2, so some of the driver work could be reused,
but it is hard to find documentation at this point.  The Indigo R4000
is pretty close to Indy and Indigo2, so it would not be too hard.  On the
other hand, there is no work done so far on supporting the "starter" graphics
on the Indigo R4000.
