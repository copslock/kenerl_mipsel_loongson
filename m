Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0UKFhX20762
	for linux-mips-outgoing; Wed, 30 Jan 2002 12:15:43 -0800
Received: from real.realitydiluted.com (real.realitydiluted.com [208.242.241.164])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0UKFed20759
	for <linux-mips@oss.sgi.com>; Wed, 30 Jan 2002 12:15:40 -0800
Received: from localhost.localdomain ([127.0.0.1] helo=cotw.com)
	by real.realitydiluted.com with esmtp (Exim 3.22 #1 (Red Hat Linux))
	id 16W0Ci-0001HI-00
	for <linux-mips@oss.sgi.com>; Wed, 30 Jan 2002 13:15:32 -0600
Message-ID: <3C584652.F16BFAA7@cotw.com>
Date: Wed, 30 Jan 2002 13:15:30 -0600
From: "Steven J. Hill" <sjhill@cotw.com>
Reply-To: sjhill@cotw.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-xfs i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: Re: [PATCH] Compiler warnings and remove unused code....
References: <3C582D6E.F86FBFE7@cotw.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Steven J. Hill" wrote:
> 
> Attached is a patch to clean up a bunch of compiler warnings. Specifically
> ones associated with gcc-3.x compilers and one use of __FUNCTION__ soon to
> be deprecated. Also added some #ifdef's for HIGHMEM and removed unused
> 5432 MM code. Please apply.
> 
I had no idea I would get this much email on the patch. Anyway, the toolchain
that I am using to compile with is:

    binutils-20020110
    gcc-3.0.3
    glibc-2.2.3
    linux-2.4.5 headers

-Steve

-- 
 Steven J. Hill - Embedded SW Engineer
