Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0PLkp428640
	for linux-mips-outgoing; Fri, 25 Jan 2002 13:46:51 -0800
Received: from real.realitydiluted.com (real.realitydiluted.com [208.242.241.164])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0PLklP28619
	for <linux-mips@oss.sgi.com>; Fri, 25 Jan 2002 13:46:47 -0800
Received: from localhost.localdomain ([127.0.0.1] helo=cotw.com)
	by real.realitydiluted.com with esmtp (Exim 3.22 #1 (Red Hat Linux))
	id 16UDF6-0003SW-00; Fri, 25 Jan 2002 14:46:36 -0600
Message-ID: <3C51C427.392B40E4@cotw.com>
Date: Fri, 25 Jan 2002 14:46:31 -0600
From: "Steven J. Hill" <sjhill@cotw.com>
Reply-To: sjhill@cotw.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-xfs i686)
X-Accept-Language: en
MIME-Version: 1.0
To: libc-alpha@sources.redhat.com, linux-mips@oss.sgi.com
Subject: New MIPS cross toolchain using glibc-2.2.5pre1....
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Greetings.

First I want to thank HJ Lu for his patience as I traded quite
a few emails with him trying to get this up and working. I was
successful with building a new MIPS toolchain using the following:

    binutils-cvs-LATEST
    gcc-cvs-LATEST (gcc-3.1)
    glibc-2.2.5pre1

It compiles kernels and user apps with no problems. I have made
everything available here:

    ftp://ftp.cotw.com/Linux/MIPS/toolchain/experimental

Most important is the patch required to glibc-2.2.5pre1 in order
for a MIPS toolchain to even build. The other important item is
that it is absolutely necessary to specify the '--enable-kernel=2.4.X'
option when configuring glibc, or you will have problems with
undefined versioned symbols related to GLIBC_2.1. There is also
a shell script in the 'sources' directory that shows the exact steps
that I used. Hopefully this will be of some use to someone. Cheers.

-Steve

-- 
 Steven J. Hill - Embedded SW Engineer
