Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Feb 2003 18:02:08 +0000 (GMT)
Received: from imo-d01.mx.aol.com ([IPv6:::ffff:205.188.157.33]:51388 "EHLO
	imo-d01.mx.aol.com") by linux-mips.org with ESMTP
	id <S8225205AbTBNSCI>; Fri, 14 Feb 2003 18:02:08 +0000
Received: from shenminshi@netscape.net
	by imo-d01.mx.aol.com (mail_out_v34.21.) id l.1b.7654709 (22682)
	 for <linux-mips@linux-mips.org>; Fri, 14 Feb 2003 13:01:34 -0500 (EST)
Received: from  netscape.net (mow-d22.webmail.aol.com [205.188.139.138]) by air-in04.mx.aol.com (v90_r2.5) with ESMTP id MAILININ43-0214130134; Fri, 14 Feb 2003 13:01:33 -0500
Date: Fri, 14 Feb 2003 13:01:33 -0500
From: shenminshi@netscape.net
To: linux-mips@linux-mips.org
Subject: when does "init" become usermode process
MIME-Version: 1.0
Message-ID: <6105D94A.6A2BDDA3.10683EB2@netscape.net>
X-Mailer: Atlas Mailer 2.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <shenminshi@netscape.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1427
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shenminshi@netscape.net
Precedence: bulk
X-list: linux-mips

Hi,
  I was reading the kernel boot code toward the end where kernel's init thread execve("/sbin/init",x,x). Execve() calls sys_execve() and do_execve(). All the manpage and kernel document told us the init is the first usermode process running in the system. However, when the execve("/sbin/init",x,x) runs in the kernel (init/main.c), I believe we are still in the kernel mode, aren't we? Unless execve() does the trick to turn init into usermode by setting the KU bit in the STATUS register. I checked the execve() code and its not obvious whether it does this or not. I then check the init source code and it does not mess around the KU bit either.

My question is when and how does init turn itself into usermode.


Thanks

sms

__________________________________________________________________
The NEW Netscape 7.0 browser is now available. Upgrade now! http://channels.netscape.com/ns/browsers/download.jsp 

Get your own FREE, personal Netscape Mail account today at http://webmail.netscape.com/
