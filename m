Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jan 2004 05:29:09 +0000 (GMT)
Received: from web11906.mail.yahoo.com ([IPv6:::ffff:216.136.172.190]:5128
	"HELO web11906.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8224893AbUA3F3B>; Fri, 30 Jan 2004 05:29:01 +0000
Message-ID: <20040130052734.26708.qmail@web11906.mail.yahoo.com>
Received: from [65.204.143.3] by web11906.mail.yahoo.com via HTTP; Thu, 29 Jan 2004 21:27:34 PST
Date: Thu, 29 Jan 2004 21:27:34 -0800 (PST)
From: Wayne Gowcher <wgowcher@yahoo.com>
Subject: Userland compilation breaking on _syscall5( )
To: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <wgowcher@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4198
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wgowcher@yahoo.com
Precedence: bulk
X-list: linux-mips

I am trying to compile some userland applications
against glibc 2.3.2 compiled with 2.4.24 headers, but
any userland app that uses calls to _syscall5 fail to
compile. With the usual error being 

parse error before "2nd argument".

So for the case of util-linux's fdisk utility, the
error is:

llseek.c:42: error: parse error before "_llseek"

and offending piece of code :

static _syscall5(int,_llseek,unsigned int,fd,unsigned
long,offset_high, unsigned long,
offset_low,ext2_loff_t *,result,
               unsigned int, origin)

I have previously compiled the same userland programs
against glibc 2.3.2 which has been compiled against
2.4.22 headers and all apps compiled OK.

I looked through cvs to see where things could be
going wrong and I am hazarding a guess that the
following change is responsible ( ?? ) :

Redo unistd.h files along the lines of 2.6.  So the
two files are now
identical and no more __NR_<random_ABI}_ prefixes,
just __NR_ as it
is expected by various user space packages.  This will
require some
adjustments in libc but I think it had to be done ...

If this indeed the cause of my problems could some
point me in the right direction as to how I should
patch glibc to accomadate the asm/unistd.h file change
???

Or if the above is not the problem, anyone know what
it is ??

TIA

Wayne

__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free web site building tool. Try it!
http://webhosting.yahoo.com/ps/sb/
