Received:  by oss.sgi.com id <S42348AbQEZQ53>;
	Fri, 26 May 2000 09:57:29 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:4460 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42328AbQEZQYB>; Fri, 26 May 2000 09:24:01 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id VAA08707; Thu, 25 May 2000 21:29:10 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id VAA31789; Thu, 25 May 2000 21:23:58 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id VAA66320
	for linux-list;
	Thu, 25 May 2000 21:14:14 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id VAA73781
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 25 May 2000 21:14:10 -0700 (PDT)
	mail_from (soren@gnyf.wheel.dk)
Received: from gnyf.wheel.dk (gnyf.wheel.dk [193.162.159.104]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id VAA04159
	for <linux@cthulhu.engr.sgi.com>; Thu, 25 May 2000 21:14:09 -0700 (PDT)
	mail_from (soren@gnyf.wheel.dk)
Received: (from soren@localhost)
	by gnyf.wheel.dk (8.9.1/8.9.1) id GAA03511;
	Fri, 26 May 2000 06:14:04 +0200 (CEST)
Date:   Fri, 26 May 2000 06:14:04 +0200
From:   "Soren S. Jorvang" <soren@wheel.dk>
To:     Keith M Wesolowski <wesolows@chem.unr.edu>
Cc:     Eric Watkins <watkinse@attens.com>,
        Philippe Chauvat <philippe.chauvat@exfo.com>,
        Linux Mips <linux@cthulhu.engr.sgi.com>
Subject: Re: [DHCP]
Message-ID: <20000526061404.A3481@gnyf.wheel.dk>
References: <392D4F76.9B06C235@exfo.com> <001801bfc665$feabed20$540ed7c0@hq.sd.cerf.net> <20000525094735.A30683@chem.unr.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20000525094735.A30683@chem.unr.edu>; from wesolows@chem.unr.edu on Thu, May 25, 2000 at 09:47:36AM -0700
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Thu, May 25, 2000 at 09:47:36AM -0700, Keith M Wesolowski wrote:
> I also had difficulty using ISC dhcpd to boot SGIs until I did an
> unsetenv netaddr before booting. I don't yet know why this works.

Ted fixed dhcpd for SGI some time ago. I am not sure if it has
made into 3.0.

--- server/bootp.c.orig	Fri Apr  9 19:55:02 1999
+++ server/bootp.c	Wed Dec  8 00:23:16 1999
@@ -348,6 +348,16 @@
 					      from, &to, &hto);
 			return;
 		}
+
+	/* If it comes from a client that already knows its address
+	   and is not requesting a broadcast response, and we can
+	   unicast to a client without using the ARP protocol, sent it
+	   directly to that client. */
+	} else if (!(raw.flags & htons (BOOTP_BROADCAST)) &&
+		   can_unicast_without_arp()) {
+		to.sin_addr = raw.yiaddr;
+		to.sin_port = remote_port;
+
 	/* Otherwise, broadcast it on the local network. */
 	} else {
 		to.sin_addr.s_addr = INADDR_BROADCAST;


-- 
Soren
