Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f57IgWx02874
	for linux-mips-outgoing; Thu, 7 Jun 2001 11:42:32 -0700
Received: from mail-out2.apple.com (mail-out2.apple.com [17.254.0.51])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f57IgWh02869
	for <linux-mips@oss.sgi.com>; Thu, 7 Jun 2001 11:42:32 -0700
Received: from apple.con (A17-128-100-225.apple.com [17.128.100.225])
	by mail-out2.apple.com (8.9.3/8.9.3) with ESMTP id LAA05700
	for <linux-mips@oss.sgi.com>; Thu, 7 Jun 2001 11:42:32 -0700 (PDT)
Received: from scv1.apple.com (scv1.apple.com) by apple.con
 (Content Technologies SMTPRS 4.2.1) with ESMTP id <T53ff18034f118064e1474@apple.con>;
 Thu, 7 Jun 2001 11:40:49 +0100
Received: from apple.com (melos.apple.com [17.202.41.123])
	by scv1.apple.com (8.9.3/8.9.3) with ESMTP id LAA04270;
	Thu, 7 Jun 2001 11:42:30 -0700 (PDT)
Message-ID: <3B1FCAC9.2110A024@apple.com>
Date: Thu, 07 Jun 2001 11:41:13 -0700
From: Stan Shebs <shebs@apple.com>
X-Mailer: Mozilla 4.75 (Macintosh; U; PPC)
X-Accept-Language: en
MIME-Version: 1.0
To: "H . J . Lu" <hjl@lucon.org>
CC: GDB <gdb@sourceware.cygnus.com>, binutils@lucon.org,
   linux-mips@oss.sgi.com
Subject: Re: stabs or ecoff for Linux/mips
References: <20010607093149.B13198@lucon.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"H . J . Lu" wrote:
> 
> What is the better debug format for Linux/mips in the terms of gdb
> and binutils, stabs or ecoff? I know the future is dwarf2. But I need
> something stable now. Since Linux/x86 uses stabs, I lean toward to
> stabs. Any comments?

Go with stabs and ELF.  Neither ecoff's base file format nor the debug
info were particularly well-documented (I remember some of the bits in
GNU being figured out by reverse engineering!), perpetuating it will
just make your life more difficult in the long run.  It will also be
easier to move to dwarf2 when the opportunity arises.

Stan
