Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1QHxEW29230
	for linux-mips-outgoing; Tue, 26 Feb 2002 09:59:14 -0800
Received: from web11902.mail.yahoo.com (web11902.mail.yahoo.com [216.136.172.186])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1QHx2929226
	for <linux-mips@oss.sgi.com>; Tue, 26 Feb 2002 09:59:02 -0800
Message-ID: <20020226165902.73329.qmail@web11902.mail.yahoo.com>
Received: from [209.243.184.191] by web11902.mail.yahoo.com via HTTP; Tue, 26 Feb 2002 08:59:02 PST
Date: Tue, 26 Feb 2002 08:59:02 -0800 (PST)
From: Wayne Gowcher <wgowcher@yahoo.com>
Subject: Problem Cross compiling simple test program
To: linux-mips@oss.sgi.com
In-Reply-To: <20020225094525.GA16992@paradigm.rfc822.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I am trying to cross compile a simple "Hello World"
use app. I have the rpms (obtained from sgi site ) for
binutils-mipsel-linux-2.8.1-2 and
egcs-mipsel-linux-1.1.2-4 installed. I first started
using redhat 6.1 available on the sgi website and
extracted the glibc libraries from 

glibc-2.0.6-5lm.mipsel.rpm
glibc-devel-2.0.6-5lm.mipsel.rpm

to
/usr/mipsel-linux/lib &
/usr/mipsel-linux/include

When I compile my little test app using the following
it compiles OK and when executed on the MIPS target it
prints out "Hello World" on cue.

mipsel-linux-gcc -o hello hello.c

I wanted to use the redhat 7.0 distribution on sgi, so
I backed up the include and lib directories of
/usr/mipsel-linux and cleaned them out, then extracted
the redhat 7.0 glibc libraries. I then compiled the
same hello user app, but this time the app won't even
link and gives me the error :

/usr/mipsel-linux/bin/ld:
/usr/mipsel-linux/lib/libc.so.6: __libc_enable_secure:
invalid version 6 (max 5)
/usr/mipsel-linux/lib/libc.so.6: could not read
symbols: Bad value

Note, I hand edit /usr/mipsel-linux/lib/libc.so to
reflect the path to /usr/mipsel-linux instead of /lib
and /usr/lib.

Note if I go back to the backed up dirs I can still
compile hello.c.

I used the following files to extarct the glibc
libraries :
glibc-2.2.2-1.mipsel.rpm
glibc-common-2.2.2-1.mipsel.rpm

I use the following simple script to extract libraries
in both cases :

--start script---
mkdir tmp
cd tmp

# fileone=glibc-2.0.6-5lm.mipsel.rpm
# filetwo=glibc-devel-2.0.6-5lm.mipsel.rpm

fileone=glibc-2.2.2-1.mipsel.rpm
filetwo=glibc-devel-2.2.2-1.mipsel.rpm

rpm2cpio ../$fileone | cpio --extract
--make-directories
rpm2cpio ../$filetwo | cpio --extract
--make-directories

cp -a usr/include /usr/mipsel-linux

cp -a lib/* /usr/mipsel-linux/lib
cp -a usr/lib/* /usr/mipsel-linux/lib

cd ../
rm -fr tmp

cd /usr/mipsel-linux/lib
ls -l | grep "../../lib" | sed 's|../../lib/||' | awk
'{print "ln -sf", $11, $9 }' | tee fixit

sh fixit
rm fixit 

--- end of simple script ---

So that's what I am doing, and I would really
appreciate if anyone on the list could answer my
questions :

1, To cross compile target apps for redhat7.0, I do
really need to cross compile against the glibc-2.2.2
libraries don't I ? Could I get away with compiling
against the glibc-2.0.6 libraries ?

2, Has anyone managed to cross compile user apps
against redhat 7.0 ? If so how did you do it ? Please
give details.

3, Can anyone see anything wrong in what I have done
and if so, can you tell me what and where ?

TIA

Wayne


__________________________________________________
Do You Yahoo!?
Yahoo! Sports - Coverage of the 2002 Olympic Games
http://sports.yahoo.com
