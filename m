Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jan 2003 10:21:59 +0000 (GMT)
Received: from ip-161-71-171-238.corp-eur.3com.com ([IPv6:::ffff:161.71.171.238]:4807
	"EHLO columba.www.eur.3com.com") by linux-mips.org with ESMTP
	id <S8226119AbTAJKV6>; Fri, 10 Jan 2003 10:21:58 +0000
Received: from toucana.eur.3com.com (toucana.EUR.3Com.COM [140.204.220.50])
	by columba.www.eur.3com.com  with ESMTP id h0AANYNS006441;
	Fri, 10 Jan 2003 10:23:34 GMT
Received: from notesmta.eur.3com.com (eurmta1.EUR.3Com.COM [140.204.220.206])
	by toucana.eur.3com.com  with SMTP id h0AANKQ03089;
	Fri, 10 Jan 2003 10:23:20 GMT
Received: by notesmta.eur.3com.com(Lotus SMTP MTA v4.6.3  (733.2 10-16-1998))  id 80256CAA.0038F253 ; Fri, 10 Jan 2003 10:22:00 +0000
X-Lotus-FromDomain: 3COM
From: "Jon Burgess" <Jon_Burgess@eur.3com.com>
To: "atul srivastava" <atulsrivastava9@rediffmail.com>
cc: linux-mips@linux-mips.org
Message-ID: <80256CAA.0038F181.00@notesmta.eur.3com.com>
Date: Fri, 10 Jan 2003 10:21:42 +0000
Subject: Re: handling of s-record images by bootloader
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Return-Path: <Jon_Burgess@eur.3com.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1117
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Jon_Burgess@eur.3com.com
Precedence: bulk
X-list: linux-mips



> I am umware that, how differently s-record image need
> to be handled..?
> i just need some idea or if possible any example code for that..

Have you tried looking at binutils? objcopy can convert Binary<->S-Record

     Jon
