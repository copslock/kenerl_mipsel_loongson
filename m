Received:  by oss.sgi.com id <S305160AbQARDJJ>;
	Mon, 17 Jan 2000 19:09:09 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:42821 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S305159AbQARDJC>;
	Mon, 17 Jan 2000 19:09:02 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id TAA07618; Mon, 17 Jan 2000 19:10:46 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id SAA41990
	for linux-list;
	Mon, 17 Jan 2000 18:57:56 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id SAA84325
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 17 Jan 2000 18:57:44 -0800 (PST)
	mail_from (andrewb@uab.edu)
Received: from lilith.dpo.uab.edu (lilith.dpo.uab.edu [138.26.1.128]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id SAA04074
	for <linux@cthulhu.engr.sgi.com>; Mon, 17 Jan 2000 18:57:42 -0800 (PST)
	mail_from (andrewb@uab.edu)
Received: from mdk187.tucc.uab.edu (mdk187.tucc.uab.edu [138.26.15.201])
	by lilith.dpo.uab.edu (8.9.3/8.9.3) with SMTP id UAA21514;
	Mon, 17 Jan 2000 20:57:41 -0600
Date:   Mon, 17 Jan 2000 20:55:58 -0600 (CST)
From:   "Andrew R. Baker" <andrewb@uab.edu>
X-Sender: andrewb@mdk187.tucc.uab.edu
To:     Linux SGI <linux@cthulhu.engr.sgi.com>
cc:     Ralf Baechle <ralf@oss.sgi.com>
Subject: Floating point questions
Message-ID: <Pine.LNX.3.96.1000117204924.28191E-100000@mdk187.tucc.uab.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


Whilst playing with floating point support I have noticed that the
"Division By Zero" and "Overflow" Enable bits are set by default on Linux
where they are not in IRIX.  Is there a reason we do this?  Or is this
behaviour unintended?  

Also, when we enter the floating point handler, the floating point
registers have not been saved to the thread structure.  Currently, I get
around this by querying the registers directly.  Unfortunately this won't
work when we support SMP.  What would the drawbacks be of a save and
restore and the start and finish of the exception handler (well the
unimplemented handler)?  Or is there some other way?  I'm really only
concerned about the case where we would run the soft-fp code on a
processor other than the one that triggered the exception.

-Andrew
