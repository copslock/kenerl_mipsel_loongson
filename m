Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id RAA09051 for <linux-archive@neteng.engr.sgi.com>; Tue, 30 Jun 1998 17:27:18 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA96018
	for linux-list;
	Tue, 30 Jun 1998 17:26:17 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA82319
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 30 Jun 1998 17:26:15 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA19943
	for <linux@cthulhu.engr.sgi.com>; Tue, 30 Jun 1998 17:26:13 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (root@pmport-27.uni-koblenz.de [141.26.249.27])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id CAA00859
	for <linux@cthulhu.engr.sgi.com>; Wed, 1 Jul 1998 02:26:10 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id WAA01223;
	Tue, 30 Jun 1998 22:11:46 +0200
Message-ID: <19980630221146.A1218@uni-koblenz.de>
Date: Tue, 30 Jun 1998 22:11:46 +0200
To: "Francis M. J. Hsieh" <mjhsieh@life.nthu.edu.tw>,
        linux@cthulhu.engr.sgi.com
Subject: Re: possible apache error?
References: <19980629045132.A432@life.nthu.edu.tw> <19980630120809.A517@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <19980630120809.A517@uni-koblenz.de>; from ralf@uni-koblenz.de on Tue, Jun 30, 1998 at 12:08:09PM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Tue, Jun 30, 1998 at 12:08:09PM +0200, ralf@uni-koblenz.de wrote:

> The corruption pattern is repeatable the same in most cases and I bet
> both the http and the rlogin corruption have the same cause.

The cause seems to be memmove which can corrupt data in certain cases.

  Ralf
