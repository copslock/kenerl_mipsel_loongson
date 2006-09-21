Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Sep 2006 17:59:26 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:40575 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20038522AbWIUQ7X (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 21 Sep 2006 17:59:23 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 8083C3ED9; Thu, 21 Sep 2006 09:59:00 -0700 (PDT)
Message-ID: <4512C55A.6070206@ru.mvista.com>
Date:	Thu, 21 Sep 2006 21:01:14 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/3] fixed mtc0_tlbw_hazard
References: <20060922010713.657f2861.yoichi_yuasa@tripeaks.co.jp>	<4512BC2A.6040003@dev.rtsoft.ru> <20060922014142.2a1985c1.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20060922014142.2a1985c1.yoichi_yuasa@tripeaks.co.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12623
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Yoichi Yuasa wrote:

>>>Some mtc0_tlbw_hazard() were broken by "[MIPS] Cleanup hazard handling" patch.
>>>Please apply this patch.

>>>tlb-r4k.o disassemble:

>>>8009018c <local_flush_tlb_all>:
>>>8009018c:       40066000        mfc0    a2,$12
>>>80090190:       34c1001f        ori     at,a2,0x1f
>>>80090194:       3821001f        xori    at,at,0x1f
>>>80090198:       40816000        mtc0    at,$12
>>>8009019c:       00000040        ssnop
>>>800901a0:       00000040        ssnop
>>>800901a4:       00000040        ssnop

>>    Hm, why there are ssnop's here...

> ssnop is a part of dvpe().

    Yep, this is irq_disable_hazard, looking sane.

>>>800901a8:       40075000        mfc0    a3,$10
>>>800901ac:       40801000        mtc0    zero,$2
>>>800901b0:       40801800        mtc0    zero,$3
>>>800901b4:       40043000        mfc0    a0,$6
>>>800901b8:       3c028035        lui     v0,0x8035
>>>800901bc:       8c457ac0        lw      a1,31424(v0)
>>>800901c0:       0085182a        slt     v1,a0,a1
>>>800901c4:       1060000b        beqz    v1,800901f4 <local_flush_tlb_all+0x68>
>>>800901c8:       00044340        sll     t0,a0,0xd
>>>800901cc:       3c098000        lui     t1,0x8000
>>>800901d0:       01091821        addu    v1,t0,t1
>>>800901d4:       40835000        mtc0    v1,$10
>>>800901d8:       10000002        b       800901e4 <local_flush_tlb_all+0x58> <-- mtc0_tlbw_hazard()
>>>800901dc:       40840000        mtc0    a0,$0
>>>800901e0:       42000002        tlbwi

>>>Yoichi

>>>Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
>>>
>>>diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/hazards.h mips/include/asm-mips/hazards.h
>>>--- mips-orig/include/asm-mips/hazards.h	2006-09-21 18:21:11.793973750 +0900
>>>+++ mips/include/asm-mips/hazards.h	2006-09-21 18:55:07.569201750 +0900
>>>@@ -138,7 +138,7 @@ ASMMACRO(back_to_back_c0_hazard,

    This is under #elif defined(CONFIG_CPU_SB1), right?

>>>  * Mostly like R4000 for historic reasons
>>>  */
>>> ASMMACRO(mtc0_tlbw_hazard,
>>>-	 b	. + 8
>>>+	 nop; nop; nop; nop; nop; nop

>>    ... and nop's there? This looks inconsistent.

> previous mtc0_tlbw_hazard() for C used nop.
> "b . + 8" is trick for R4000/R4400, see comment in old hazard.h .

    I fail to see what was changed WRT SB1 CPUs by the suspected patch. Though 
wait... the previous version was inconsistent, using the different barrier 
definitions for C and assembly (nops in the former, and branch in the latter). 
But since the assembly version was not really used, it couldn't break 
anything... :-/

    Anyway, shouldn't ssnop's be used for SB1 instead? CPU has quad-issue 
pipeline, hasn't it?

> Yoichi

WBR, Sergei
