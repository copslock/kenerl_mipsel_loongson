Received:  by oss.sgi.com id <S42242AbQGVCk4>;
	Fri, 21 Jul 2000 19:40:56 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:64614 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42236AbQGVCk0>;
	Fri, 21 Jul 2000 19:40:26 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id TAA03982
	for <linux-mips@oss.sgi.com>; Fri, 21 Jul 2000 19:32:31 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id TAA43338
	for <linux@engr.sgi.com>;
	Fri, 21 Jul 2000 19:39:45 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from hermes.mvista.com (gateway-490.mvista.com [63.192.220.206]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id TAA06058
	for <linux@engr.sgi.com>; Fri, 21 Jul 2000 19:39:45 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.9.3/8.9.3) with ESMTP id TAA29846;
	Fri, 21 Jul 2000 19:39:44 -0700
Message-ID: <3979096E.2E11AFA6@mvista.com>
Date:   Fri, 21 Jul 2000 19:39:42 -0700
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.12-20b i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr
Subject: kmem_alloc: NULL ptr (name=unknown)
 	 - is it a serious problem?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


I found a couple of these annoying messages at the beginning of kernel
startup.  It seems that some subsystems are requesting regions
(request_region()) before kernel even initialize its memory.

It appears to me this reservation is just for mutual exclusive access to
some memory region.  Since I have a static system (no PnP and hot swap
etc), so I can safely ignore them. 

Does that make sense?

What is the right to avoid these warnings?

Jun
