Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5QGlce00885
	for linux-mips-outgoing; Tue, 26 Jun 2001 09:47:38 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5QGlaV00882
	for <linux-mips@oss.sgi.com>; Tue, 26 Jun 2001 09:47:36 -0700
Received: from pacbell.net (zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f5QGl9006014;
	Tue, 26 Jun 2001 09:47:09 -0700
Message-ID: <3B38BB9F.9050203@pacbell.net>
Date: Tue, 26 Jun 2001 09:43:11 -0700
From: Pete Popov <ppopov@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2-2 i586; en-US; rv:0.9.1) Gecko/20010607
X-Accept-Language: en-us
MIME-Version: 1.0
To: Scott A McConnell <samcconn@cotw.com>
CC: linux-mips@oss.sgi.com
Subject: Re: mmap problems ? in 2.4.5
References: <3B38CBFF.1BE0FD8C@cotw.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Scott A McConnell wrote:

>I have a simple program that maps a frame buffer into user space and
>draws an image
>onto the fb.
>
>This program worked fine under 2.4.3 however under 2.4.5 the program
>runs but nothing appears on the FB. The memory I am writing to does not
>appear to be the frame buffer.
>
>Nothing has changed in my fb driver so I am wondering if anything has
>changed in how memory is mapped via the kernel?
>
>Thanks for your consideration
>
I believe the frame buffer driver interface changed in 2.4.5. It 
supposed to be much cleaner now and the fb driver has to do less than 
before.  You'll probably need to port your driver to 2.4.5.  If you have 
any problems, I think the fb maintainers can help you out.

Pete
