Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6BIUQY16888
	for linux-mips-outgoing; Wed, 11 Jul 2001 11:30:26 -0700
Received: from real.realitydiluted.com (real.realitydiluted.com [208.242.241.164])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6BIUPV16883
	for <linux-mips@oss.sgi.com>; Wed, 11 Jul 2001 11:30:25 -0700
Received: from real.realitydiluted.com ([208.242.241.164] helo=cotw.com)
	by real.realitydiluted.com with esmtp (Exim 3.22 #1 (Red Hat Linux))
	id 15KOkV-0007Qb-00; Wed, 11 Jul 2001 13:30:11 -0500
Message-ID: <3B4C99CA.A2C9A9E8@cotw.com>
Date: Wed, 11 Jul 2001 13:24:10 -0500
From: "Steven J. Hill" <sjhill@cotw.com>
Reply-To: sjhill@cotw.com
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: linux-mips@oss.sgi.com
Subject: weird mmap bug from 2.4.3 -> 2.4.5...
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Greetings.

I have a framebuffer that is running under 2.4.3 on a MIPS
platform. I also wrote a small little demo program that simply
mmap's in the framebuffer in user space after which it simply
moves the tux logo across the screen. The framebuffer is also
used as the console and that also works great.

After upgrading to 2.4.5, mmap no longer works. However, the
console code works just fine i.e. the framebuffer console
properly updates and displays things just fine on the screen.
I can also do 'cat /bin/ls > /dev/fb0' and see garbage appear
on the screen.

Also, the virtual address returned by the mmap call for my
demo program in user space is identical on 2.4.3 and 2.4.5,
however no tux moves across the screen like it should for
the 2.4.5 kernel meaning that the mmap call didn't actually
get the framebuffer memory (that's my assumption).

I have traced through 'do_mmap_pgoff' and that code appears to
be nearly identical in 2.4.3 and 2.4.5. My architecture specific
MM code has not changed either, so the cache flushing assembly
code is identical. I'm working my way through the 'kmem_cache_XX'
calls right now to find differences. Anyone have some ideas?
Thanks.

-Steve 

-- 
 Steven J. Hill - Embedded SW Engineer
