Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8EHB9r00840
	for linux-mips-outgoing; Fri, 14 Sep 2001 10:11:09 -0700
Received: from www.transvirtual.com (root@www.transvirtual.com [206.14.214.140])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8EHB7e00836
	for <linux-mips@oss.sgi.com>; Fri, 14 Sep 2001 10:11:07 -0700
Received: from www.transvirtual.com (jsimmons@localhost [127.0.0.1])
        by localhost (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id f8EHAxuI024674;
	Fri, 14 Sep 2001 10:10:59 -0700
Received: from localhost (jsimmons@localhost)
        by www.transvirtual.com (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id f8EHAxw0024670;
	Fri, 14 Sep 2001 10:10:59 -0700
X-Authentication-Warning: www.transvirtual.com: jsimmons owned process doing -bs
Date: Fri, 14 Sep 2001 10:10:58 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: "H . J . Lu" <hjl@lucon.org>
cc: linux-mips@oss.sgi.com
Subject: Re: PATCH: Fix offset of mmap
In-Reply-To: <20010914100700.A16047@lucon.org>
Message-ID: <Pine.LNX.4.10.10109141009260.20461-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


> We should check if offset of mmap is on the page boundary.

I believe this would break certain pieces of hardware. For example the
mq200 framebuffer in the sigmarion is not paged aligned. You have to
supply a offset to make it work.
