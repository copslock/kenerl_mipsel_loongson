Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Oct 2002 15:10:28 +0200 (CEST)
Received: from mx2.mips.com ([206.31.31.227]:22465 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S1123253AbSJYNK1>;
	Fri, 25 Oct 2002 15:10:27 +0200
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g9PDACNf014041;
	Fri, 25 Oct 2002 06:10:12 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id GAA28500;
	Fri, 25 Oct 2002 06:11:09 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g9PDAEb26567;
	Fri, 25 Oct 2002 15:10:14 +0200 (MEST)
Message-ID: <3DB942B5.830DD21D@mips.com>
Date: Fri, 25 Oct 2002 15:10:13 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Yet another 64-bit conversion patch
Content-Type: multipart/mixed;
 boundary="------------7369D79D6DBC87FB62B6FA45"
Return-Path: <carstenl@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 507
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: carstenl@mips.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------7369D79D6DBC87FB62B6FA45
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

Here is a conversion patch for the sysinfo syscall.

/Carsten


--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com



--------------7369D79D6DBC87FB62B6FA45
Content-Type: text/plain; charset=iso-8859-15;
 name="syscall_wrapper.part7.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="syscall_wrapper.part7.patch"

Index: arch/mips64/kernel/linux32.c
===================================================================
RCS file: /home/cvs/linux/arch/mips64/kernel/linux32.c,v
retrieving revision 1.42.2.18
diff -u -r1.42.2.18 linux32.c
--- arch/mips64/kernel/linux32.c	21 Oct 2002 12:57:58 -0000	1.42.2.18
+++ arch/mips64/kernel/linux32.c	25 Oct 2002 09:54:17 -0000
@@ -661,6 +661,46 @@
 	return sys32_wait4(pid, stat_addr, options, NULL);
 }
 
+struct sysinfo32 {
+        s32 uptime;
+        u32 loads[3];
+        u32 totalram;
+        u32 freeram;
+        u32 sharedram;
+        u32 bufferram;
+        u32 totalswap;
+        u32 freeswap;
+        unsigned short procs;
+        char _f[22];
+};
+
+extern asmlinkage int sys_sysinfo(struct sysinfo *info);
+
+asmlinkage int sys32_sysinfo(struct sysinfo32 *info)
+{
+	struct sysinfo s;
+	int ret, err;
+	mm_segment_t old_fs = get_fs ();
+	
+	set_fs (KERNEL_DS);
+	ret = sys_sysinfo(&s);
+	set_fs (old_fs);
+	err = put_user (s.uptime, &info->uptime);
+	err |= __put_user (s.loads[0], &info->loads[0]);
+	err |= __put_user (s.loads[1], &info->loads[1]);
+	err |= __put_user (s.loads[2], &info->loads[2]);
+	err |= __put_user (s.totalram, &info->totalram);
+	err |= __put_user (s.freeram, &info->freeram);
+	err |= __put_user (s.sharedram, &info->sharedram);
+	err |= __put_user (s.bufferram, &info->bufferram);
+	err |= __put_user (s.totalswap, &info->totalswap);
+	err |= __put_user (s.freeswap, &info->freeswap);
+	err |= __put_user (s.procs, &info->procs);
+	if (err)
+		return -EFAULT;
+	return ret;
+}
+
 #define RLIM_INFINITY32	0x7fffffff
 #define RESOURCE32(x) ((x > RLIM_INFINITY32) ? RLIM_INFINITY32 : x)
 
Index: arch/mips64/kernel/scall_o32.S
===================================================================
RCS file: /home/cvs/linux/arch/mips64/kernel/scall_o32.S,v
retrieving revision 1.48.2.17
diff -u -r1.48.2.17 scall_o32.S
--- arch/mips64/kernel/scall_o32.S	3 Oct 2002 09:38:26 -0000	1.48.2.17
+++ arch/mips64/kernel/scall_o32.S	25 Oct 2002 09:54:17 -0000
@@ -428,7 +428,7 @@
 	sys	sys_ni_syscall	0	/* sys_vm86 */
 	sys	sys32_wait4	4
 	sys	sys_swapoff	1			/* 4115 */
-	sys	sys_sysinfo	1
+	sys	sys32_sysinfo	1
 	sys	sys32_ipc		6
 	sys	sys_fsync	1
 	sys	sys32_sigreturn	0

--------------7369D79D6DBC87FB62B6FA45--
