Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Nov 2002 04:52:43 +0100 (CET)
Received: from web11903.mail.yahoo.com ([216.136.172.187]:4279 "HELO
	web11903.mail.yahoo.com") by linux-mips.org with SMTP
	id <S1121743AbSKHDwm>; Fri, 8 Nov 2002 04:52:42 +0100
Message-ID: <20021108035234.34238.qmail@web11903.mail.yahoo.com>
Received: from [209.243.184.191] by web11903.mail.yahoo.com via HTTP; Thu, 07 Nov 2002 19:52:34 PST
Date: Thu, 7 Nov 2002 19:52:34 -0800 (PST)
From: Wayne Gowcher <wgowcher@yahoo.com>
Subject: Enabling pthreads to use ll/sc instead of emulate_load_store_insn
To: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <wgowcher@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 604
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wgowcher@yahoo.com
Precedence: bulk
X-list: linux-mips

Hi,

I have an userland application that uses pthreads and
crashes with a segmentaion due to an "unaligned access
in function 'emulate_load_store_insn' ". 

The processor is an r4k and the application is being
compiled with mips2 switch, which I thought would
allow it to generate the ll/sc instructions natively
and not have to generate system calls to emulate it.
I am guessing this is because the pthread library I
have is from the sgi ftp site and it was compiled for
mips1 ??

If someone has any insight into how to get libpthread
to use ll/sc instructions instead of the mips system
call I would really appreciate hearing from them.

Also if anyone can "put me straight" on what is
happening I'd equally appreciate it.

Wayne

__________________________________________________
Do you Yahoo!?
U2 on LAUNCH - Exclusive greatest hits videos
http://launch.yahoo.com/u2
