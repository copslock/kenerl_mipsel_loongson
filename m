Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f47Ke8B21559
	for linux-mips-outgoing; Mon, 7 May 2001 13:40:08 -0700
Received: from web11904.mail.yahoo.com (web11904.mail.yahoo.com [216.136.172.188])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f47Ke7F21556
	for <linux-mips@oss.sgi.com>; Mon, 7 May 2001 13:40:07 -0700
Message-ID: <20010507204006.12697.qmail@web11904.mail.yahoo.com>
Received: from [209.243.184.191] by web11904.mail.yahoo.com; Mon, 07 May 2001 13:40:06 PDT
Date: Mon, 7 May 2001 13:40:06 -0700 (PDT)
From: Wayne Gowcher <wgowcher@yahoo.com>
Subject: Re: usermode gdb / remote gdb
To: Jun Sun <jsun@mvista.com>
Cc: Michael Shmulevich <michaels@jungo.com>,
   Linux/MIPS <linux-mips@oss.sgi.com>
In-Reply-To: <3AEBE34C.5070009@jungo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Jun,


Having seen your recent posting regarding gdb, I am
wondering if you could help me. I downloaded gdb from
your web site, and tried compiling gdb-4.17 for a
mipsel target.

I got gdb to compile OK, but I couldn't get gdbserver
to compile. My problems seem similar to the problems
Michael Shmulevich had.

I couldn't find any documentation on what order to
apply patches, or which patches to apply, so I patched
with the following in the following order :

gdb-4.17-mips.patch
gdb-4.17-mips-gdbserver.patch
gdb-4.17-xref.patch

I configured gdb with :
./configure -target=mips-linux-elf

It configured OK and then built OK.

Then I configured gdbserver with :

../../configure --target=mipsel-linux-elf 

And then tried compiling.This compiled so far and then
gave numerous undefined references to functions such
as create_inferior,mywait, myresume etc which are
defined in low-linux.c.

So following the previous thread on gdbserver from
Micheal Shmulevich, I decided to try :

../../configure --host=mipsel-linux
--target=mipsel-linux-elf This gave the following
output :
gdbserver/configure.in:host is
mipsel-unknown-linux-gnu,target is
gdbserver/configure.in:host_cpu is mipsel, target cpu
is mipsel
Linked "xm.h" to "./../config/mips/xm-linux.h".
Linked "tm.h" to "./../config/mips-tm-embedl.h".
Linked "nm.h" to "./../config/nm-empty.h".
Created "Makefile"
/usr/local/src/gdb-5.0/gdb-4.17/gdb/gdbserver using
"../config/mips/mipsel-linux.mh" and
"../config/mips/embedl.mt"

I then build with : make CC=mipsel-linux-gcc.

The first file it tries to compile is low-linux.c and
immediately errors with :
low-linux.c:In function 'fetch_register':
low-linux.c:248: 'PT_READ_U' undeclared (first use in
function)

Looking at the source I believe PT_READ_U is undefined
because the link from nm.h to nm-linux.h is not made,
Michael made the same observation.

>From what I have written can you tell me where I am
going wrong ?

Any help would be greatly appreciated

Michael: If you have any tips on how to get gdbserver
working they will be warmly welcome.

TIA

Wayne


__________________________________________________
Do You Yahoo!?
Yahoo! Auctions - buy the things you want at great prices
http://auctions.yahoo.com/
