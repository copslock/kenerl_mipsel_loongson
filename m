Received:  by oss.sgi.com id <S42246AbQEYAds>;
	Wed, 24 May 2000 17:33:48 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:64613 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42238AbQEYAdl>;
	Wed, 24 May 2000 17:33:41 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id SAA28544; Wed, 24 May 2000 18:28:49 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id SAA40862; Wed, 24 May 2000 18:33:10 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id SAA33250
	for linux-list;
	Wed, 24 May 2000 18:24:14 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id SAA46132
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 24 May 2000 18:24:13 -0700 (PDT)
	mail_from (nick@ns.snowman.net)
From:   nick@ns.snowman.net
Received: from ns.snowman.net (ns.snowman.net [63.80.4.34]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id SAA06079
	for <linux@cthulhu.engr.sgi.com>; Wed, 24 May 2000 18:24:12 -0700 (PDT)
	mail_from (nick@ns.snowman.net)
Received: from localhost (nick@localhost)
	by ns.snowman.net (8.9.1a/8.9.0) with ESMTP id VAA20672
	for <linux@cthulhu.engr.sgi.com>; Wed, 24 May 2000 21:29:36 -0400
Date:   Wed, 24 May 2000 21:29:36 -0400 (EDT)
To:     linux@cthulhu.engr.sgi.com
Subject: New indy problems
In-Reply-To: <20000525023802.A8339@uni-koblenz.de>
Message-ID: <Pine.LNX.4.05.10005242126570.19874-100000@ns.snowman.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Hi, is there any way for me to reset the root password on an indy?  I
bought an indy cheap from a liquidator, and have no way to get the root
password.  I can probably set it up, and then rsh into it from a "trusted
host" (I own the network it's now on, and I could cat it's /.rhosts), but
that would take alot of effort.  All I need is to make one little change
to the FS from SASH or bootprom.
Thanks
	Nick
