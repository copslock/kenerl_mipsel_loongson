Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA56134 for <linux-archive@neteng.engr.sgi.com>; Thu, 11 Feb 1999 11:01:30 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA71762
	for linux-list;
	Thu, 11 Feb 1999 11:00:54 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA85298
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 11 Feb 1999 11:00:45 -0800 (PST)
	mail_from (richard@infopact.nl)
Received: from perron-null.patser.net (9dyn136.breda.casema.net [195.96.116.136]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA03205
	for <linux@cthulhu.engr.sgi.com>; Thu, 11 Feb 1999 11:00:43 -0800 (PST)
	mail_from (richard@infopact.nl)
Received: from infopact.nl (indigo2.patser.net [192.168.6.40])
	by perron-null.patser.net (8.9.0/8.9.0) with ESMTP id TAA12567;
	Thu, 11 Feb 1999 19:49:20 +0100
Message-ID: <36C329D6.7181C7E6@infopact.nl>
Date: Thu, 11 Feb 1999 11:04:54 -0800
From: Richard Hartensveld <richard@infopact.nl>
X-Mailer: Mozilla 4.05C-SGI [en] (X11; I; IRIX 6.5 IP22)
MIME-Version: 1.0
To: Mike Shaver <shaver@netscape.com>
CC: linux@cthulhu.engr.sgi.com
Subject: Re: serial console cable specs
References: <36C31EC1.61242174@netscape.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Mike Shaver wrote:

> I have a DIN<->DB9 adaptor and a DB9 cable, but Something Isn't Right.
>



> What does this cable need to be?  Do I need a NULL-modem thing?  How can
> I be 100% sure that a cable I purchase will let my Indy experience the
> joys or serial consoling?
>

man serial under irix will give you the pinouts.

> And, in the meantime, how can I force my Indy back to console=g?

also under irix, you can use the program nvram and do:

nvram console g

or set the environment from within the bootprom.

Richard
