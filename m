Received:  by oss.sgi.com id <S42377AbQHaWrn>;
	Thu, 31 Aug 2000 15:47:43 -0700
Received: from noose.gt.owl.de ([62.52.19.4]:55300 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S42238AbQHaWrg>;
	Thu, 31 Aug 2000 15:47:36 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 971867F8; Fri,  1 Sep 2000 00:51:42 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 3E61F8FF5; Fri,  1 Sep 2000 00:46:13 +0200 (CEST)
Date:   Fri, 1 Sep 2000 00:46:13 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     linux-mips@oss.sgi.com
Subject: crash in r4k_dma_cache_wback_inv_pc on r5k on bootup
Message-ID: <20000901004612.A314@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi,
i just got a System.map and objectdump handy while the r5k crashed :)


Unable to ... at ... 00000008, epc == 880182e4, ra == 88156db0


880182a8:   bcb50000        cache   0x15,0($a1)
880182ac:   14a2fffe        bne     $a1,$v0,880182a8 <r4k_dma_cache_wback_inv_pc+80>
880182b0:   00a42821        addu    $a1,$a1,$a0
880182b4:   40086000        mfc0    $t0,$12
880182b8:   3409ff00        li      $t1,0xff00
880182bc:   01094024        and     $t0,$t0,$t1
880182c0:   00094827        nor     $t1,$zero,$t1
880182c4:   00c93024        and     $a2,$a2,$t1
880182c8:   00c83025        or      $a2,$a2,$t0
880182cc:   40866000        mtc0    $a2,$12
...
880182dc:   3c028819        lui     $v0,0x8819
880182e0:   8c429dc4        lw      $v0,-25148($v0)
880182e4:   8c420008        lw      $v0,8($v0)      <------
880182e8:   02002021        move    $a0,$s0
880182ec:   0040f809        jalr    $v0
880182f0:   02202821        move    $a1,$s1
880182f4:   8fbf0018        lw      $ra,24($sp)
880182f8:   8fb10014        lw      $s1,20($sp)
880182fc:   8fb00010        lw      $s0,16($sp)
88018300:   03e00008        jr      $ra
88018304:   27bd0020        addiu   $sp,$sp,32

It seems "bcops" is at 0x0 which is - aehm - bogus ?

Between 20000601 (Random date) and today r4xx0.c has changed
this way:

---------------------------------------------------------------
-static void no_sc_noop(void) {}
-
-static struct bcache_ops no_sc_ops = {
-       (void *)no_sc_noop, (void *)no_sc_noop,
-       (void *)no_sc_noop, (void *)no_sc_noop
-};
 
-struct bcache_ops *bcops = &no_sc_ops;
+DECLARE_BCOPS;
---------------------------------------------------------------

And DECLARE_BCOPS is defined in include/asm-mips/bcache.h as

---------------------------------------------------------------
#define DECLARE_BCOPS struct bcache_ops *bcops
---------------------------------------------------------------

Which is not the same - There are no "noops" suddenly
and it seems this doesnt get initialized correctly
at all and bcops stays "0" although in the normal
codepath in arch/mips/sgi/kernel/setup.c contains


    255 
    256         /* Now enable boardcaches, if any. */
    257         indy_sc_init();
    258 

Which itself is arm/mips/sgi/kernel/indy_sc.c

    221 void __init indy_sc_init(void)
    222 {
    223         if (indy_sc_probe()) {
    224                 indy_sc_enable();
    225                 bcops = &indy_sc_ops;
    226         }
    227 }

But it doesnt seem indy_sc_probe is "true" for R5k machines.

This might be all of the problem with r5k machines ... We only
ran with the "noop" bcache functions and now the r5k is
not running with any function :)

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5201-669912
      "Write only memory - Oops. Time for my medication again ..."
