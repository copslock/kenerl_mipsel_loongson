Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6CFKqRw006599
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 12 Jul 2002 08:20:52 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6CFKpY2006598
	for linux-mips-outgoing; Fri, 12 Jul 2002 08:20:51 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from columba.www.eur.3com.com (ip-161-71-171-238.corp-eur.3com.com [161.71.171.238])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6CFKiRw006589;
	Fri, 12 Jul 2002 08:20:44 -0700
Received: from toucana.eur.3com.com (toucana.EUR.3Com.COM [140.204.220.50])
	by columba.www.eur.3com.com  with ESMTP id g6CFQwE28852;
	Fri, 12 Jul 2002 16:26:58 +0100 (BST)
Received: from notesmta.eur.3com.com (eurmta1.EUR.3Com.COM [140.204.220.206])
	by toucana.eur.3com.com  with SMTP id g6CFPmR19242;
	Fri, 12 Jul 2002 16:25:48 +0100 (BST)
Received: by notesmta.eur.3com.com(Lotus SMTP MTA v4.6.3  (733.2 10-16-1998))  id 80256BF4.00551741 ; Fri, 12 Jul 2002 16:29:25 +0100
X-Lotus-FromDomain: 3COM
From: "Jon Burgess" <Jon_Burgess@eur.3com.com>
To: Carsten Langgaard <carstenl@mips.com>
cc: "Gleb O. Raiko" <raiko@niisi.msk.ru>, Ralf Baechle <ralf@oss.sgi.com>,
   linux-mips@oss.sgi.com
Message-ID: <80256BF4.005515BA.00@notesmta.eur.3com.com>
Date: Fri, 12 Jul 2002 16:24:59 +0100
Subject: Re: mips32_flush_cache routine corrupts CP0_STATUS with gcc-2.96
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk



>One of the things it fix, is a typo, which will hit you because you have
different
>size of the I- and D-caches.
>But it also fix, that in a lot of the cache routine, we only flush one of the
ways.
>
>Please see the attached patch, I think Ralf didn't liked it, because it wasn't
>optimized for speed, but at least it's better than what we got.
>
>/Carsten

The typo was fixed in the code which Broadcom supplied to us. I noticed this was
not fixed in the mainstream code and was meaning to submit a patch for it. I
will check out the other changes next week. Thanks for the patch.

     Jon
