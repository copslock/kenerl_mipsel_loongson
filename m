Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5LLA2B21265
	for linux-mips-outgoing; Thu, 21 Jun 2001 14:10:02 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5LLA2V21262
	for <linux-mips@oss.sgi.com>; Thu, 21 Jun 2001 14:10:02 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f5LL9u031108;
	Thu, 21 Jun 2001 14:09:56 -0700
Message-ID: <3B326224.DE937DAA@mvista.com>
Date: Thu, 21 Jun 2001 14:07:48 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: A confusing oops dump ...
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I got the following oops dump during a stress load, which I cannot make any
sense out of it.  The most confusing part is that the status register
indicates program was running in kernel (KSU bits) while the $epc points to a
userland address.  How could this be ever possible at hardware level?

The only possible explanation is perhaps those saved registers were corrupted
between when the exception happens and core dumps, but so unlikely .... *sigh*

Any insight?

Jun

Unable to handle kernel paging request at virtual address 100096e0, epc ==
10000
Oops in fault.c:do_page_fault, line 172:
$0 : 00000000 100015d4 00000001 81e43160
$4 : 00000001 00000001 00000000 8328a680
$8 : 0000308e 00000000 800ba0dc 00000003
$12: 00000010 2ac45e7c 00000000 82f6e039
$16: 0041393c 10003510 000005f0 00000000
$20: 0000308e 00000000 fffffffc 00409350
$24: 00000000 2ab92f10
$28: 83b18000 7fff77f0 10003510 100096e0
epc   : 100096e0
Status: 30017c03
Cause : 00008008
Process  (pid: 0, stackpage=7fff6000)
Stack: 100096e0 7fff7800 004036f0 004036d4 10003518 7fff6fec 00000000 6f727020
       100096e0 7fff6930 7fff7b04 00004dd1 7fff7920 0fb64798 00000000 00000000
       00000000 00000000 0fb94020 00000000 00000000 00000000 0fb600cc 00000000
       00000000 00000000 00000000 00000000 00000000 0fb60104 0fb600d4 0fb600dc
       0fb600e4 00000000 00000000 00000000 0fb600ec 0fb600f4 00000000 00000000
       0fb600cc ...
Call Trace:
Code: (Bad address in epc)
