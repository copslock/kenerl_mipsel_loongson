Received:  by oss.sgi.com id <S305186AbPLUOeb>;
	Tue, 21 Dec 1999 06:34:31 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:28455 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305163AbPLUOeT>; Tue, 21 Dec 1999 06:34:19 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id GAA07875; Tue, 21 Dec 1999 06:35:42 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id GAA58177
	for linux-list;
	Tue, 21 Dec 1999 06:21:32 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id GAA41092
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 21 Dec 1999 06:21:20 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id GAA00292
	for <linux@cthulhu.engr.sgi.com>; Tue, 21 Dec 1999 06:21:12 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-23.uni-koblenz.de (cacc-23.uni-koblenz.de [141.26.131.23])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id PAA02106;
	Tue, 21 Dec 1999 15:21:09 +0100 (MET)
Received:  by lappi.waldorf-gmbh.de id <S407891AbPLUOTa>;
	Tue, 21 Dec 1999 15:19:30 +0100
Date:   Tue, 21 Dec 1999 15:19:30 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Jun Matsuda <jmatsu@cse.canon.co.jp>
Cc:     linux@cthulhu.engr.sgi.com
Subject: Re: patch for glibc-2.0.6
Message-ID: <19991221151930.A11668@uni-koblenz.de>
References: <19991206214429.T765@uni-koblenz.de> <19991221210256U.jmatsu@cse.canon.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <19991221210256U.jmatsu@cse.canon.co.jp>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Tue, Dec 21, 1999 at 09:02:56PM +0900, Jun Matsuda wrote:

> I plan to construct the cross compilation environment as
> described in the Linux/MIPS-HOWTO. But I could not find the
> patch for glibc-2.0.6 (glibc-2.0.6-mips.patch) and without
> this patch, I failed to compile glibc-2.0.6.
> 
> Does anyone tell me the place where to find it?

In the SRPM package of glibc.

  Ralf
