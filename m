Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Feb 2004 16:56:41 +0000 (GMT)
Received: from law10-f123.law10.hotmail.com ([IPv6:::ffff:64.4.15.123]:26128
	"EHLO hotmail.com") by linux-mips.org with ESMTP
	id <S8225340AbUBWQ4i>; Mon, 23 Feb 2004 16:56:38 +0000
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Mon, 23 Feb 2004 08:56:31 -0800
Received: from 63.121.54.5 by lw10fd.law10.hotmail.msn.com with HTTP;
	Mon, 23 Feb 2004 16:56:30 GMT
X-Originating-IP: [63.121.54.5]
X-Originating-Email: [juszczec@hotmail.com]
X-Sender: juszczec@hotmail.com
From:	"Mark and Janice Juszczec" <juszczec@hotmail.com>
To:	linux-mips@linux-mips.org
Cc:	uhler@mips.com, kevink@mips.com, dom@mips.com, echristo@redhat.com
Subject: RE:  r3000 instruction set
Date:	Mon, 23 Feb 2004 16:56:30 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Law10-F123ODt9Cz93M0000b89a@hotmail.com>
X-OriginalArrivalTime: 23 Feb 2004 16:56:31.0039 (UTC) FILETIME=[FC54BCF0:01C3FA2D]
Return-Path: <juszczec@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4409
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juszczec@hotmail.com
Precedence: bulk
X-list: linux-mips


Hello folks

Thanks for all the information.  Its all been very useful.

Someone suggested posting the message I get.  Here it is:

>./kaffe-bin FirstClass
[kaffe-bin:6] Illgal instruction 674696a at 2abb034, ra=2adbffd0, 
P0_STATUS=0000500
pid 6: killed (signal 4)
>Reading command line: Try again
Kernel panic: Attmpted to kill int!

Someone else suggested dumping all the assembler instructions.  The listing 
is really long, so I made a unique list of the commands themselves.  If 
someone can tell me how to use the above error message to figure out the 
command causing the problem, I'd really appreciate it.  If that's 
impossible, can someone tell me which command listed below does not belong?

/opt/crosstool/mipsel-unknown-linux-gnu/gcc-3.2.3-glibc-2.2.3/bin/mipsel-unknown-linux-gnu-objdump 
-d kaffe-bin | awk '{print $3}' | sort -u

addiu
addu
b
beq
beqz
blez
bne
bnez
jalr
jr
lb
lbu
li
lui
lw
move
nop
ori
sb
sll
slt
sltiu
subu
sw

Finally, can someone tell me where I can get a copy of "See MIPS Run"

Thanks again for all the help

Mark

_________________________________________________________________
Say “good-bye” to spam, viruses and pop-ups with MSN Premium -- free trial 
offer! http://click.atdmt.com/AVE/go/onm00200359ave/direct/01/
