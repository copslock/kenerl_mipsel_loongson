Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Mar 2004 10:29:30 +0000 (GMT)
Received: from web60703.mail.yahoo.com ([IPv6:::ffff:216.109.117.226]:58754
	"HELO web60703.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225206AbUCZK3Z>; Fri, 26 Mar 2004 10:29:25 +0000
Message-ID: <20040326102917.53609.qmail@web60703.mail.yahoo.com>
Received: from [61.11.17.69] by web60703.mail.yahoo.com via HTTP; Fri, 26 Mar 2004 02:29:17 PST
Date: Fri, 26 Mar 2004 02:29:17 -0800 (PST)
From: Shantanu Gogate <sagogate@yahoo.com>
Subject: mips gcc compile error : unrecognized opcode errors
To: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <sagogate@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4648
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sagogate@yahoo.com
Precedence: bulk
X-list: linux-mips

Hi,
I am trying to cross compile a user mode application for mips and I am getting these error
messages when trying to do that:

/tmp/ccgvdHuk.s: Assembler messages:
/tmp/ccgvdHuk.s:1270: Error: unrecognized opcode `btl $4,0($2)'
/tmp/ccgvdHuk.s:1270: Error: unrecognized opcode `setcb $25'
/tmp/ccgvdHuk.s:3124: Error: unrecognized opcode `btl $4,0($2)'
/tmp/ccgvdHuk.s:3124: Error: unrecognized opcode `setcb $25'
/tmp/ccgvdHuk.s:3769: Error: unrecognized opcode `btl $4,0($2)'
/tmp/ccgvdHuk.s:3769: Error: unrecognized opcode `setcb $25'

These occur on a specific file always, other c files seem to compile just fine. I tried using
'sdelinuxeb-5.03.06-1' AND 'sdelinux-5.01-4eb' and both bail out in gcc with the same messages at
the same location.
My CFLAGS look like this:
CFLAGS += $(shell $(CC)-print-search-dirs | sed -ne "s/install: *\(.*\)/-I\1include/gp") -I
/work/GLIBC/usr/include/ -I /work/linux-2.4.25/include/ -Wa,-mips3 -mcpu=r4600 -mips2 -Wa,-32
-Wa,-march=r4600 -Wa,--trap

I was able to successfully cross compile the kernel and busybox using the same cross
toolchain(although i needed to use 5.03 for busybox). I am running these on a redhat 7.3 box (alse
tried on 9.0), although I doubt if that really matters and its just the sdelinux version that
matters. My GLIBC for cross compile is from glibc-devel-2.2.5-42.1.mips.rpm.

Any pointers on the one (or many) thing(s) I could be doing wrong to get these error messages ? Is
there a 'comprehensive' one stop location where i can download binaries/source for doing mipseb
cross compile activities (i.e glibc + gcc+ binutils+ ...) and work.

All help would be appreciated:)

regards,
Shantanu.



__________________________________
Do you Yahoo!?
Yahoo! Finance Tax Center - File online. File on time.
http://taxes.yahoo.com/filing.html
