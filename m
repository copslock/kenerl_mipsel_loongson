Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fADK9q224118
	for linux-mips-outgoing; Tue, 13 Nov 2001 12:09:52 -0800
Received: from web11908.mail.yahoo.com (web11908.mail.yahoo.com [216.136.172.192])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fADK9m024115
	for <linux-mips@oss.sgi.com>; Tue, 13 Nov 2001 12:09:49 -0800
Message-ID: <20011113200948.75977.qmail@web11908.mail.yahoo.com>
Received: from [209.243.184.191] by web11908.mail.yahoo.com via HTTP; Tue, 13 Nov 2001 12:09:48 PST
Date: Tue, 13 Nov 2001 12:09:48 -0800 (PST)
From: Wayne Gowcher <wgowcher@yahoo.com>
Subject: ld error " linking PIC files with non-PIC files "
To: linux-mips@oss.sgi.com
In-Reply-To: <20011026161259.54925.qmail@web11908.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I am trying to cross compile X using the redhat7.0
distribution from the sgi mips site as my base. Most
files compile OK, but they fail at the link stage with
the following error :

linking PIC files with non-PIC files.

I created my cross-compile library files in
/usr/mipsel-linux from the packages :
glibc-2.2.2-1.mipsel.rpm &
glibc-devel-2.2.2-1.mipsel.rpm
are there other libraries I need ?

I found a reference on the web to a module called
libc6-pic.o, I don't see this anywhere in my libraries
is this what I need ?

Has anyone else seen this problem before and do they
know how to fix it ?

TIA

Wayne

__________________________________________________
Do You Yahoo!?
Find the one for you at Yahoo! Personals
http://personals.yahoo.com
