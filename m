Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f75Gm9I16535
	for linux-mips-outgoing; Sun, 5 Aug 2001 09:48:09 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f75Gm8V16532
	for <linux-mips@oss.sgi.com>; Sun, 5 Aug 2001 09:48:08 -0700
Received: from lucon.org (lake.in.lucon.org [192.168.0.2])
	by ocean.lucon.org (Postfix) with ESMTP
	id 56D8B125C3; Sun,  5 Aug 2001 09:48:07 -0700 (PDT)
Received: by lucon.org (Postfix, from userid 1000)
	id DB524EFB6; Sun,  5 Aug 2001 09:48:06 -0700 (PDT)
Date: Sun, 5 Aug 2001 09:48:06 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Eric Christopher <echristo@redhat.com>
Cc: gcc@gcc.gnu.org, linux-mips@oss.sgi.com,
   GNU C Library <libc-alpha@sourceware.cygnus.com>
Subject: Changing WCHAR_TYPE from "long int" to "int"?
Message-ID: <20010805094806.A3146@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I am working with Eric to clean up the Linux/mips configuration in
gcc 3.x. I'd like to change WCHAR_TYPE from "long int" to "int". They
are the same on Linux/mips. There won't be any run-time problems. I am
wondering if there are any compatibility problems at the compile time
at the source and binary level. For one thing, __WCHAR_TYPE__ will be
changed from "long int" to "int". The only thing I can think of is
the C++ libraries. But gcc 3.x doesn't work on Linux/mips. The one
I am working on will be the first gcc 3.x for Linux/mips. So there
shouldn't be any problems. Am I right?


H.J.
