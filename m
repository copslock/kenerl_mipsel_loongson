Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA22517 for <linux-archive@neteng.engr.sgi.com>; Mon, 12 Oct 1998 11:31:07 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA15467
	for linux-list;
	Mon, 12 Oct 1998 11:30:36 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA48808
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 12 Oct 1998 11:30:33 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from water (ts001d24.ott-cn.concentric.net [206.173.215.36]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA04970
	for <linux@cthulhu.engr.sgi.com>; Mon, 12 Oct 1998 11:30:30 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from engsoc.carleton.ca (adevries@localhost [127.0.0.1])
	by water (8.8.7/8.8.7) with ESMTP id OAA02557;
	Mon, 12 Oct 1998 14:15:05 -0400
Message-ID: <36224728.2D7735F2@engsoc.carleton.ca>
Date: Mon, 12 Oct 1998 14:15:04 -0400
From: Alex deVries <adevries@engsoc.carleton.ca>
Organization: EngSoc
X-Mailer: Mozilla 4.06 [en] (X11; I; Linux 2.0.35 i586)
MIME-Version: 1.0
To: "Fernando D. Mato Mira" <matomira@acm.org>
CC: linux@cthulhu.engr.sgi.com
Subject: Re: I am interested in helping port to Indigo
References: <199810121822.UAA15293@link.csem.ch>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Fernando D. Mato Mira wrote:

> Hello,
>
> What would one need to do to port what is running of SGI/Linux to
> Indigo R4400 150MHz Elan?

One would need to write device drivers for:
- SCSI
- ethernet
- display or serial

I thought the indigo used either gio64 or gio32.  I might be wrong.

Have I missed anything?

- Alex
