Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8E2hJh20145
	for linux-mips-outgoing; Thu, 13 Sep 2001 19:43:19 -0700
Received: from real.realitydiluted.com (real.realitydiluted.com [208.242.241.164])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8E2hFe20141
	for <linux-mips@oss.sgi.com>; Thu, 13 Sep 2001 19:43:15 -0700
Received: from localhost.localdomain ([127.0.0.1] helo=cotw.com)
	by real.realitydiluted.com with esmtp (Exim 3.22 #1 (Red Hat Linux))
	id 15hiwe-0002CI-00; Thu, 13 Sep 2001 21:43:08 -0500
Message-ID: <3BA16CAA.6B4DF4A1@cotw.com>
Date: Thu, 13 Sep 2001 21:34:18 -0500
From: "Steven J. Hill" <sjhill@cotw.com>
Reply-To: sjhill@cotw.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-xfs i686)
X-Accept-Language: en
MIME-Version: 1.0
To: binutils@sources.redhat.com, gdb@sourceware.cygnus.com,
   linux-mips@oss.sgi.com
Subject: Continued MIPS kernel debugging symbols problem...
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Greetings.

I have tried everything I can to get Linux kernel debugging
symbols to work properly. I apologize for posting to so
many lists too, but I really need to get this working. I
traded a few emails with HJ Lu and he referred me to the
following messages/threads:

   http://sources.redhat.com/ml/gdb/2001-08/msg00053.html
   http://sources.redhat.com/ml/gdb/2001-08/msg00079.html
   http://sources.redhat.com/ml/gdb/2001-08/msg00084.html

I did read them a few times and it appears that all the
necessary changes are in the current gdb and insight CVS
repositories. I checked out the latest sources a half
hour ago and compiled both gdb and insight using the
configuration line:

    configure --prefix=/opt/tools --target=mipsel-linux-elf

since my target is a NEC 5432 running in LE mode. I had
also tried 'mips-linux-elf' targets earlier in the day
with no difference. I am still getting the following
mismatch in symbols:

--------------------------------------------------------------------
(gdb) target remote /dev/ttyS1
Remote debugging using /dev/ttyS1
0x80012828 in breakinst () at af_packet.c:1879
1879            sock_unregister(PF_PACKET);
(gdb) bt
#0  0x80012828 in breakinst () at af_packet.c:1879
#1  0x8001a0d4 in sys_create_module (name_user=0x10001dc8 "cfi_probe",
    size=8176) at module.c:305
(gdb) c
Continuing.
--------------------------------------------------------------------

I compiled my kernel with a toolchain that used the following
versions of tools:

    binutils-2.11.90.0.31 (HJLu patches applied)
    gcc-3.0.1 (stock)
    glibc-2.2.3 (minor build patches)

Things are still not working and I would greatly appreciate some
direction. I've blown a whole day this and am a bit frazzled.
Thanks a bunch in advance.

-Steve

-- 
 Steven J. Hill - Embedded SW Engineer
