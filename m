Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Aug 2004 10:54:57 +0100 (BST)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:20748 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8224935AbUHCJyw>;
	Tue, 3 Aug 2004 10:54:52 +0100
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1BrwBn-00021m-00; Tue, 03 Aug 2004 11:06:35 +0100
Received: from kingsx.mips.com ([192.168.192.254] helo=mips.com)
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1Brvzx-0004NX-00; Tue, 03 Aug 2004 10:54:21 +0100
Message-ID: <410F60DF.9020400@mips.com>
Date: Tue, 03 Aug 2004 10:54:39 +0100
From: Nigel Stephens <nigel@mips.com>
Organization: MIPS Technologies
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Richard Sandiford <rsandifo@redhat.com>
CC: "Maciej W. Rozycki" <macro@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Richard Henderson <rth@redhat.com>, gcc-patches@gcc.gnu.org,
	linux-mips@linux-mips.org
Subject: Re: [patch] MIPS/gcc: Revert removal of DImode shifts for 32-bit
 targets
References: <Pine.LNX.4.55.0407191648451.3667@jurand.ds.pg.gda.pl>	<87hds49bmo.fsf@redhat.com>	<Pine.LNX.4.55.0407191907300.3667@jurand.ds.pg.gda.pl>	<20040719213801.GD14931@redhat.com>	<Pine.LNX.4.55.0407201505330.14824@jurand.ds.pg.gda.pl>	<20040723202703.GB30931@redhat.com>	<20040723211232.GB5138@linux-mips.org>	<Pine.LNX.4.58L.0407261325470.3873@blysk.ds.pg.gda.pl>	<410E9E25.7080104@mips.com> <87acxcbxfl.fsf@redhat.com>	<410F5964.3010109@mips.com> <876580bm2e.fsf@redhat.com>
In-Reply-To: <876580bm2e.fsf@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam, SpamAssassin (score=-4.855, required 4, AWL,
	BAYES_00)
Return-Path: <nigel@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5584
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nigel@mips.com
Precedence: bulk
X-list: linux-mips



Richard Sandiford wrote:

>I think we should only use define_expands if there's a truly
>MIPS-specific feature in the expansion (as there is in the block
>move stuff, for example, where we use left/right loads and stores).
>
>  
>

Fair enough.

>Now obviously I'm only guessing what insn sequence you're using,
>  
>

OK, the simplest thing is for me to attach the define_insns. See below.

Note that there is one slightly controversial aspect of these sequences, 
which is that they don't truncate the shift count, so a shift outside of 
the range 0 to 63 will generate an "unusual" result.  This didn't cause 
any regression failures, and I believe that this is strictly speaking 
acceptable for C, since a shift is undefined outside of this range - but 
it could cause some "buggy" code to break. It wouldn't be hard to add an 
extra mask with 0x3f if people were nervous about this - it's just that 
I didn't have enough spare temp registers within the constraints of the 
existing DImode patterns.

---- cut here ---

;; XXX Would be better done using define_expand, so it can be scheduled
;; XXX Note won't handle a shift count outside the range 0 - 63
(define_insn "ashldi3_internal_movc"
  [(set (match_operand:DI 0 "register_operand" "=&d")
    (ashift:DI (match_operand:DI 1 "register_operand" "d")
           (match_operand:SI 2 "register_operand" "d")))
   (clobber (match_operand:SI 3 "register_operand" "=&d"))]
  "!TARGET_64BIT && !TARGET_DEBUG_G_MODE && !TARGET_MIPS16
   && ISA_HAS_CONDMOVE"
  "subu\t%3,%.,%2\;\
sll\t%M0,%M1,%2\;\
srl\t%3,%L1,%3\;\
sll\t%L0,%L1,%2\;\
movz\t%3,%.,%2\;\
or\t%M0,%M0,%3\;\
and\t%3,%2,32\;\
movn\t%M0,%L0,%3\;\
movn\t%L0,%.,%3"
  [(set_attr "type"    "darith")
   (set_attr "mode"    "DI")
   (set_attr "length"    "36")])

;; Same length as before, but avoids branches
;; XXX Note won't handle a shift count outside the range 0 - 63
(define_insn "ashrdi3_internal_movc"
  [(set (match_operand:DI 0 "register_operand" "=&d")
    (ashiftrt:DI (match_operand:DI 1 "register_operand" "d")
             (match_operand:SI 2 "register_operand" "d")))
   (clobber (match_operand:SI 3 "register_operand" "=&d"))]
  "!TARGET_64BIT && !TARGET_DEBUG_G_MODE && !TARGET_MIPS16
   && ISA_HAS_CONDMOVE"
  "subu\t%3,%.,%2\;\
srl\t%L0,%L1,%2\;\
sll\t%3,%M1,%3\;\
sra\t%M0,%M1,%2\;\
movz\t%3,%.,%2\;\
or\t%L0,%L0,%3\;\
and\t%3,%2,32\;\
movn\t%L0,%M0,%3\;\
movn\t%M0,%.,%3\;\
movn\t%3,%L0,%3\;\
sra\t%3,%3,31\;\
or\t%M0,%M0,%3"
  [(set_attr "type"    "darith")
   (set_attr "mode"    "DI")
   (set_attr "length"    "48")])

;;; XXX Note won't handle a shift count outside the range 0 - 63
(define_insn "lshrdi3_internal_movc"
  [(set (match_operand:DI 0 "register_operand" "=&d")
    (lshiftrt:DI (match_operand:DI 1 "register_operand" "d")
             (match_operand:SI 2 "register_operand" "d")))
   (clobber (match_operand:SI 3 "register_operand" "=&d"))]
  "!TARGET_64BIT && !TARGET_DEBUG_G_MODE && !TARGET_MIPS16
   && ISA_HAS_CONDMOVE"
  "subu\t%3,%.,%2\;\
srl\t%L0,%L1,%2\;\
sll\t%3,%M1,%3\;\
srl\t%M0,%M1,%2\;\
movz\t%3,%.,%2\;\
or\t%L0,%L0,%3\;\
and\t%3,%2,32\;\
movn\t%L0,%M0,%3\;\
movn\t%M0,%.,%3"
  [(set_attr "type"    "darith")
   (set_attr "mode"    "DI")
   (set_attr "length"    "36")])
