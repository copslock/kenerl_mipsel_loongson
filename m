Received:  by oss.sgi.com id <S42279AbQEaAj6>;
	Tue, 30 May 2000 17:39:58 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:33888 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42263AbQEaAjn>; Tue, 30 May 2000 17:39:43 -0700
Received: from nodin.corp.sgi.com (fddi-nodin.corp.sgi.com [198.29.75.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id RAA08814; Tue, 30 May 2000 17:32:07 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id RAA21648; Tue, 30 May 2000 17:26:46 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA05257
	for linux-list;
	Tue, 30 May 2000 17:18:01 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA68909
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 30 May 2000 17:17:55 -0700 (PDT)
	mail_from (csr6702@grace.rit.edu)
Received: from mailout3.nyroc.rr.com (mailout3-1.nyroc.rr.com [24.92.226.168]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA06265
	for <linux@cthulhu.engr.sgi.com>; Tue, 30 May 2000 17:12:59 -0700 (PDT)
	mail_from (csr6702@grace.rit.edu)
Received: from hork (d185d0f95.rochester.rr.com [24.93.15.149])
	by mailout3.nyroc.rr.com (8.9.3/8.9.3) with ESMTP id UAA08641;
	Tue, 30 May 2000 20:05:34 -0400 (EDT)
Received: from molotov (helo=localhost)
	by hork with local-esmtp (Exim 3.12 #1 (Debian))
	id 12ww7x-0000AG-00; Tue, 30 May 2000 20:12:53 -0400
Date:   Tue, 30 May 2000 20:12:53 -0400 (EDT)
From:   Chris Ruvolo <csr6702@grace.rit.edu>
To:     linux@cthulhu.engr.sgi.com
cc:     Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: Problems booting Indigo...
In-Reply-To: <20000531001112.A31916@lug-owl.de>
Message-ID: <Pine.LNX.4.21.0005301954120.439-100000@hork.rochester.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Wed, 31 May 2000, Jan-Benedict Glaw wrote:

>	  [root@parkautomat:/root] #> arp -s 192.168.1.3 08:00:69:06:BA:2E

I didn't need to do this to get the bootp response.

>	- ISC dhcpd from .deb (2.0-3) with very short config:

I switched to this and it works.

>Effect: The Indigo gets its config, but unfortunately it seems that
>incoming tftp UDP packets are not accepted. This might be because
>the originating port is != 69 (which is tftp):

Ok, I'm now in the same boat.

>Now the final question: How can I make in.tftpd to answer *from* port 69?

I'm not sure this is the problem.  I believe RFC-compliant TFTP servers
use system-assigned ports for each client connection.  At least, I've seen
this behavior on other TFTP servers.  But, you may be right.  The client
could be expecting replies only on port 69.  I don't know if this is
possible without modifying the TFTP server.

Can anyone confirm this?

Thanks,
Chris

PS: Please cc responses to me.
