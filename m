Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Feb 2004 17:14:05 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:11937 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225340AbUBWROC>; Mon, 23 Feb 2004 17:14:02 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 7B84047829; Mon, 23 Feb 2004 18:13:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 67C2C42C; Mon, 23 Feb 2004 18:13:59 +0100 (CET)
Date:	Mon, 23 Feb 2004 18:13:59 +0100 (CET)
From:	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:	Mark and Janice Juszczec <juszczec@hotmail.com>
Cc:	linux-mips@linux-mips.org, uhler@mips.com, kevink@mips.com,
	dom@mips.com, echristo@redhat.com
Subject: RE:  r3000 instruction set
In-Reply-To: <Law10-F123ODt9Cz93M0000b89a@hotmail.com>
Message-ID: <Pine.LNX.4.55.0402231802400.1245@jurand.ds.pg.gda.pl>
References: <Law10-F123ODt9Cz93M0000b89a@hotmail.com>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4411
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Mon, 23 Feb 2004, Mark and Janice Juszczec wrote:

> Someone suggested posting the message I get.  Here it is:
> 
> >./kaffe-bin FirstClass
> [kaffe-bin:6] Illgal instruction 674696a at 2abb034, ra=2adbffd0, 
> P0_STATUS=0000500
> pid 6: killed (signal 4)
> >Reading command line: Try again
> Kernel panic: Attmpted to kill int!
> 
> Someone else suggested dumping all the assembler instructions.  The listing 
> is really long, so I made a unique list of the commands themselves.  If 
> someone can tell me how to use the above error message to figure out the 
> command causing the problem, I'd really appreciate it.  If that's 

 The causing instructions is 674696a -- depending on the endianness, it's 
either:

6a697406	ldl	t1,29702(s3)

which requires at least MIPS III or:

0674696a	0x674696a

which is completely invalid.

 There are a few ways to track the reason down:

1. Figure out which binary or shared library 0x2abb034 belongs to and 
disassemble the surrounding code.

2. Enable core dumps, run the failing program and do a post-mortem 
analysis of the resulting dump with gdb.

3. Run the failing program under gdb and see where SIGILL happens.

4. Perhaps others.

> impossible, can someone tell me which command listed below does not belong?
> 
> /opt/crosstool/mipsel-unknown-linux-gnu/gcc-3.2.3-glibc-2.2.3/bin/mipsel-unknown-linux-gnu-objdump 
> -d kaffe-bin | awk '{print $3}' | sort -u

 You really want "-S" instead of "-d" (there's usually no point to 
disassemble data) and add "-m mips:isa64" or a similar, suitably high ISA 
selector (depending on binutils version), so that you get a disassembly of 
all instructions as opposed to those defined by the MIPS I ISA only.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
