Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5QFn9B32479
	for linux-mips-outgoing; Tue, 26 Jun 2001 08:49:09 -0700
Received: from cvsftp.cotw.com (cvsftp.cotw.com [208.242.241.39])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5QFn7V32474
	for <linux-mips@oss.sgi.com>; Tue, 26 Jun 2001 08:49:08 -0700
Received: from cotw.com (ptecdev3.inter.net [192.168.10.5])
	by cvsftp.cotw.com (8.9.3/8.9.3) with ESMTP id KAA25066
	for <linux-mips@oss.sgi.com>; Tue, 26 Jun 2001 10:49:06 -0500
Message-ID: <3B38CBFF.1BE0FD8C@cotw.com>
Date: Tue, 26 Jun 2001 10:53:03 -0700
From: Scott A McConnell <samcconn@cotw.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: mmap problems ? in 2.4.5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I have a simple program that maps a frame buffer into user space and
draws an image
onto the fb.

This program worked fine under 2.4.3 however under 2.4.5 the program
runs but nothing appears on the FB. The memory I am writing to does not
appear to be the frame buffer.

Nothing has changed in my fb driver so I am wondering if anything has
changed in how memory is mapped via the kernel?

Thanks for your consideration

-- 
Scott A. McConnell
