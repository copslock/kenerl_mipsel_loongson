Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6J31dE25041
	for linux-mips-outgoing; Wed, 18 Jul 2001 20:01:39 -0700
Received: from web13905.mail.yahoo.com (web13905.mail.yahoo.com [216.136.175.68])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6J31bV25033
	for <linux-mips@oss.sgi.com>; Wed, 18 Jul 2001 20:01:37 -0700
Message-ID: <20010719030136.63012.qmail@web13905.mail.yahoo.com>
Received: from [61.133.136.72] by web13905.mail.yahoo.com via HTTP; Wed, 18 Jul 2001 20:01:36 PDT
Date: Wed, 18 Jul 2001 20:01:36 -0700 (PDT)
From: Barry Wu <wqb123@yahoo.com>
Subject: about mipsel linux thread problem
To: linux-mips@oss.sgi.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk



Hi, all,

I just port mipsel linux 2.2.12 to our mips evaluation
board, and I use glibc-2.0.6-5l and linuxthread 0.7.
But when I run linuxthread application on it.
The application reports "Bus error".
I add some print information in linuxthreads source
code, and find that when call
linuxthreads/restart.h  suspend() function, the
application will Bus error.
I do not know which glibc and linuxthreads version
can support mips linux well. And I do not know what
the problem I meet is.
If someone knows, please help me!
Thanks!

Barry

__________________________________________________
Do You Yahoo!?
Get personalized email addresses from Yahoo! Mail
http://personal.mail.yahoo.com/
