Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0V6TYM05074
	for linux-mips-outgoing; Wed, 30 Jan 2002 22:29:34 -0800
Received: from tulatelecom.ru (scoter.tulatelecom.ru [212.12.0.2])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0V6TTd05071
	for <linux-mips@oss.sgi.com>; Wed, 30 Jan 2002 22:29:29 -0800
Received: from [212.12.1.112] (HELO 212.12.1.112)
  by tulatelecom.ru (CommuniGate Pro SMTP 3.5.2)
  with ESMTP id 4952625 for linux-mips@oss.sgi.com; Wed, 30 Jan 2002 22:27:17 +0300
Date: Wed, 30 Jan 2002 22:20:52 +0300
From: "Alexey V. Medvedev" <alexeym@tula.net>
X-Mailer: The Bat! (v1.45) Personal
Reply-To: "Alexey V. Medvedev" <alexeym@tula.net>
X-Priority: 3 (Normal)
Message-ID: <929142077.20020130222052@tula.net>
To: linux-mips@oss.sgi.com
Subject: Baget23-202
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


I'm looking for Baget23-202 (on MIPS R3081E chip) users.

There are some newbie questions.
1. We already use other's binary linux package with 2.2.1 kernel and Xfree framebuffer server.
Has this kernel known problems or it's stable?
Can I crosscompile other fully-functional kernel from sources (with graphics, ethernet over VME,
filesystem on flash and other baget-specific  stuff)?
Which is recomended version and where I can get it (bin/src)?

2. Where I can get crosscompiler?
This is BIG or LITTLE-ENDIAN system? (yes, I'm lamer :)
Can I use packages:
        binutils-mipsel-linux-2.8.1-1.i386.rpm 
        egcs-c++-mipsel-linux-1.0.3a-1.i386.rpm 
        egcs-mipsel-linux-1.0.3a-1.i386.rpm
        glibc-2.0.6.tar.gz 
        glibc-crypt-2.0.6.tar.gz 
        glibc-localedata-2.0.6.tar.gz 
        glibc-linuxthreads-2.0.6.tar.gz 
or -mips- instead -mipsel-, or something else?
If anybody can give me binary ready-to-use crosscompiler environment (with gcc, g++,
binutils and glibc), i'll be very grateful.

If you can answer in russian, it will be very nice. Because my English is broken :)

--
Alexey Medevdev
Tula, Russia
mailto:alexeym@tula.net
