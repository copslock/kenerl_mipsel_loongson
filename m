Received:  by oss.sgi.com id <S42228AbQHMPRf>;
	Sun, 13 Aug 2000 08:17:35 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:2671 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42207AbQHMPR3>; Sun, 13 Aug 2000 08:17:29 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id IAA06004
	for <linux-mips@oss.sgi.com>; Sun, 13 Aug 2000 08:23:34 -0700 (PDT)
	mail_from (alan@lxorguk.ukuu.org.uk)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA49623
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 13 Aug 2000 08:17:07 -0700 (PDT)
	mail_from (alan@lxorguk.ukuu.org.uk)
Received: from the-village.bc.nu (lightning.swansea.uk.linux.org [194.168.151.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id IAA08644
	for <linux@cthulhu.engr.sgi.com>; Sun, 13 Aug 2000 08:17:00 -0700 (PDT)
	mail_from (alan@lxorguk.ukuu.org.uk)
Received: from alan by the-village.bc.nu with local (Exim 2.12 #1)
	id 13NzPH-0001bK-00; Sun, 13 Aug 2000 16:10:35 +0100
Subject: Re: [linux-fbdev] SGI VW 540, fbdev and pot pourii of faults and
To:     i15@ornl.gov
Date:   Sun, 13 Aug 2000 16:10:31 +0100 (BST)
Cc:     jsimmons@acsu.buffalo.edu (James Simmons),
        linux-fbdev@vuser.vu.union.edu, linux@cthulhu.engr.sgi.com
In-Reply-To: <Pine.SGI.4.10.10008091908170.26870-100000@tigger.ccs.ornl.gov> from "philloc@tigger.ccs.ornl.gov" at Aug 09, 2000 07:28:07 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13NzPH-0001bK-00@the-village.bc.nu>
From:   Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

> 	Anyone from SGI care to comment on why SGI has not released the
> specs to reasonable attention, since they are unable to help port? 

Try getting the sources for the 3d driver and graphics components on their
current workstation.

> 	Hey as an aside, anyone know how to "uncompress" a "vmlinuz"
> kernel to a "vmlinux"? SGI had posted a kernel or 2 , but always in the
> "vmlinuz" format. To the best of my knowledge cannot be booted
> on the VW 540.

gzip -d <vmlinuz >vmlinux should be fine.
