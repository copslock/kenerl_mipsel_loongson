Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8GCIHR10146
	for linux-mips-outgoing; Sun, 16 Sep 2001 05:18:17 -0700
Received: from minerva (pat.opera.no [213.141.139.59])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8GCIAe10142
	for <linux-mips@oss.sgi.com>; Sun, 16 Sep 2001 05:18:11 -0700
Received: from pere by minerva with local (Exim 3.12 #1 (Debian))
	id 15iary-0002nW-00; Sun, 16 Sep 2001 14:17:54 +0200
To: linux-mips@oss.sgi.com
Subject: linker problem: relocation truncated to fit
From: Petter Reinholdtsen <pere@hungry.com>
Message-Id: <E15iary-0002nW-00@minerva>
Date: Sun, 16 Sep 2001 14:17:54 +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Hello

I'm using debian/mips (sid) on an SGI Indy with 256 MB RAM.  It is as
far as I know up to date with the latest packages.

When I try to compile and link a huge C++ program using Qt and various
other libraries, I get strange error message like this during linking:

  libopera.a(registerdialog.o): In function
    `RegisterDialog::RegisterDialog(QWidget *, char const *, bool)':
  linux/ui/registerdialog.cpp(.text+0xd08): relocation truncated to
    fit: R_MIPS_GOT16 RegisterDialog virtual table
  libopera.a(registerdialog.o): In function
    `RegisterDialog::slotOk(void)':
  linux/ui/registerdialog.cpp(.text+0xdd8): relocation truncated to
    fit: R_MIPS_CALL16 RegisterWidget::verifySettings(void)
  libopera.a(registerdialog.o): In function `onceinalifetime(void)':
  regkey/regver.h(.text+0x10d8): relocation truncated to fit:
    R_MIPS_CALL16 regkey_init(void)

Is this a known problem, and is there anything I can do to fix it?

% dpkg -l | egrep 'gcc|binutils|g\+\+'
ii  binutils       2.11.90.0.31-1 The GNU assembler, linker and binary utiliti
ii  g++            2.95.4-6       The GNU C++ compiler.
ii  g++-2.95       2.95.4-0.01090 The GNU C++ compiler.
ii  gcc            2.95.4-6       The GNU C compiler.
ii  gcc-2.95       2.95.4-0.01090 The GNU C compiler.
