Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f54HmJs12070
	for linux-mips-outgoing; Mon, 4 Jun 2001 10:48:19 -0700
Received: from web11904.mail.yahoo.com (web11904.mail.yahoo.com [216.136.172.188])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f54HmIh12067
	for <linux-mips@oss.sgi.com>; Mon, 4 Jun 2001 10:48:18 -0700
Message-ID: <20010604174818.41079.qmail@web11904.mail.yahoo.com>
Received: from [209.243.184.191] by web11904.mail.yahoo.com; Mon, 04 Jun 2001 10:48:18 PDT
Date: Mon, 4 Jun 2001 10:48:18 -0700 (PDT)
From: Wayne Gowcher <wgowcher@yahoo.com>
Subject: Native compile on the target using RedHat 6.1 rpms
To: linux-mips@oss.sgi.com
In-Reply-To: <200106012135.PAA16955@home.knm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Dear All,

I am trying to native compile for mipsel-linux using
the declinuxroot tar file as my NFS and egcs-1.0.3a-1
as my compiler, glibc-2.0.6-5lm as my libraries as
suggested by the README file in
oss.sgi.com/pub/linux/mips/mipsel-linux/README.

But when I try to compile I get the following error :

/usr/bin/ld: /tmp/cca003091.o: uses different e_flags
(0x102) fields than previous modules (0x2)
Bad value: failed to merge target specific data of
file /tmp/cca003091.o
collect2: ld returned 1 exit status
make: *** [pointer] Error 1

When I compile the same program using the RedHat 5.1
rpms / nfs the program compiles to completion OK.

Anybody seen this before ?
Any ideas what I am doing wrong ? missed out ? 

Any help appreciated.

Wayne


__________________________________________________
Do You Yahoo!?
Get personalized email addresses from Yahoo! Mail - only $35 
a year!  http://personal.mail.yahoo.com/
