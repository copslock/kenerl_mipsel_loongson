Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Mar 2004 16:05:50 +0000 (GMT)
Received: from webmail-outgoing.us4.outblaze.com ([IPv6:::ffff:205.158.62.67]:26005
	"EHLO webmail-outgoing.us4.outblaze.com") by linux-mips.org
	with ESMTP id <S8225597AbUCLQFs>; Fri, 12 Mar 2004 16:05:48 +0000
Received: from wfilter.us4.outblaze.com (wfilter.us4.outblaze.com [205.158.62.180])
	by webmail-outgoing.us4.outblaze.com (Postfix) with QMQP id 2A83E180327C
	for <linux-mips@linux-mips.org>; Fri, 12 Mar 2004 16:05:40 +0000 (GMT)
X-OB-Received: from unknown (205.158.62.74)
  by wfilter.us4.outblaze.com; 12 Mar 2004 16:05:15 -0000
Received: by ws5-8.us4.outblaze.com (Postfix, from userid 1001)
	id AA2F13AA466; Fri, 12 Mar 2004 16:05:35 +0000 (GMT)
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
Received: from [202.54.13.34] by ws5-8.us4.outblaze.com with http for
    xavier_prabhu@linuxmail.org; Sat, 13 Mar 2004 00:05:35 +0800
From: "xavier prabhu" <xavier_prabhu@linuxmail.org>
To: slaz@fortresstech.com
Cc: linux-mips@linux-mips.org
Date: Sat, 13 Mar 2004 00:05:35 +0800
Subject: Re: Linux Boot Issue in Au1550
X-Originating-Ip: 202.54.13.34
X-Originating-Server: ws5-8.us4.outblaze.com
Message-Id: <20040312160535.AA2F13AA466@ws5-8.us4.outblaze.com>
Return-Path: <xavier_prabhu@linuxmail.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4532
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: xavier_prabhu@linuxmail.org
Precedence: bulk
X-list: linux-mips

Hi Steve,

Thanks for your reply. 
But, my code already has this modification.

Regards,
Xavier.

----- Original Message -----
From: Steve Lazaridis <slaz@fortresstech.com>
Date: 	Fri, 12 Mar 2004 10:25:00 -0500
To: xavier prabhu <xavier_prabhu@linuxmail.org>
Subject: Re: Linux Boot Issue in Au1550

> On Thu, 2004-03-11 at 23:10, xavier prabhu wrote:
> > Hi all,
> > 
> > I had built the kernel(2.2.24) for Alchemy pb1550 evaluation board using mvista previewkit little endian toolchain and binutils-2.14.90.
> > I can able to flash the srec image(YAMON:tftp). I get following problem while booting the image.
> > Please suggest me what could be the issue.
> > 
> > YAMON> load -r tftp://10.145.2.248/cramfsimage.srec
> > About to load tftp://10.145.2.248/cramfsimage.srec
> > Press Ctrl-C to break
> > ........................................
> > ........................................
> > ........................................
> > ........................................
> > ........................................
> > ........................................
> > ........................................
> > ........................................
> > ........................................
> > ........................................
> > ........................................
> > ........................................
> > ........................................
> > ..........
> > Start = 0xbf100000, range = (0xbf100000,0xbf521fff), format = SREC
> > YAMON> load -r tftp://10.145.2.248/zImage.srec
> > About to load tftp://10.145.2.248/zImage.srec
> > Press Ctrl-C to break
> > ........................................
> > ........................................
> > ......................
> > Start = 0xbf000000, range = (0xbf000000,0xbf0cbfff), format = SREC
> > YAMON> go 0xbf000000
> > loaded at:     BF000000 BF0CC000
> > relocated to:  81000000 810CC000
> > zimage at:     81006540 810CB74F
> > Uncompressing Linux at load address 80100000
> > Now booting the kernel
> > 
> > * Exception (user) : TLB (load or instruction fetch) *
> > 
> > CAUSE    = 0x00808008  STATUS   = 0x00000002
> > EPC      = 0x00000000  ERROREPC = 0x80003004
> > BADVADDR = 0x00000000
> > 
> > $ 0(zr):0x00000000  $ 8(t0):0x000025bd  $16(s0):0x00000001  $24(t8):0x80400058
> > $ 1(at):0x81000000  $ 9(t1):0x00000000  $17(s1):0x80083350  $25(t9):0x810cf020
> > $ 2(v0):0xb1100004  $10(t2):0x00000002  $18(s2):0x800442d8  $26(k0):0x00000000
> > $ 3(v1):0xb110001c  $11(t3):0x0000027f  $19(s3):0x08000000  $27(k1):0x00000000
> > $ 4(a0):0x00000001  $12(t4):0x80401058  $20(s4):0x00000000  $28(gp):0x00000000
> > $ 5(a1):0x80083350  $13(t5):0x810cb745  $21(s5):0x00000000  $29(sp):0x810cf0a0
> > $ 6(a2):0x800442d8  $14(t6):0x000025bd  $22(s6):0x00000000  $30(s8):0xbf000000
> > $ 7(a3):0x08000000  $15(t7):0x0000000a  $23(s7):0x00000000  $31(ra):0x810000dc
> > 
> > YAMON>
> > 
> > Thanks in advance,
> > 
> > Regards,
> > Xavier.
> 
> This might help...
> 
> We had a similar problem with our AU1000 boards.  We changed the
> arch/mips/Makefile  the 
> ifdef CONFIG_CPU_MIPS32
> GCCFLAGS  += $(call set_gccflags,mips32,mips32,r4600,mips2,mips2) \
>            -Wa,--trap
> endif
> 
> So, the mips2, mips2 at the end, used to be "mips3, mips2" and that
> causes the compiler to generate invalid code for the AU1000, and most
> likely, it's doing the same for you.
> 
> 
> cheers,
> 
> -- 
> Steve Lazaridis
> Software Engineer
> Fortress Technologies
> slaz@fortresstech.com | Ph:813.288.7388 x115
> 
> 

-- 
______________________________________________
Check out the latest SMS services @ http://www.linuxmail.org 
This allows you to send and receive SMS through your mailbox.


Powered by Outblaze
