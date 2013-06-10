Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jun 2013 09:18:10 +0200 (CEST)
Received: from mail-wi0-f179.google.com ([209.85.212.179]:36309 "EHLO
        mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817177Ab3FJHSJdOBgX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Jun 2013 09:18:09 +0200
Received: by mail-wi0-f179.google.com with SMTP id hj3so409552wib.0
        for <linux-mips@linux-mips.org>; Mon, 10 Jun 2013 00:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=JaXHuCrVHNuU0HA6gQNTuFdpdD/P1IhDI6xXt+7Gt50=;
        b=JbVTc96LZ//6MUa9XJ0T1EkI1vT9VXRoCLSZxUA8KnuVUKAhO827RSNYuaVOwVlJha
         TKNjyjNJol7VgQyQ/3P4E/1JxODW/G9S1M3+NpdSd06y8ozYyCKz6s4qwiSBddMBwJXr
         Elh4xvP0oyEr8Ay73tPbHEqNFZasLUYQEX7/VIjZKEPMG7itsjYFi5IUxSOnPhgfs4JL
         tEyg3fJee4e/Y6dnrS+AZP9dNd75NoycQJK62uiahQDSy0Ka9w1ZobkhqaWJLon03gAG
         i1JuiIZDwt3lLQ5YA/WoHO5mrxD1SOW0Zvtb0t/Ng1m32QT06mrbRDFojNmoZaY8kqmr
         xgkw==
X-Received: by 10.194.103.73 with SMTP id fu9mr4744614wjb.70.1370848683196;
        Mon, 10 Jun 2013 00:18:03 -0700 (PDT)
Received: from [172.16.40.101] (134.117.39.62.rev.sfr.net. [62.39.117.134])
        by mx.google.com with ESMTPSA id h8sm9307501wiz.9.2013.06.10.00.18.01
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 10 Jun 2013 00:18:02 -0700 (PDT)
Message-ID: <51B57DA8.1010206@wyplay.com>
Date:   Mon, 10 Jun 2013 09:18:00 +0200
From:   Alexis BRENON <abrenon@wyplay.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     linux-mips@linux-mips.org
Subject: Re: Immediate branch offset
References: <51B1B739.7080104@wyplay.com> <alpine.LFD.2.03.1306082206540.18329@linux-mips.org>
In-Reply-To: <alpine.LFD.2.03.1306082206540.18329@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Gm-Message-State: ALoCoQki3c5rxR14YnOYyZpWnqCJ3HK6Lh3lDdINYquzjhlkz0f82xp7/Pw8zGOH5tykWuK/25w4
Return-Path: <abrenon@wyplay.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36763
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrenon@wyplay.com
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

Le 09/06/2013 16:43, Maciej W. Rozycki a écrit :
> On Fri, 7 Jun 2013, Alexis BRENON wrote:
>
>> To create the JIT, I have to load some MIPS instruction directly in memory
>> without passing through a .asm file or else. So, I cannot set some labels. So
>> to make some branches, I try to load the equivalent instruction of :
>>      bne $t0, $t1, -8
>> to go back, just before the bne instruction, if $t0 and $t1 are equals. But
>> when it run, I've got an illegal instruction error.
>   Please note that BNE means Branch-if-Not-Equal, your quoted instruction
> will jump backwards if $t0 and $t1 are *not* equal.
>

Yes, sorry, it's just a typing mistake, since I tried with all branch 
instructions.

>> To debug, I write a small program in the MARS MIPS simulator with this
>> instruction. But when compiling, assembler says me that -8 is an operand of
>> incorrect type.
>   The instruction you quoted assembles for me successfully, what version of
> binutils do you use and what exact error message do you get?

I didn't try to assemble it, but only to run it in the MARS simulator. 
If I assemble it with GNU AS, it assembles successfully.

>   Please note however that this instruction is not what I understand you
> need -- it is treated as a branch to the absolute address -8 (0xfffffff8
> in the o32 ABI), rather than 8 bytes back (there's an off-by-four bug in
> GAS here too making it jump to -4 instead, and some other issues; I'll see
> if I can get them fixed sometime -- see the discussion around
> http://sourceware.org/ml/binutils/2012-09/msg00288.html if interested in
> the gory details).
>
>   If you want to jump to the instruction immediately preceding the branch
> and avoid a label (assuming the standard MIPS ISA), use:
>
> 	bne	$t0, $t1, . - 4
>
> -- "." is a special "the address of this instruction" designator (see the
> GAS manual for further information), so this produces the machine
> instruction you require (the jump is calculated as relative to the next
> instruction -- that is (. + 4) -- so the ultimate effective (i.e. shifted
> rather than as encoded in the instruction's 16-bit immediate operand
> field) offset is -8).
>
> $ cat foo.s
> 	bne	$t0, $t1, . - 4
> $ mips-linux-as -o foo.o foo.s
> $ mips-linux-objdump -dr foo.o
>
> foo.o:     file format elf32-tradbigmips
>
>
> Disassembly of section .text:
>
> 00000000 <.text>:
>     0:	1509fffe 	bne	t0,t1,0xfffffffc
>     4:	00000000 	nop
> 	...
> $ mips-linux-as --version
> GNU assembler (GNU Binutils) 2.23.2
> [...]
>
> Likewise with the current binutils trunk.
>
>   I hope this helps.
>
>    Maciej

I downloaded MIPS32 Architecture For Programmers Volume II: The MIPS32 
Instruction Set. If you read the BNE-BEQ-B... description it says :

     Purpose:
To compare GPRs then do a PC-relative conditional branch

	Description: if rs = rt then branch
An 18-bit signed offset (the 16-bit offset field shifted left 2 bits) is added to the address of the instruction
following the branch (not the branch itself), in the branch delay slot, to form a PC-relative effective target
address.

It says that it's a PC-relative jump, the offset is added to the PC 
value, and not a absolute jump as the J instruction. Nevertheless, I try 
to type this :

loop:
         addiu $v0, $v0, 1
         bne $v0, $t1, .-4


or this :

loop:
         addiu $v0, $v0, 1
         bne $v0, $t1, -8

In both cases, the objdump command says me :

    8:   24420001        addiu   v0,v0,1
    c:   1449fffe        bne     v0,t1,8 <loop>
   10:   00000000        nop

It seems to be equivalent.

Thanks for your answer.
Friendly,
Alexis BRENON
