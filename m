Received:  by oss.sgi.com id <S305159AbQBPTGX>;
	Wed, 16 Feb 2000 11:06:23 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:58902 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305156AbQBPTFz>; Wed, 16 Feb 2000 11:05:55 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id LAA03771; Wed, 16 Feb 2000 11:08:48 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA02054
	for linux-list;
	Wed, 16 Feb 2000 10:51:15 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from liveoak.engr.sgi.com (liveoak.engr.sgi.com [163.154.5.24])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA25988;
	Wed, 16 Feb 2000 10:50:54 -0800 (PST)
	mail_from (wje@liveoak.engr.sgi.com)
Received: (from wje@localhost)
	by liveoak.engr.sgi.com (8.9.3/8.8.7) id KAA16521;
	Wed, 16 Feb 2000 10:50:47 -0800
X-Authentication-Warning: liveoak.engr.sgi.com: wje set sender to wje@liveoak.engr.sgi.com using -f
From:   "William J. Earl" <wje@cthulhu.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14506.61831.733915.236157@liveoak.engr.sgi.com>
Date:   Wed, 16 Feb 2000 10:50:47 -0800 (PST)
To:     "Kevin D. Kissell" <kevink@mips.com>
Cc:     "Ralf Baechle" <ralf@oss.sgi.com>,
        "Geert Uytterhoeven" <Geert.Uytterhoeven@sonycom.com>,
        <linux@cthulhu.engr.sgi.com>, <linux-mips@fnet.fr>,
        <linux-mips@vger.rutgers.edu>
Subject: Re: Indy crashes
In-Reply-To: <003101bf786a$8c44d150$0ceca8c0@satanas.mips.com>
References: <003101bf786a$8c44d150$0ceca8c0@satanas.mips.com>
X-Mailer: VM 6.74 under Emacs 20.3.1
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Kevin D. Kissell writes:
 > Ralf Baechle writes:
 > >On Tue, Feb 15, 2000 at 11:23:49PM +0100, Kevin D. Kissell wrote:
...
 > >No, it's not a bug workaround.  The reason for this branch is that the
 > >R4000 and R4400 have a penalty of three cycles for a taken branch.  So
 > >the branch above is equivalent with 
 > >
 > > mtc0 k1, CP0_ENTRYLO1
 > > nop
 > > tlbwr
 > > nop
 > > nop
 > > nop
 > > eret
 > >
 > >Funky trick, isn't it?  I don't have the the R4600 / R5000 docs at hand
 > >but as I understood them the above code should also work just perfect
 > >for them.
 > 
 > No.  Not as I read the specs.  There are three problems here.
 > 
 > First, the question is *not* one of no-ops between the TLBWR
 > and the ERET, but of no-ops between the MTC0 and the
 > TLBWR - re-read the quoted text above from my previous
 > message.  So the code may well be broken as I conjectured
 > even if your assumption about the branch delay was valid.

      Empirically, this does not appear to be the case.  Here are 
the handlers for the r4600 and r5000 on IRIX, which have been stable
for years:

eutlbmiss3_250mhz:
[1023] 0x880849b0:  40 1a 20 00       mfc0	k0,context
[1023] 0x880849b4:  00 1a d0 43       sra	k0,k0,1
utlbmiss_r4600:
[1031] 0x880849b8:  8f 5b 00 00       lw	k1,0(k0)
[1031] 0x880849bc:  8f 5a 00 04       lw	k0,4(k0)
[1032] 0x880849c0:  00 1b d9 80       sll	k1,k1,6
[1032] 0x880849c4:  00 1b d9 82       srl	k1,k1,6
[1033] 0x880849c8:  40 9b 10 00       mtc0	k1,tlblo
[1034] 0x880849cc:  00 1a d1 80       sll	k0,k0,6
[1034] 0x880849d0:  00 1a d1 82       srl	k0,k0,6
[1035] 0x880849d4:  40 9a 18 00       mtc0	k0,tlblo1
[1036] 0x880849d8:  00 00 00 00       nop
[1037] 0x880849dc:  42 00 00 06       c0	tlbwr
[1038] 0x880849e0:  00 00 00 00       nop
utlbmiss_eret_3:
[1039] 0x880849e4:  0a 01 c9 59       j		_r4600_2_0_cacheop_eret
[1039] 0x880849e8:  00 00 00 00       nop

_r4600_2_0_cacheop_eret:
[ 211] 0x88072564:  00 00 00 00       nop
[ 211] 0x88072568:  00 00 00 00       nop
[ 211] 0x8807256c:  00 00 00 00       nop
[ 211] 0x88072570:  00 00 00 00       nop
[ 211] 0x88072574:  00 00 00 00       nop
[ 211] 0x88072578:  00 00 00 00       nop
[ 211] 0x8807257c:  00 00 00 00       nop
[ 211] 0x88072580:  00 00 00 00       nop
_r4600_2_0_cacheop_eret_inst:
[ 211] 0x88072584:  42 00 00 18       c0	eret

