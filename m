Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f54JK2423157
	for linux-mips-outgoing; Mon, 4 Jun 2001 12:20:02 -0700
Received: from web11906.mail.yahoo.com (web11906.mail.yahoo.com [216.136.172.190])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f54JK2h23154
	for <linux-mips@oss.sgi.com>; Mon, 4 Jun 2001 12:20:02 -0700
Message-ID: <20010604192001.22785.qmail@web11906.mail.yahoo.com>
Received: from [209.243.184.191] by web11906.mail.yahoo.com; Mon, 04 Jun 2001 12:20:01 PDT
Date: Mon, 4 Jun 2001 12:20:01 -0700 (PDT)
From: Wayne Gowcher <wgowcher@yahoo.com>
Subject: Re: Native compile on the target using RedHat 6.1 rpms - Update
To: linux-mips@oss.sgi.com
In-Reply-To: <20010604174818.41079.qmail@web11904.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I found out what was breaking the compile :

I was setting -mcpu=r4600 -mips2. If I leave this off
everything compiles OK, but now the code isn't
optimized for the processor and does run slower ( of
course).

I also noted that if I use :
-mcpu=r4000 -mips2

I get the error :

/usr/bin/ld: /tmp/cca007591.o: ISA mismatch (-mips3)
with previous modules (-mips1)
/usr/bin/ld: /tmp/cca007591.o: uses different e_flags
(0x102) fields than previous modules (0x2)
Bad value: failed to merge target specific data of
file /tmp/cca007591.o
collect2: ld returned 1 exit status

Which I totally don't understand because I never set
mips3 I set mips2.

I am coming to the conclusion that :

the egcs-1.03a compiler as found on the sgi web site
only supports mips 1.

Can someone confirm or deny this ?

If that is so, how does anyone compile native mips2
code ? You have to build your own compiler / libraries
?

If anyone has / knows of an egcs-1.03a or higher
compiler capapble of compiling mips2 I'd really like
to hear from them.

TIA

Wayne


__________________________________________________
Do You Yahoo!?
Get personalized email addresses from Yahoo! Mail - only $35 
a year!  http://personal.mail.yahoo.com/
