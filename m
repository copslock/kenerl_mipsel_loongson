Received:  by oss.sgi.com id <S305165AbPLUQ3V>;
	Tue, 21 Dec 1999 08:29:21 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:30515 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305163AbPLUQ3E>; Tue, 21 Dec 1999 08:29:04 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id IAA07766; Tue, 21 Dec 1999 08:30:27 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA95588
	for linux-list;
	Tue, 21 Dec 1999 08:05:32 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA11517
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 21 Dec 1999 08:05:24 -0800 (PST)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id IAA09799
	for <linux@cthulhu.engr.sgi.com>; Tue, 21 Dec 1999 08:05:04 -0800 (PST)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 326DF7FD; Tue, 21 Dec 1999 17:04:58 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id B7CAA8F93; Tue, 21 Dec 1999 16:54:44 +0100 (CET)
Date:   Tue, 21 Dec 1999 16:54:44 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     Jun Matsuda <jmatsu@cse.canon.co.jp>
Cc:     linux@cthulhu.engr.sgi.com
Subject: Re: patch for glibc-2.0.6
Message-ID: <19991221165444.W272@paradigm.rfc822.org>
References: <19991206214429.T765@uni-koblenz.de> <19991221210256U.jmatsu@cse.canon.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <19991221210256U.jmatsu@cse.canon.co.jp>; from Jun Matsuda on Tue, Dec 21, 1999 at 09:02:56PM +0900
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Tue, Dec 21, 1999 at 09:02:56PM +0900, Jun Matsuda wrote:
> Hi,
> 
> I plan to construct the cross compilation environment as
> described in the Linux/MIPS-HOWTO. But I could not find the
> patch for glibc-2.0.6 (glibc-2.0.6-mips.patch) and without
> this patch, I failed to compile glibc-2.0.6.
> 
> Does anyone tell me the place where to find it?

There is a source rpm for it somewhere - Or a debian source package
for 2.0.7.981112 or something at

ftp://ftp.rfc822.org/pub/local/debian/debian/experimental 

or something like that - It doesnt compile out of the box because
the tic and rpcgen get linked to the wrong lib ...

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5241-470566
  ...  The failure can be random; however, when it does occur, it is
  catastrophic and is repeatable  ...             Cisco Field Notice
