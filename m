Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jul 2004 16:59:34 +0100 (BST)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:1247 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8225072AbUGPP73>; Fri, 16 Jul 2004 16:59:29 +0100
Received: from localhost (p5177-ipad03funabasi.chiba.ocn.ne.jp [219.160.85.177])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 35AA17409; Sat, 17 Jul 2004 00:59:26 +0900 (JST)
Date: Sat, 17 Jul 2004 01:05:21 +0900 (JST)
Message-Id: <20040717.010521.74757110.anemo@mba.ocn.ne.jp>
To: ralf@linux-mips.org
Cc: dom@mips.com, KevinK@mips.com, theansweriz42@hotmail.com,
	linux-mips@linux-mips.org
Subject: Re: Strange, strange occurence
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20040716122409.GA19192@linux-mips.org>
References: <20040713003317.GA26715@linux-mips.org>
	<16629.24775.778491.754688@arsenal.mips.com>
	<20040716122409.GA19192@linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5493
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Fri, 16 Jul 2004 14:24:09 +0200, Ralf Baechle <ralf@linux-mips.org> said:

ralf> No and yes - but here is a simpler solution.  Below patch solves
ralf> the problem and adds just 32 bytes of code but removes the
ralf> special case for TX49/H2 entirely.

Hmm... Does this patch really solves the problem?

Here is a disassemble list of blast_icache32 (gcc 3.3.3).  The
comments on CACHE instructions are indices of cachelines which the
instruction invalidates.  (for 4 way 16KB cache --- 4KB waysize).

80039ca0 <blast_icache32>:
80039ca0:       3c048038        lui     a0,0x8038
80039ca4:       8c849e2c        lw      a0,-25044(a0)
80039ca8:       3c028038        lui     v0,0x8038
80039cac:       94429e22        lhu     v0,-25054(v0)
80039cb0:       3c038038        lui     v1,0x8038
80039cb4:       8c639e28        lw      v1,-25048(v1)
80039cb8:       00824004        sllv    t0,v0,a0
80039cbc:       24020001        li      v0,1
80039cc0:       3c018004        lui     at,0x8004
80039cc4:       24219ef4        addiu   at,at,-24844	# 80039ef4
80039cc8:       00231821        addu    v1,at,v1
80039ccc:       00823804        sllv    a3,v0,a0
80039cd0:       11000031        beqz    t0,80039d98 <blast_icache32+0xf8>
80039cd4:       00002821        move    a1,zero
80039cd8:       3c028004        lui     v0,0x8004
80039cdc:       24429ef4        addiu   v0,v0,-24844	# 80039ef4
80039ce0:       0043302b        sltu    a2,v0,v1
80039ce4:       3c048004        lui     a0,0x8004
80039ce8:       24849ef4        addiu   a0,a0,-24844	# 80039ef4
80039cec:       50c00027        beqzl   a2,80039d8c <blast_icache32+0xec>
80039cf0:       00a72821        addu    a1,a1,a3
80039cf4:       00851025        or      v0,a0,a1
80039cf8:       bc400000        cache   0x0,0(v0)	# ee0 2e0 6e0 ae0
80039cfc:       bc400020        cache   0x0,32(v0)	# f00 300 700 b00
80039d00:       bc400040        cache   0x0,64(v0)
80039d04:       bc400060        cache   0x0,96(v0)
80039d08:       bc400080        cache   0x0,128(v0)
80039d0c:       bc4000a0        cache   0x0,160(v0)
80039d10:       bc4000c0        cache   0x0,192(v0)
80039d14:       bc4000e0        cache   0x0,224(v0)
80039d18:       bc400100        cache   0x0,256(v0)
80039d1c:       bc400120        cache   0x0,288(v0)	# 000 400 800 c00
80039d20:       bc400140        cache   0x0,320(v0)
80039d24:       bc400160        cache   0x0,352(v0)
80039d28:       bc400180        cache   0x0,384(v0)
80039d2c:       bc4001a0        cache   0x0,416(v0)
80039d30:       bc4001c0        cache   0x0,448(v0)
80039d34:       bc4001e0        cache   0x0,480(v0)
80039d38:       bc400200        cache   0x0,512(v0)
80039d3c:       bc400220        cache   0x0,544(v0)	# 100 500 900 d00
80039d40:       bc400240        cache   0x0,576(v0)	# 120 520 920 d20
80039d44:       bc400260        cache   0x0,608(v0)	# 140 540 940 d40 !!!
80039d48:       bc400280        cache   0x0,640(v0)
80039d4c:       bc4002a0        cache   0x0,672(v0)
80039d50:       bc4002c0        cache   0x0,704(v0)
80039d54:       bc4002e0        cache   0x0,736(v0)
80039d58:       bc400300        cache   0x0,768(v0)
80039d5c:       bc400320        cache   0x0,800(v0)	# 200 600 a00 e00
80039d60:       bc400340        cache   0x0,832(v0)
80039d64:       bc400360        cache   0x0,864(v0)
80039d68:       bc400380        cache   0x0,896(v0)
80039d6c:       bc4003a0        cache   0x0,928(v0)
80039d70:       bc4003c0        cache   0x0,960(v0)
80039d74:       bc4003e0        cache   0x0,992(v0)
80039d78:       24840400        addiu   a0,a0,1024
80039d7c:       0083102b        sltu    v0,a0,v1
80039d80:       1440ffdd        bnez    v0,80039cf8 <blast_icache32+0x58>
80039d84:       00851025        or      v0,a0,a1
80039d88:       00a72821        addu    a1,a1,a3
80039d8c:       00a8102b        sltu    v0,a1,t0
80039d90:       1440ffd4        bnez    v0,80039ce4 <blast_icache32+0x44>
80039d94:       00000000        nop
80039d98:       03e00008        jr      ra
80039d9c:       00000000        nop


The target address of the first CACHE instruction is 0x80039ef4.  It
invalidates index 0xee0 line.  The CACHE instruction on 0x80039d44
invalidates index 0xd40 line which may contains the
instruction... Ouch!!!

I suppose "two-phase invalidating" must be required to solve this
problem.

---
Atsushi Nemoto
