Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Feb 2004 17:11:51 +0000 (GMT)
Received: from mx.mips.com ([IPv6:::ffff:206.31.31.226]:25565 "EHLO
	mx.mips.com") by linux-mips.org with ESMTP id <S8225340AbUBWRLs>;
	Mon, 23 Feb 2004 17:11:48 +0000
Received: from mercury.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.12.11/8.12.11) with ESMTP id i1NGxfVE014622;
	Mon, 23 Feb 2004 08:59:41 -0800 (PST)
Received: from uhler-linux.mips.com (uhler-linux [192.168.65.120])
	by mercury.mips.com (8.12.11/8.12.11) with ESMTP id i1NH7pwp012959;
	Mon, 23 Feb 2004 09:07:51 -0800 (PST)
Subject: RE:  r3000 instruction set
From:	Michael Uhler <uhler@mips.com>
To:	Mark and Janice Juszczec <juszczec@hotmail.com>
Cc:	linux-mips@linux-mips.org, kevink@mips.com, dom@mips.com,
	echristo@redhat.com
In-Reply-To: <Law10-F123ODt9Cz93M0000b89a@hotmail.com>
References: <Law10-F123ODt9Cz93M0000b89a@hotmail.com>
Content-Type: text/plain
Organization: MIPS Technologies, Inc.
Message-Id: <1077556071.23710.2.camel@uhler-linux.mips.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date:	23 Feb 2004 09:07:51 -0800
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.39
Return-Path: <uhler@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4410
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: uhler@mips.com
Precedence: bulk
X-list: linux-mips

On Mon, 2004-02-23 at 08:56, Mark and Janice Juszczec wrote:
> Hello folks
> 
> Thanks for all the information.  Its all been very useful.
> 
> Someone suggested posting the message I get.  Here it is:
> 
> >./kaffe-bin FirstClass
> [kaffe-bin:6] Illgal instruction 674696a at 2abb034, ra=2adbffd0, 
> P0_STATUS=0000500
> pid 6: killed (signal 4)
> >Reading command line: Try again
> Kernel panic: Attmpted to kill int!

Under the assumption that I'm reading the message right and the
instruction is 0x674696a, that is absolutely a reserved instruction
(it is decoded as a RegImm format instruction with an illegal
rt field.  So unless the 3912 implements something at that code
point, it's really illegal.  I'd check the code generation to
see why it's generating that encoding.

> 
> Someone else suggested dumping all the assembler instructions.  The listing 
> is really long, so I made a unique list of the commands themselves.  If 
> someone can tell me how to use the above error message to figure out the 
> command causing the problem, I'd really appreciate it.  If that's 
> impossible, can someone tell me which command listed below does not belong?
> 
> /opt/crosstool/mipsel-unknown-linux-gnu/gcc-3.2.3-glibc-2.2.3/bin/mipsel-unknown-linux-gnu-objdump 
> -d kaffe-bin | awk '{print $3}' | sort -u
> 
> addiu
> addu
> b
> beq
> beqz
> blez
> bne
> bnez
> jalr
> jr
> lb
> lbu
> li
> lui
> lw
> move
> nop
> ori
> sb
> sll
> slt
> sltiu
> subu
> sw
> 
> Finally, can someone tell me where I can get a copy of "See MIPS Run"

Amazon.com should have it.

> 
> Thanks again for all the help
> 
> Mark
> 
> _________________________________________________________________
> Say good-bye to spam, viruses and pop-ups with MSN Premium -- free trial 
> offer! http://click.atdmt.com/AVE/go/onm00200359ave/direct/01/
-- 

Michael Uhler, Chief Technology Officer
MIPS Technologies, Inc.  Email: uhler@mips.com  Pager:uhler_p@mips.com
1225 Charleston Road     Voice:  (650)567-5025  FAX:   (650)567-5225
Mountain View, CA 94043  Mobile: (650)868-6870  Admin: (650)567-5085
