Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id IAA57283 for <linux-archive@neteng.engr.sgi.com>; Mon, 29 Jun 1998 08:48:52 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA70478
	for linux-list;
	Mon, 29 Jun 1998 08:47:34 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA14416
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 29 Jun 1998 08:47:31 -0700 (PDT)
	mail_from (mjhsieh@helix.life.nthu.edu.tw)
Received: from helix.life.nthu.edu.tw (helix.life.nthu.edu.tw [140.114.98.34]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id IAA14615
	for <linux@cthulhu.engr.sgi.com>; Mon, 29 Jun 1998 08:47:30 -0700 (PDT)
	mail_from (mjhsieh@helix.life.nthu.edu.tw)
Received: (from mjhsieh@localhost)
	by helix.life.nthu.edu.tw (8.8.7/8.8.7) id XAA01632;
	Mon, 29 Jun 1998 23:47:08 +0800
Message-ID: <19980629234708.A1627@life.nthu.edu.tw>
Date: Mon, 29 Jun 1998 23:47:08 +0800
From: "Francis M. J. Hsieh" <mjhsieh@life.nthu.edu.tw>
To: linux@cthulhu.engr.sgi.com
Subject: Re: hmmmm.... nice job!!
References: <19980629205224.A1023@life.nthu.edu.tw> <Pine.LNX.3.95.980628145721.10146B-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <Pine.LNX.3.95.980628145721.10146B-100000@lager.engsoc.carleton.ca>; from Alex deVries on Sun, Jun 28, 1998 at 02:58:20PM -0400
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sun, Jun 28, 1998 at 02:58:20PM -0400, Alex deVries wrote:
> >  - Sometimes after closing telnet connection, it shows
> > 	bpti [/home/mjhsieh] -mjhsieh- logout
> > 	tput: tgetent failure: No such file or directory
> > 	tput: tgetent failure: No such file or directory
> > 	Connection closed by foreign host."
> 
> Hm.  That's new to me.  I look at it.

Seems to be a small problem of term emulation (I guessed.)

After some observation, I found it only occurs on console
telneting to some certain host. I will check it, too.

--
Francis M. J. Hsieh
