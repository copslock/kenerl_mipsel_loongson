Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8K38kt11364
	for linux-mips-outgoing; Wed, 19 Sep 2001 20:08:46 -0700
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8K38be11359;
	Wed, 19 Sep 2001 20:08:38 -0700
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 20 Sep 2001 03:08:37 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP
	id A65DDB462; Thu, 20 Sep 2001 12:08:32 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id MAA01732; Thu, 20 Sep 2001 12:08:28 +0900 (JST)
Date: Thu, 20 Sep 2001 12:13:16 +0900 (JST)
Message-Id: <20010920.121316.74756227.nemoto@toshiba-tops.co.jp>
To: linux-mips@oss.sgi.com
Cc: ralf@oss.sgi.com
Subject: NON FPU cpus (again)
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
X-Mailer: Mew version 2.0 on Emacs 20.7 / Mule 4.1 (AOI)
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
In-Reply-To: <20010207144857.B24485@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On 7 Feb 2001, Florian Lohoff reported exit_thread() problem on
NON-FPU CPUs.  Tt is still not solved in the current kernel.

>>>>> On Wed, 7 Feb 2001 14:48:58 +0100, Florian Lohoff <flo@rfc822.org> said:
flo> I stumbled over the current tree as on the 3912 we dont have a
flo> FPU so we cant use the default "exit_thread" which simply causes
flo> the CPU to halt (not even an cpu reset works)

Following codes in exit_thread() and flush_thread() should be executed
only if (mips_cpu.options & MIPS_CPU_FPU) == 0, shouldn't it?

		set_cp0_status(ST0_CU1);
		__asm__ __volatile__("cfc1\t$0,$31");

BTW, I can not see any point in copying FCR31 to r0.  What is a
purpose of the cfc1 instruction?

---
Atsushi Nemoto
