Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Feb 2018 01:14:28 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:49193 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990864AbeBEAORirAJt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Feb 2018 01:14:17 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx28.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Mon, 05 Feb 2018 00:14:08 +0000
Received: from [10.20.78.156] (10.20.78.156) by mips01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server id 14.3.361.1; Sun, 4 Feb 2018
 16:13:11 -0800
Date:   Mon, 5 Feb 2018 00:13:02 +0000
From:   "Maciej W. Rozycki" <macro@mips.com>
To:     Greg Ungerer <gerg@linux-m68k.org>
CC:     James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        "Ralf Baechle" <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: CPS: Fix r1 .set mt assembler warning
In-Reply-To: <8e34deb4-33c3-9bdb-8ffb-b93516f16a84@linux-m68k.org>
Message-ID: <alpine.DEB.2.00.1802050003250.3553@tp.orcam.me.uk>
References: <079ec8f9-d2c2-9e29-278e-48e76bbb8de7@linux-m68k.org> <20180202120658.GA8479@saruman> <8e34deb4-33c3-9bdb-8ffb-b93516f16a84@linux-m68k.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-BESS-ID: 1517789647-637138-17934-136510-4
X-BESS-VER: 2018.1-r1801291959
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.189683
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.50 BSF_RULE7568M          META: Custom Rule 7568M 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Maciej.Rozycki@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62437
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@mips.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Sun, 4 Feb 2018, Greg Ungerer wrote:

> A "mips-linux-objdump -d" around that PC gives:
> 
> 80656610:       40090001        mfc0    t1,c0_mvpcontrol
> 80656614:       35290002        ori     t1,t1,0x2
> 80656618:       40890001        mtc0    t1,c0_mvpcontrol
> 8065661c:       000000c0        ehb
> 80656620:       01c0c02d        0x1c0c02d
> 80656624:       240d0000        li      t5,0
> 80656628:       31c80001        andi    t0,t6,0x1
> 8065662c:       1100002b        beqz    t0,806566dc <mips_cps_boot_vpes+0x108>
> 80656630:       00000000        nop
> 
> So it can't decode that "01c0c02d"...

 Well, `objdump -mmips:isa64r2 -d' reveals this:

80000000:	01c0c02d 	move	t8,t6

and then `objdump -mmips:isa64r2 -M no-aliases -d' further shows this:

80000000:	01c0c02d 	daddu	t8,t6,zero

which is a 64-bit instruction, so clearly the temporary `.set' override 
spans too much (we have updated GAS recently to emit machine code for OR 
rather than ADDU/DADDU as the expansion for the MOVE assembly idiom to 
minimise impact from such issues though; ADDU/DADDU would schedule better 
with old superscalar MIPS processors, but that is not an issue with the 
modern ones, I'm told).

 HTH,

  Maciej
