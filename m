Received:  by oss.sgi.com id <S305169AbQCCTry>;
	Fri, 3 Mar 2000 11:47:54 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:10286 "EHLO convert rfc822-to-8bit
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305162AbQCCTra>; Fri, 3 Mar 2000 11:47:30 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id LAA02859; Fri, 3 Mar 2000 11:50:41 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA36453
	for linux-list;
	Fri, 3 Mar 2000 11:37:57 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA13294
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 3 Mar 2000 11:37:55 -0800 (PST)
	mail_from (jsimmons@acsu.buffalo.edu)
Received: from tolstoy.pubsites.buffalo.edu (tolstoy.pubsites.buffalo.edu [128.205.139.10]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via SMTP id LAA00637
	for <linux@cthulhu.engr.sgi.com>; Fri, 3 Mar 2000 11:37:54 -0800 (PST)
	mail_from (jsimmons@acsu.buffalo.edu)
Received: (qmail 9060 invoked by uid 9977); 3 Mar 2000 19:37:53 -0000
Date:   Fri, 3 Mar 2000 14:37:52 -0500 (EST)
From:   James A Simmons <jsimmons@acsu.buffalo.edu>
X-Sender: jsimmons@tolstoy.pubsites.buffalo.edu
To:     Carlos Ernesto =?iso-8859-1?Q?L=F3pez=20Natar=E9n?= 
        <natorro@themis.fciencias.unam.mx>
cc:     linux@cthulhu.engr.sgi.com
Subject: Re: About X server...
In-Reply-To: <38C000C5.5BB5689B@themis.fciencias.unam.mx>
Message-ID: <Pine.GSO.4.05.10003031436560.9045-100000@tolstoy.pubsites.buffalo.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


>From what I seen the best thing to do is run the native Xsgi X server
under linux. I have seen a patched XFree86 X server in CVS. Its uses the
/dev/graphics interface native to IRIX. 

"Look its a text editor, no its a OS, no its Emacs"
James Simmons                                                      (o_
fbdev/gfx developer                                      (o_  (o_ //\
http://www.linux-fbdev.org                              (/)_ (/)_ V_/_
http://linuxgfx.sourceforge.net

On Fri, 3 Mar 2000, Carlos Ernesto [iso-8859-1] López Natarén wrote:

> Hi!
> I just wanted to know if there is a X server working on
> linux, because I want to install it on an Indy, but I
> really need X working... 
> the Hard Hat homepage has not much info about it...
> Thanks a lot
> natorro
> 
