Received:  by oss.sgi.com id <S42398AbQIEBMU>;
	Mon, 4 Sep 2000 18:12:20 -0700
Received: from u-214.karlsruhe.ipdial.viaginterkom.de ([62.180.19.214]:4356
        "EHLO u-214.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42254AbQIEBMF>; Mon, 4 Sep 2000 18:12:05 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S868988AbQIDWMT>;
        Tue, 5 Sep 2000 00:12:19 +0200
Date:   Tue, 5 Sep 2000 00:12:19 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: _syscallX macros ...
Message-ID: <20000905001219.A1660@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Once more a lesson why you shouldn't use the _syscallX macros from
<asm/unistd.h>.  This is disassembled from modutils which missbehaves
royally on MIPS64 which doesn't implement delete_module(2) & friends
for the 32-bit compat code:

  409240:       3c1c0fc2        lui     $gp,0xfc2
  409244:       279c9bc0        addiu   $gp,$gp,-25664
  409248:       0399e021        addu    $gp,$gp,$t9
  40924c:       27bdffe0        addiu   $sp,$sp,-32
  409250:       afbc0010        sw      $gp,16($sp)
  409254:       afbf001c        sw      $ra,28($sp)
  409258:       afbc0018        sw      $gp,24($sp)
  40925c:       00801021        move    $v0,$a0
  409260:       00402021        move    $a0,$v0
  409264:       24021021        li      $v0,4129
  409268:       0000000c        syscall

$v0 should now contain either the result or if $a3 is set the error code.

  40926c:       10e00008        beqz    $a3,409290
  409270:       00000000        nop
  409274:       8f9980e0        lw      $t9,-32544($gp)
  409278:       00000000        nop
  40927c:       0320f809        jalr    $t9
  409280:       00000000        nop

Whoops - the call did just clobber $a0 ...

  409284:       8fbc0010        lw      $gp,16($sp)
  409288:       ac420000        sw      $v0,0($v0)
  40928c:       2402ffff        li      $v0,-1
  409290:       8fbf001c        lw      $ra,28($sp)
  409294:       00000000        nop
  409298:       03e00008        jr      $ra
  40929c:       27bd0020        addiu   $sp,$sp,32

Kernel fix is on it's way into cvs and as usual in such a case - recompile
affected apps ...  I don't have a list available but in any case modutils is
one of them and e2fsprogs should also be affected.  Btw, Cobalt's kernel
is also affected.

  Ralf
