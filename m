Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f57GVpq26854
	for linux-mips-outgoing; Thu, 7 Jun 2001 09:31:51 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f57GVoh26849
	for <linux-mips@oss.sgi.com>; Thu, 7 Jun 2001 09:31:50 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id E5A7B125BA; Thu,  7 Jun 2001 09:31:49 -0700 (PDT)
Date: Thu, 7 Jun 2001 09:31:49 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: GDB <gdb@sourceware.cygnus.com>, binutils@lucon.org,
   linux-mips@oss.sgi.com
Subject: stabs or ecoff for Linux/mips
Message-ID: <20010607093149.B13198@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

What is the better debug format for Linux/mips in the terms of gdb
and binutils, stabs or ecoff? I know the future is dwarf2. But I need
something stable now. Since Linux/x86 uses stabs, I lean toward to
stabs. Any comments?


H.J.
