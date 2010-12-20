Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Dec 2010 11:44:54 +0100 (CET)
Received: from mail-fx0-f42.google.com ([209.85.161.42]:60938 "EHLO
        mail-fx0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492456Ab0LTKou convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 20 Dec 2010 11:44:50 +0100
Received: by fxm11 with SMTP id 11so2516573fxm.29
        for <linux-mips@linux-mips.org>; Mon, 20 Dec 2010 02:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=qiyjwEQxt5n/FqAnA7IGOe8dgPX5wyP9MsJdj9PUV+4=;
        b=Ba4IUMkT7KrqHKtQPdX3e70Grev5hyatAqLS9ev/YZtsrgxRUAJjgalm5OW+ST3VQa
         JobDfkUb4IfXvyeOiJcF69yu+9lWX/PeCX/XWfKUKSJ/noJ/G+cMFVwMavmoeVBEtZzJ
         6ZhPqadVQI7h2L2wfsCVxceFMifgGM6dhas+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=GJyNy2YntT8RupdBhm1JKhu5MsZekNrFU1XzhKkmXykK3aqroCuyONPJwcFh3qj9pw
         J4iSHN48uVRfAb0vis3m1Ch3tT6K8oSdM2407OLaYkotEdmT+FQ7OYkEsMnF/pnhgcfB
         hOxBsLs7IF9XENVID0hD6B62nNhXiE/V3XXKA=
MIME-Version: 1.0
Received: by 10.223.71.200 with SMTP id i8mr4458869faj.142.1292841884400; Mon,
 20 Dec 2010 02:44:44 -0800 (PST)
Received: by 10.223.74.136 with HTTP; Mon, 20 Dec 2010 02:44:44 -0800 (PST)
In-Reply-To: <4D0BD7A0.1030504@paralogos.com>
References: <8F242B230AD6474C8E7815DE0B4982D7179FB880@EXV1.corp.adtran.com>
        <4D0A677C.6040104@paralogos.com>
        <4D0A6F63.8080206@paralogos.com>
        <4D0BD7A0.1030504@paralogos.com>
Date:   Mon, 20 Dec 2010 16:14:44 +0530
Message-ID: <AANLkTikTn_Lw=vqtfUyDW7GXxq75ZYLGi8_MyVVyPkKt@mail.gmail.com>
Subject: Re: SMTC support status in latest git head.
From:   Anoop P A <anoop.pa@gmail.com>
To:     "Kevin D. Kissell" <kevink@paralogos.com>
Cc:     STUART VENTERS <stuart.venters@adtran.com>,
        linux-mips@linux-mips.org, Anoop_P.A@pmc-sierra.com
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <anoop.pa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28655
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anoop.pa@gmail.com
Precedence: bulk
X-list: linux-mips

Hi Kevin,

Please find disassembly  for mips_mt_reg_dump

Thanks
Anoop

Disassembly of section .text:

00000000 <mips_mt_regdump>:
  0:   27bdffb8        addiu   sp,sp,-72
  4:   00802821        move    a1,a0
  8:   afbf0044        sw      ra,68(sp)
  c:   afbe0040        sw      s8,64(sp)
 10:   afb7003c        sw      s7,60(sp)
 14:   afb60038        sw      s6,56(sp)
 18:   afb50034        sw      s5,52(sp)
 1c:   afb40030        sw      s4,48(sp)
 20:   afb3002c        sw      s3,44(sp)
 24:   afb20028        sw      s2,40(sp)
 28:   afb10024        sw      s1,36(sp)
 2c:   afb00020        sw      s0,32(sp)
 30:   40141001        mfc0    s4,c0_tcstatus
 34:   36810400        ori     at,s4,0x400
 38:   40811001        mtc0    at,c0_tcstatus
 3c:   32940400        andi    s4,s4,0x400
 40:   000000c0        ehb
 44:   41610001        dvpe    at
 48:   0020a821        move    s5,at
 4c:   000000c0        ehb
 50:   3c020000        lui     v0,0x0
 54:   24420060        addiu   v0,v0,96
 58:   00400408        jr.hb   v0
 5c:   00000000        nop
 60:   3c040000        lui     a0,0x0
 64:   24840000        addiu   a0,a0,0
 68:   0c000000        jal     0 <mips_mt_regdump>
 6c:   afa50010        sw      a1,16(sp)
 70:   3c040000        lui     a0,0x0
 74:   0c000000        jal     0 <mips_mt_regdump>
 78:   24840000        addiu   a0,a0,0
 7c:   8fa50010        lw      a1,16(sp)
 80:   3c040000        lui     a0,0x0
 84:   0c000000        jal     0 <mips_mt_regdump>
 88:   24840000        addiu   a0,a0,0
 8c:   3c040000        lui     a0,0x0
 90:   24840000        addiu   a0,a0,0
 94:   0c000000        jal     0 <mips_mt_regdump>
 98:   02a02821        move    a1,s5
 9c:   40110002        mfc0    s1,c0_mvpconf0
 a0:   3c040000        lui     a0,0x0
 a4:   02202821        move    a1,s1
 a8:   0c000000        jal     0 <mips_mt_regdump>
 ac:   24840000        addiu   a0,a0,0
 b0:   3c040000        lui     a0,0x0
 b4:   0c000000        jal     0 <mips_mt_regdump>
 b8:   24840000        addiu   a0,a0,0
 bc:   7e331a80        ext     s3,s1,0xa,0x4
 c0:   3c090000        lui     t1,0x0
 c4:   323100ff        andi    s1,s1,0xff
 c8:   3c080000        lui     t0,0x0
 cc:   3c030000        lui     v1,0x0
 d0:   3c1e0000        lui     s8,0x0
 d4:   3c170000        lui     s7,0x0
 d8:   3c160000        lui     s6,0x0
 dc:   3c0a0000        lui     t2,0x0
 e0:   26730001        addiu   s3,s3,1
 e4:   26310001        addiu   s1,s1,1
 e8:   00008021        move    s0,zero
 ec:   2412ff00        li      s2,-256
 f0:   25290000        addiu   t1,t1,0
 f4:   25080000        addiu   t0,t0,0
 f8:   24630000        addiu   v1,v1,0
 fc:   27de0000        addiu   s8,s8,0
 100:   26f70000        addiu   s7,s7,0
 104:   26d60000        addiu   s6,s6,0
 108:   254a0000        addiu   t2,t2,0
 10c:   00001021        move    v0,zero
 110:   40040801        mfc0    a0,c0_vpecontrol
 114:   00922024        and     a0,a0,s2
 118:   00442025        or      a0,v0,a0
 11c:   40840801        mtc0    a0,c0_vpecontrol
 120:   000000c0        ehb
 124:   41020802        mftc0   at,c0_tcbind
 128:   00202021        move    a0,at
 12c:   24420001        addiu   v0,v0,1
 130:   3084000f        andi    a0,a0,0xf
 134:   12040031        beq     s0,a0,1fc <mips_mt_regdump+0x1fc>
 138:   0051282a        slt     a1,v0,s1
 13c:   14a0fff4        bnez    a1,110 <mips_mt_regdump+0x110>
 140:   00000000        nop
 144:   26100001        addiu   s0,s0,1
 148:   0213102a        slt     v0,s0,s3
 14c:   1440fff0        bnez    v0,110 <mips_mt_regdump+0x110>
 150:   00001021        move    v0,zero
 154:   3c040000        lui     a0,0x0
 158:   24840000        addiu   a0,a0,0
 15c:   3c1e0000        lui     s8,0x0
 160:   3c170000        lui     s7,0x0
 164:   3c160000        lui     s6,0x0
 168:   3c130000        lui     s3,0x0
 16c:   0c000000        jal     0 <mips_mt_regdump>
 170:   3c120000        lui     s2,0x0
 174:   00008021        move    s0,zero
 178:   27de0000        addiu   s8,s8,0
 17c:   26f70000        addiu   s7,s7,0
 180:   26d60000        addiu   s6,s6,0
 184:   26730000        addiu   s3,s3,0
 188:   26520000        addiu   s2,s2,0
 18c:   40020801        mfc0    v0,c0_vpecontrol
 190:   2403ff00        li      v1,-256
 194:   00431024        and     v0,v0,v1
 198:   02021025        or      v0,s0,v0
 19c:   40820801        mtc0    v0,c0_vpecontrol
 1a0:   000000c0        ehb
 1a4:   41020802        mftc0   at,c0_tcbind
 1a8:   00201821        move    v1,at
 1ac:   40021002        mfc0    v0,c0_tcbind
 1b0:   1062003f        beq     v1,v0,2b0 <mips_mt_regdump+0x2b0>
 1b4:   00000000        nop
 1b8:   41020804        mftc0   at,c0_tchalt
 1bc:   00201821        move    v1,at
 1c0:   24020001        li      v0,1
 1c4:   00400821        move    at,v0
 1c8:   41811004        mttc0   at,c0_tchalt
 1cc:   41020801        mftc0   at,c0_tcstatus
 1d0:   00203021        move    a2,at
 1d4:   3c040000        lui     a0,0x0
 1d8:   02002821        move    a1,s0
 1dc:   24840000        addiu   a0,a0,0
 1e0:   afa3001c        sw      v1,28(sp)
 1e4:   0c000000        jal     0 <mips_mt_regdump>
 1e8:   afa60010        sw      a2,16(sp)
 1ec:   8fa60010        lw      a2,16(sp)
 1f0:   8fa3001c        lw      v1,28(sp)
 1f4:   080000b2        j       2c8 <mips_mt_regdump+0x2c8>
 1f8:   00c02821        move    a1,a2
 1fc:   01202021        move    a0,t1
 200:   02002821        move    a1,s0
 204:   afa3001c        sw      v1,28(sp)
 208:   afa80014        sw      t0,20(sp)
 20c:   afa90010        sw      t1,16(sp)
 210:   0c000000        jal     0 <mips_mt_regdump>
 214:   afaa0018        sw      t2,24(sp)
 218:   41010801        mftc0   at,c0_vpecontrol
 21c:   00202821        move    a1,at
 220:   8fa80014        lw      t0,20(sp)
 224:   0c000000        jal     0 <mips_mt_regdump>
 228:   01002021        move    a0,t0
 22c:   41010802        mftc0   at,c0_vpeconf0
 230:   00202821        move    a1,at
 234:   8fa3001c        lw      v1,28(sp)
 238:   0c000000        jal     0 <mips_mt_regdump>
 23c:   00602021        move    a0,v1
 240:   410c0800        mftc0   at,c0_status
 244:   00203021        move    a2,at
 248:   03c02021        move    a0,s8
 24c:   0c000000        jal     0 <mips_mt_regdump>
 250:   02002821        move    a1,s0
 254:   410e0800        mftc0   at,c0_epc
 258:   00203021        move    a2,at
 25c:   410e0800        mftc0   at,c0_epc
 260:   00203821        move    a3,at
 264:   02e02021        move    a0,s7
 268:   0c000000        jal     0 <mips_mt_regdump>
 26c:   02002821        move    a1,s0
 270:   410d0800        mftc0   at,c0_cause
 274:   00203021        move    a2,at
 278:   02c02021        move    a0,s6
 27c:   0c000000        jal     0 <mips_mt_regdump>
 280:   02002821        move    a1,s0
 284:   41100807        mftc0   at,$16,7
 288:   00203021        move    a2,at
 28c:   8faa0018        lw      t2,24(sp)
 290:   02002821        move    a1,s0
 294:   0c000000        jal     0 <mips_mt_regdump>
 298:   01402021        move    a0,t2
 29c:   8fa3001c        lw      v1,28(sp)
 2a0:   8fa80014        lw      t0,20(sp)
 2a4:   8fa90010        lw      t1,16(sp)
 2a8:   08000051        j       144 <mips_mt_regdump+0x144>
 2ac:   8faa0018        lw      t2,24(sp)
 2b0:   3c040000        lui     a0,0x0
 2b4:   02002821        move    a1,s0
 2b8:   0c000000        jal     0 <mips_mt_regdump>
 2bc:   24840000        addiu   a0,a0,0
 2c0:   00001821        move    v1,zero
 2c4:   02802821        move    a1,s4
 2c8:   03c02021        move    a0,s8
 2cc:   0c000000        jal     0 <mips_mt_regdump>
 2d0:   afa3001c        sw      v1,28(sp)
 2d4:   41020802        mftc0   at,c0_tcbind
 2d8:   00202821        move    a1,at
 2dc:   0c000000        jal     0 <mips_mt_regdump>
 2e0:   02e02021        move    a0,s7
 2e4:   41020803        mftc0   at,c0_tcrestart
 2e8:   00202821        move    a1,at
 2ec:   41020803        mftc0   at,c0_tcrestart
 2f0:   00203021        move    a2,at
 2f4:   0c000000        jal     0 <mips_mt_regdump>
 2f8:   02c02021        move    a0,s6
 2fc:   8fa3001c        lw      v1,28(sp)
 300:   02602021        move    a0,s3
 304:   0c000000        jal     0 <mips_mt_regdump>
 308:   00602821        move    a1,v1
 30c:   41020805        mftc0   at,c0_tccontext
 310:   00202821        move    a1,at
 314:   0c000000        jal     0 <mips_mt_regdump>
 318:   02402021        move    a0,s2
 31c:   8fa3001c        lw      v1,28(sp)
 320:   14600003        bnez    v1,330 <mips_mt_regdump+0x330>
 324:   00001021        move    v0,zero
 328:   00400821        move    at,v0
 32c:   41811004        mttc0   at,c0_tchalt
 330:   26100001        addiu   s0,s0,1
 334:   0211102a        slt     v0,s0,s1
 338:   1440ff94        bnez    v0,18c <mips_mt_regdump+0x18c>
 33c:   00000000        nop
 340:   0c000000        jal     0 <mips_mt_regdump>
 344:   32b50001        andi    s5,s5,0x1
 348:   3c040000        lui     a0,0x0
 34c:   0c000000        jal     0 <mips_mt_regdump>
 350:   24840000        addiu   a0,a0,0
 354:   12a00004        beqz    s5,368 <mips_mt_regdump+0x368>
 358:   32820400        andi    v0,s4,0x400
 35c:   41600021        evpe
 360:   000000c0        ehb
 364:   32820400        andi    v0,s4,0x400
 368:   14400003        bnez    v0,378 <mips_mt_regdump+0x378>
 36c:   00000000        nop
 370:   0c000000        jal     0 <mips_mt_regdump>
 374:   00000000        nop
 378:   40011001        mfc0    at,c0_tcstatus
 37c:   32940400        andi    s4,s4,0x400
 380:   34210400        ori     at,at,0x400
 384:   38210400        xori    at,at,0x400
 388:   0281a025        or      s4,s4,at
 38c:   40941001        mtc0    s4,c0_tcstatus
 390:   000000c0        ehb
 394:   8fbf0044        lw      ra,68(sp)
 398:   8fbe0040        lw      s8,64(sp)
 39c:   8fb7003c        lw      s7,60(sp)
 3a0:   8fb60038        lw      s6,56(sp)
 3a4:   8fb50034        lw      s5,52(sp)
 3a8:   8fb40030        lw      s4,48(sp)
 3ac:   8fb3002c        lw      s3,44(sp)
 3b0:   8fb20028        lw      s2,40(sp)
 3b4:   8fb10024        lw      s1,36(sp)
 3b8:   8fb00020        lw      s0,32(sp)
 3bc:   03e00008        jr      ra
 3c0:   27bd0048        addiu   sp,sp,72


On Sat, Dec 18, 2010 at 3:05 AM, Kevin D. Kissell <kevink@paralogos.com> wrote:
> So, Anoop, if you get a minute for this any time in the next day or so
> (after which I'll have very limited net access until next year), could you
> please do an <mumble>-mips<mumble>-objdump --disassemble of your kernel
> image (or even just the mips-mt.o module) from a failing kernel build and
> post the disassembly of mips_mt_regdump()?  The confirmation or refutation
> of the theory about local_irq_save() no longer being built correctly for
> SMTC would be within the first few instructions...
>
> /K.
>
>
> On 12/16/10 11:58, Kevin D. Kissell wrote:
>>
>> Ralf tells me that this message got blocked by the LMO server due to HTML
>> content.
>> So here it is again, textier.
>>
>> On 12/16/10 11:24, Kevin D. Kissell wrote:
>> > On 12/16/10 07:37, STUART VENTERS wrote:
>> >
>> > Two other possible clues:
>> >
>> > The EVP is clear in the MVPControl register.
>> > Does this say that only VPE0, T0 gets to run?
>>
>> That's correct.  In the maxtcs=1/maxvpes=1 boot state, it wouldn't matter.
>>  It's just possible that setting EVP is conditional on more than one VPE
>> being used, but that's not the way I remember it.
>>
>> > Also the EXCPT bits in VPEControl for VPE1 indicate a Gating Storage
>> > Exception dispatch.
>> > But that seems to conflict the EVP bit above.
>>
>> I don't have a copy of the ASE spec handy to see whether those bits have a
>> defined power-on value, but particularly if maxvpes=1 was set at boot time,
>> I would expect VPE1's registers to be in a partly random power-up state.
>>
>> > Perhaps these are an artifact of getting to a good state to dump things
>> > out.
>>
>> As per my previous mail, I looked at the MT register dump source, and it
>> really does pull values directly
>> out of registers and doesn't depend on having a sane kernel stack frame.
>>  The exceptions to that rule
>> are the reported values for TCStatus of the executing TC, which is based
>> on the perhaps-now-broken
>> assumption that local_irq_save(flags) stores the *entire* pre-invocation
>> value of the TCStatus register
>> in the flags variable, and MVPcontrol, which is based on the assumption
>> that dvpe() returns the pre-invocation
>> value of MVPcontrol.  Break those assumptions, and you'll get inconsistent
>> state dumps like this,
>> and very possibly incorrect execution.   Particularly if what was done was
>> that effectively replaces
>> the SMTC-specific implementation of local_irq_save()/local_irq_restore()
>> with something that uses
>> the generic MIPS32R2 atomic interrupt enable/disable instructions.  That
>> would have been a *very* bad idea...
>>
>>             Regards,
>>
>>             Kevin K.
>>
>>
>
>
