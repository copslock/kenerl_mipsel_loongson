Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jan 2003 12:36:10 +0000 (GMT)
Received: from ip-161-71-171-238.corp-eur.3com.com ([IPv6:::ffff:161.71.171.238]:18922
	"EHLO columba.www.eur.3com.com") by linux-mips.org with ESMTP
	id <S8226125AbTAJMgK>; Fri, 10 Jan 2003 12:36:10 +0000
Received: from toucana.eur.3com.com (toucana.EUR.3Com.COM [140.204.220.50])
	by columba.www.eur.3com.com  with ESMTP id h0ACbcNS017223;
	Fri, 10 Jan 2003 12:37:44 GMT
Received: from notesmta.eur.3com.com (eurmta1.EUR.3Com.COM [140.204.220.206])
	by toucana.eur.3com.com  with SMTP id h0ACbQQ17121;
	Fri, 10 Jan 2003 12:37:26 GMT
Received: by notesmta.eur.3com.com(Lotus SMTP MTA v4.6.3  (733.2 10-16-1998))  id 80256CAA.00453B66 ; Fri, 10 Jan 2003 12:36:11 +0000
X-Lotus-FromDomain: 3COM
From: "Jon Burgess" <Jon_Burgess@eur.3com.com>
To: "atul srivastava" <atulsrivastava9@rediffmail.com>
cc: linux-mips@linux-mips.org
Message-ID: <80256CAA.00453946.00@notesmta.eur.3com.com>
Date: Fri, 10 Jan 2003 12:33:13 +0000
Subject: Re: handling of s-record images by bootloader
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Return-Path: <Jon_Burgess@eur.3com.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1118
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Jon_Burgess@eur.3com.com
Precedence: bulk
X-list: linux-mips




atul srivastava wrote:
> I am umware that, how differently s-record image need
> to be handled..?
> i just need some idea or if possible any example code for that..


On second thoughts the binutils code is probably rather large. You could try the
pmon source

http://www.carmel.com/pmon/pmon.tgz

pmon/tools/rdsrec.c might do what you want.

     Jon
