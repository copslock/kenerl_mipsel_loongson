Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5QJKsh06122
	for linux-mips-outgoing; Tue, 26 Jun 2001 12:20:54 -0700
Received: from www.transvirtual.com (root@www.transvirtual.com [206.14.214.140])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5QJKrV06119
	for <linux-mips@oss.sgi.com>; Tue, 26 Jun 2001 12:20:53 -0700
Received: from www.transvirtual.com (jsimmons@localhost [127.0.0.1])
        by localhost (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id f5QJKfe9003855;
	Tue, 26 Jun 2001 12:20:41 -0700
Received: from localhost (jsimmons@localhost)
        by www.transvirtual.com (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id f5QJKfFF003851;
	Tue, 26 Jun 2001 12:20:41 -0700
X-Authentication-Warning: www.transvirtual.com: jsimmons owned process doing -bs
Date: Tue, 26 Jun 2001 12:20:40 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Pete Popov <ppopov@pacbell.net>
cc: Scott A McConnell <samcconn@cotw.com>, linux-mips@oss.sgi.com
Subject: Re: mmap problems ? in 2.4.5
In-Reply-To: <3B38BB9F.9050203@pacbell.net>
Message-ID: <Pine.LNX.4.10.10106261218260.30394-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


> I believe the frame buffer driver interface changed in 2.4.5. It 
> supposed to be much cleaner now and the fb driver has to do less than 
> before.  You'll probably need to port your driver to 2.4.5.  If you have 
> any problems, I think the fb maintainers can help you out.

Thats the wrapper I wrote so drivers could be written with the new api
while using 2.4.X. It hasn't gone in. Plus when/if it does it should have
a effect on any core code in fbcon. 
