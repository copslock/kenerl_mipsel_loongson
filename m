Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f84FqnG25624
	for linux-mips-outgoing; Tue, 4 Sep 2001 08:52:49 -0700
Received: from animal.pace.co.uk (gateway.pace.co.uk [195.44.197.250])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f84Fqkd25620
	for <linux-mips@oss.sgi.com>; Tue, 4 Sep 2001 08:52:46 -0700
Received: from exchange1.cam.pace.co.uk (exchange1.cam.pace.co.uk [136.170.131.80])
	by animal.pace.co.uk (8.10.2/8.10.2) with ESMTP id f84Fqe720700
	for <linux-mips@oss.sgi.com>; Tue, 4 Sep 2001 16:52:40 +0100
Received: by exchange1.cam.pace.co.uk with Internet Mail Service (5.5.2650.21)
	id <S2BF7RCX>; Tue, 4 Sep 2001 16:52:13 +0100
Message-ID: <54045BFDAD47D5118A850002A5095CC30AC575@exchange1.cam.pace.co.uk>
From: Phil Thompson <Phil.Thompson@pace.co.uk>
To: "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Subject: Signal 11 on Process Termination
Date: Tue, 4 Sep 2001 16:52:12 +0100 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I have a propietary board running a copy of HJ's RedHat 7.1. I've recently
updated from 2.4.5 and old style timer and interrupt code to the latest CVS
(2.4.8) and new style timer and interrupt code.

With the new kernel I'm often seeing processes core dumping with signal 11,
but only under specific conditions. The process that dies is the parent or
grandparent of a "busy" process - something like a compilation. It seems to
die as the "busy" process terminates. Two specific examples...

cron dies after running updatedb, but doesn't dump core. init also dies, and
does dump core. It dies "in select() at soinit.c:56".

make dies after running a shell script that does lots of compilation (it's
actually building lmbench) "in wait4() at soinit.c:56".

I assume the reference to "soinit.c:56" is bogus.

If this is a generic problem then somebody else would have raised it by now.

In which case it's my new timer or interrupt code - but I can't come up with
an explaination of how changes in that area would cause the problem I am
seeing.

Any suggestions gratefully received.

Thanks,
Phil
