Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Mar 2003 13:42:58 +0000 (GMT)
Received: from ip-161-71-171-238.corp-eur.3com.com ([IPv6:::ffff:161.71.171.238]:19617
	"EHLO columba.www.eur.3com.com") by linux-mips.org with ESMTP
	id <S8225206AbTCJNm5>; Mon, 10 Mar 2003 13:42:57 +0000
Received: from toucana.eur.3com.com (toucana.EUR.3Com.COM [140.204.220.50])
	by columba.www.eur.3com.com  with ESMTP id h2ADiT4J025494;
	Mon, 10 Mar 2003 13:44:30 GMT
Received: from notesmta.eur.3com.com (eurmta1.EUR.3Com.COM [140.204.220.206])
	by toucana.eur.3com.com  with SMTP id h2ADiXw01314;
	Mon, 10 Mar 2003 13:44:33 GMT
Received: by notesmta.eur.3com.com(Lotus SMTP MTA v4.6.3  (733.2 10-16-1998))  id 80256CE5.003944AF ; Mon, 10 Mar 2003 10:25:31 +0000
X-Lotus-FromDomain: 3COM
From: "Jon Burgess" <Jon_Burgess@eur.3com.com>
To: Ralf Baechle <ralf@linux-mips.org>
cc: linux-mips@linux-mips.org
Message-ID: <80256CE5.00390ADA.00@notesmta.eur.3com.com>
Date: Mon, 10 Mar 2003 10:22:56 +0000
Subject: Re: Struct sigaction cleanup
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Return-Path: <Jon_Burgess@eur.3com.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1681
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Jon_Burgess@eur.3com.com
Precedence: bulk
X-list: linux-mips



Ralf Wrote:
> Further no known libc implementation making use of sa_restorer.

I don't know if this is relevant, but Linus recently tried
changing the sa_restorer behaviour in the linux-2.5 kernel and
later had to back out the change. The following lines are from
recent changelogs:

http://www.uwsg.iu.edu/hypermail/linux/kernel/0301.1/0344.html
Linux-2.5.55:
Move x86 signal handler return stub to the vsyscall page, and stop
    honoring the SA_RESTORER information.

http://www.uwsg.iu.edu/hypermail/linux/kernel/0301.1/1884.html
Linux-2.5.57:
Re-instate the SA_RESTORER functionality, since it seems that some
    programs still depend on it and in fact do install a different
    signal restorer than the standard kernel version.


     Jon