eutlbmiss3_250mhz:
[1023] 0x880849b0:  40 1a 20 00       mfc0	k0,context
[1023] 0x880849b4:  00 1a d0 43       sra	k0,k0,1
utlbmiss_r5000:
[1061] 0x8007ede8:  8f 5b 00 00       lw	k1,0(k0)
[1061] 0x8007edec:  8f 5a 00 04       lw	k0,4(k0)
[1062] 0x8007edf0:  42 00 00 08       c0	tlbp
[1063] 0x8007edf4:  00 1b d9 00       sll	k1,k1,4
[1063] 0x8007edf8:  00 1b d9 02       srl	k1,k1,4
[1064] 0x8007edfc:  40 9b 10 00       mtc0	k1,tlblo
[1065] 0x8007ee00:  40 1b 00 00       mfc0	k1,index
[1066] 0x8007ee04:  00 1a d1 00       sll	k0,k0,4
[1066] 0x8007ee08:  00 1a d1 02       srl	k0,k0,4
[1067] 0x8007ee0c:  07 61 00 04       bgez	k1,0x8007ee20
[1068] 0x8007ee10:  40 9a 18 00       mtc0	k0,tlblo1
[1069] 0x8007ee14:  42 00 00 06       c0	tlbwr
[1070] 0x8007ee18:  00 00 00 00       nop
[1071] 0x8007ee1c:  42 00 00 18       c0	eret

Note that, in the R4600 case, the "j _r4600_2_0_cacheop_eret" is
replaced with an eret on the R4600 Rev. 1.*.  (The code is patched
at system startup time.)  

     Also notice that IRIX does not index a segment table directly.
Instead, a second level TLB miss handler drops a mapping into a reserved
part of K2SEG for the PTE page required, where the base of that reserved
area is loaded into $context at startup time.

 > Second, the R5000 and R4600 piprlines are not as deep
 > as those of the R4000/4400.   The R5000 documentation
 > calls out a branch implementation with a *single* delay cycle.
 > I quote: "The one cycle branch delay is a result of the branch
 > comparison logic operating during the 1A pipeline stage of
 > the branch.  This allows the branch target address calculated
 > in the previous stage to be used for the instruction access in
 > the following 1I phase."   So even if the execution of the
 > branch were inserting delay between the MTC0 and the
 > TLBWR as you seemed to assume, it might not be inserting
 > as much delay as you think.

      As you can see from the above examples, the IRIX handlers
for these processors are indeed different.  The R4000 and R4400 
require more nops in other places:

utlbmiss_prolog_up:
[ 144] 0x88084600:  40 1a 20 00       mfc0	k0,context
[ 144] 0x88084604:  00 00 00 00       nop
[ 145] 0x88084608:  00 1a d0 43       sra	k0,k0,1
utlbmiss:
[ 219] 0x88084680:  8f 5b 00 00       lw	k1,0(k0)
[ 219] 0x88084684:  8f 5a 00 04       lw	k0,4(k0)
[ 223] 0x88084688:  00 1b d9 80       sll	k1,k1,6
[ 223] 0x8808468c:  00 1b d9 82       srl	k1,k1,6
[ 224] 0x88084690:  40 9b 10 00       mtc0	k1,tlblo
[ 225] 0x88084694:  00 1a d1 80       sll	k0,k0,6
[ 225] 0x88084698:  00 1a d1 82       srl	k0,k0,6
[ 236] 0x8808469c:  40 9a 18 00       mtc0	k0,tlblo1
[ 237] 0x880846a0:  00 00 00 00       nop
[ 238] 0x880846a4:  42 00 00 06       c0	tlbwr
[ 239] 0x880846a8:  00 00 00 00       nop
[ 239] 0x880846ac:  00 00 00 00       nop
[ 239] 0x880846b0:  00 00 00 00       nop
[ 246] 0x880846b4:  42 00 00 18       c0	eret

Notice that the R4000 requires a nop after the mfc0 from $context,
and also requires extra nops after the tlbwr.

     Also, here is the utlbmiss for the 250 MHZ R4400, with another
workaround:

utlbmiss_prolog_up:
[ 144] 0x88084600:  40 1a 20 00       mfc0	k0,context
[ 144] 0x88084604:  00 00 00 00       nop
[ 145] 0x88084608:  00 1a d0 43       sra	k0,k0,1
eutlbmiss3:
[ 805] 0x88084830:  8f 5b 00 00       lw	k1,0(k0)
[ 805] 0x88084834:  8f 5a 00 04       lw	k0,4(k0)
[ 809] 0x88084838:  00 1b d9 80       sll	k1,k1,6
[ 809] 0x8808483c:  00 1b d9 82       srl	k1,k1,6
[ 810] 0x88084840:  40 80 10 00       mtc0	zero,tlblo
[ 811] 0x88084844:  40 9b 10 00       mtc0	k1,tlblo
[ 812] 0x88084848:  00 1a d1 80       sll	k0,k0,6
[ 812] 0x8808484c:  00 1a d1 82       srl	k0,k0,6
[ 824] 0x88084850:  40 80 18 00       mtc0	zero,tlblo1
[ 825] 0x88084854:  40 9a 18 00       mtc0	k0,tlblo1
[ 826] 0x88084858:  00 00 00 00       nop
[ 827] 0x8808485c:  42 00 00 06       c0	tlbwr
[ 828] 0x88084860:  00 00 00 00       nop
[ 828] 0x88084864:  00 00 00 00       nop
[ 828] 0x88084868:  00 00 00 00       nop
[ 829] 0x8808486c:  42 00 00 18       c0	eret

    Emprirically, it appears that the manual is incorrect in regard
to the number of nop instructions.  The above sequences are known
to work (via years of testing, and also via validation in discussions
with people familiar with the hardware pipelines).
        
 > Thirdly, this whole thread underscores why "clever" solutions that 
 > depend on implementation features of particular CPUs should 
 > be avoided whenever possible. If you want to be assured of
 > getting a delay cycle in a MIPS instruction stream, you should
 > use a "SSNOP", (sll r0,r0,1 as opposed to the "nop" sll r0,r0,0),
 > which forces delays even in superscalar implementations.

      This is not realistic, given the number of workarounds required
for various processors, unless you are willing to have most processors
run quite a bit slower.  (Extra cycles in utlbmiss are noticeable.)
