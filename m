Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7FA49Rw028412
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 15 Aug 2002 03:04:09 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7FA49Xp028411
	for linux-mips-outgoing; Thu, 15 Aug 2002 03:04:09 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (mx2.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7FA43Rw028400
	for <linux-mips@oss.sgi.com>; Thu, 15 Aug 2002 03:04:03 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g7FA6WXb014275
	for <linux-mips@oss.sgi.com>; Thu, 15 Aug 2002 03:06:32 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id DAA22510
	for <linux-mips@oss.sgi.com>; Thu, 15 Aug 2002 03:06:31 -0700 (PDT)
Received: from coplin19.mips.com (IDENT:root@coplin19 [192.168.205.89])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g7FA6Vb26171
	for <linux-mips@oss.sgi.com>; Thu, 15 Aug 2002 12:06:31 +0200 (MEST)
Received: from localhost (kjelde@localhost)
	by coplin19.mips.com (8.11.6/8.11.6) with ESMTP id g7FA6VN02588
	for <linux-mips@oss.sgi.com>; Thu, 15 Aug 2002 12:06:31 +0200
X-Authentication-Warning: coplin19.mips.com: kjelde owned process doing -bs
Date: Thu, 15 Aug 2002 12:06:31 +0200 (MEST)
From: Kjeld Borch Egevang <kjelde@mips.com>
To: linux-mips mailing list <linux-mips@oss.sgi.com>
Subject: N32 support in 64-bit MIPS Linux
Message-ID: <Pine.LNX.4.44.0208151140060.2195-100000@coplin19.mips.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi all.

I would like to hear your opinion on this.

Currently we have the N64 interface which is the basic interface to the
kernel. Then we have the O32 interface which is implemented as a separate
set of syscalls in unistd.h and proper conversion in the kernel.

Now, how can we support N32? Many syscalls will work if N32 is treated the
same way as O32. This will of course mean, that O32 must be compiled in in
order to support N32. But e.g. a syscall like:

int _llseek(unsigned int fd, unsigned long offset_high, unsigned long 
offset_low, loff_t *result, unsigned int whence);

needs special treatment since loff_t is a long long (passed in a single
register for N32) and there are 6 arguments (all passed in registers for
N32, passed in registers and on the stack for O32).

Should we simply add 235 new syscall numbers to unistd.h named 
__NR_LinuxN32...?


/Kjeld


-- 
_    _ ____  ___                       Mailto:kjelde@mips.com
|\  /|||___)(___    MIPS Denmark       Direct: +45 44 86 55 85
| \/ |||    ____)   Lautrupvang 4 B    Switch: +45 44 86 55 55
  TECHNOLOGIES      DK-2750 Ballerup   Fax...: +45 44 86 55 56
                    Denmark            http://www.mips.com/
