Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fASA03008335
	for linux-mips-outgoing; Wed, 28 Nov 2001 02:00:03 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAS9xvo08300
	for <linux-mips@oss.sgi.com>; Wed, 28 Nov 2001 01:59:57 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id AAA09733
	for <linux-mips@oss.sgi.com>; Wed, 28 Nov 2001 00:59:50 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id AAA00676
	for <linux-mips@oss.sgi.com>; Wed, 28 Nov 2001 00:59:49 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id fAS8xlA00199
	for <linux-mips@oss.sgi.com>; Wed, 28 Nov 2001 09:59:47 +0100 (MET)
Message-ID: <3C04A786.DBD06A47@mips.com>
Date: Wed, 28 Nov 2001 09:59:50 +0100
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: The 2.4.14 kernel is broken for 5Kc CPUs.
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf please apply the following.


Index: arch/mips/kernel/setup.c
===================================================================
RCS file: /cvs/linux/arch/mips/kernel/setup.c,v
retrieving revision 1.93
diff -u -r1.93 setup.c
--- arch/mips/kernel/setup.c    2001/11/27 01:43:32     1.93
+++ arch/mips/kernel/setup.c    2001/11/28 09:54:10
@@ -466,8 +466,8 @@
                                mips_cpu.options |= MIPS_CPU_MIPS16;
                        if (config1 & 1)
                                mips_cpu.options |= MIPS_CPU_FPU;
-                       break;
                        mips_cpu.scache.flags = MIPS_CACHE_NOT_PRESENT;
+                       break;
                default:
                        mips_cpu.cputype = CPU_UNKNOWN;
                        break;


/Carsten

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
