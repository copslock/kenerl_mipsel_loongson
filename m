Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9V2sHB18801
	for linux-mips-outgoing; Tue, 30 Oct 2001 18:54:17 -0800
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9V2sA018798;
	Tue, 30 Oct 2001 18:54:10 -0800
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 31 Oct 2001 02:54:10 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP
	id 7FF18B46D; Wed, 31 Oct 2001 11:54:08 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id LAA38696; Wed, 31 Oct 2001 11:54:08 +0900 (JST)
Date: Wed, 31 Oct 2001 11:58:56 +0900 (JST)
Message-Id: <20011031.115856.41626992.nemoto@toshiba-tops.co.jp>
To: ralf@oss.sgi.com
Cc: carstenl@mips.com, ahennessy@mvista.com, ajob4me@21cn.com,
   linux-mips@oss.sgi.com
Subject: Re: Toshiba TX3927 board boot problem.
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
In-Reply-To: <20011030155533.A28550@dea.linux-mips.net>
References: <3BDDF193.B6405A7F@mvista.com>
	<3BDE62B4.BE7A1885@mips.com>
	<20011030155533.A28550@dea.linux-mips.net>
X-Mailer: Mew version 2.0 on Emacs 20.7 / Mule 4.1 (AOI)
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

>>>>> On Tue, 30 Oct 2001 15:55:33 +0100, Ralf Baechle <ralf@oss.sgi.com> said:
ralf> So here is a preliminiary version of my patch.  Still untested
ralf> and needs to be applied to mips64 also.

Thank you.  This patch works fine for me.

One request: with this patch, a ptrace call for FPC_EIR returns error
on FPU-less CPUs.  The call can be handled without error (as for other
FP registers).

--- /tmp/ptrace.c	Wed Oct 31 11:44:16 2001
+++ arch/mips/kernel/ptrace.c	Wed Oct 31 11:46:10 2001
@@ -174,8 +174,7 @@
 			unsigned int flags;
 
 			if (!(mips_cpu.options & MIPS_CPU_FPU)) {
-				res = -EIO;
-				goto out;
+				break;
 			}
 
 			__save_flags(flags);
---
Atsushi Nemoto
