Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jan 2008 16:03:54 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:53440 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28574376AbYAPQDw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 16 Jan 2008 16:03:52 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m0GG3qma009844;
	Wed, 16 Jan 2008 16:03:52 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m0GG3p8i009843;
	Wed, 16 Jan 2008 16:03:51 GMT
Date:	Wed, 16 Jan 2008 16:03:51 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: Tester with IP27/IP30 needed
Message-ID: <20080116160351.GA9664@linux-mips.org>
References: <20080115112420.GA7347@alpha.franken.de> <20080115131145.GA5189@linux-mips.org> <20080115135300.GB5189@linux-mips.org> <20080115181812.GA14816@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080115181812.GA14816@linux-mips.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18080
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 15, 2008 at 06:18:12PM +0000, Ralf Baechle wrote:

So I sent an NMI to the IP27 and used the POD to extract as much information
as I could.  Below the disassembly of the code.  The addresses are looking
a little odd because I had to disassembly at the XKPHYS address even though
the code was actually executing in userspace.

1B 000: 0xa80000007bd5f008:       8c658b98        lw      a1,0x8b98(v1)
1B 000: 0xa80000007bd5f00c:       24060001        li      a2,0x1
1B 000: 0xa80000007bd5f010:       34a50001        ori     a1,a1,0x1
1B 000: 0xa80000007bd5f014:       00003821        move    a3,zero
1B 000: 0xa80000007bd5f018:       2402108e        li      v0,0x108e
1B 000: 0xa80000007bd5f01c:       0000000c        syscall
1B 000: 0xa80000007bd5f020:       1000ffd3        b       0xa80000007bd5ef70
1B 000: 0xa80000007bd5f024:       00000000        nop
1B 000: 0xa80000007bd5f028:       3c1c0010        lui     gp,0x10
1B 000: 0xa80000007bd5f02c:       279ce938        addiu   gp,gp,0xffffffe938
1B 000: 0xa80000007bd5f030:       0399e021        addu    gp,gp,t9
1B 000: 0xa80000007bd5f034:       27bdffd8        addiu   sp,sp,0xffffffffd8
1B 000: 0xa80000007bd5f038:       afbf0020        sw      ra,0x20(sp)
1B 000: 0xa80000007bd5f03c:       afb1001c        sw      s1,0x1c(sp)
1B 000: 0xa80000007bd5f040:       afb00018        sw      s0,0x18(sp)
1B 000: 0xa80000007bd5f044:       afbc0010        sw      gp,0x10(sp)
1B 000: 0xa80000007bd5f048:       7c03e83b        op1f    v1,zero,0xfffffffff
1B 000: fffe83b
1B 000: 0xa80000007bd5f04c:       8f848018        lw      a0,0x8018(gp)

EPC is pointing to this lw so the subsequent instruction from the op1f which
is rdhwr $29. ErrorEPC is pointing further down so it seems we must have
returned from the emulation.

1B 000: 0xa80000007bd5f050:       24718b90        addiu   s1,v1,0xffffff8b90
1B 000: 0xa80000007bd5f054:       24901710        addiu   s0,a0,0x1710
1B 000: 0xa80000007bd5f058:       8e020008        lw      v0,0x8(s0)
1B 000: 0xa80000007bd5f05c:       00000000        nop
1B 000: 0xa80000007bd5f060:       1051000d        beq     v0,s1,0xa8000000f098
1B 000: 0xa80000007bd5f064:       00001821        move    v1,zero
1B 000: 0xa80000007bd5f068:       24020001        li      v0,0x1
1B 000: 0xa80000007bd5f06c:       c0851710        ll      a1,0x1710(a0)
1B 000: 0xa80000007bd5f070:       14a30006        bne     a1,v1,0xa8000000f08c
1B 000: 0xa80000007bd5f074:       00003021        move    a2,zero
1B 000: 0xa80000007bd5f078:       00403021        move    a2,v0
1B 000: 0xa80000007bd5f07c:       e0861710        sc      a2,0x1710(a0)
1B 000: 0xa80000007bd5f080:       10c0fffa        beq     a2,zero,0xa800d5f06c

And this is where the ErrorEPC is pointing.

1B 000: 0xa80000007bd5f084:       00000000        nop
1B 000: 0xa80000007bd5f088:       0000000f        sync
1B 000: 0xa80000007bd5f08c:       10c0000a        beq     a2,zero,0xa800d5f0b8
1B 000: 0xa80000007bd5f090:       00000000        nop

  Ralf
