Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6GDwQRw031496
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 16 Jul 2002 06:58:26 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6GDwPbS031495
	for linux-mips-outgoing; Tue, 16 Jul 2002 06:58:25 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6GDwHRw031480
	for <linux-mips@oss.sgi.com>; Tue, 16 Jul 2002 06:58:18 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA27700;
	Tue, 16 Jul 2002 16:03:30 +0200 (MET DST)
Date: Tue, 16 Jul 2002 16:03:29 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Kevin D. Kissell" <kevink@kevink.net>
cc: Ryan Martindale <ryan@qsicorp.com>, linux-mips@oss.sgi.com
Subject: Re: fpu woes (TX3912)
In-Reply-To: <01fa01c22c2a$3011d9c0$10eca8c0@grendel>
Message-ID: <Pine.GSO.3.96.1020716155539.20654N-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 15 Jul 2002, Kevin D. Kissell wrote:

> The following lines in my copy of the file are:
>                 memcpy((void *)(KSEG0 + 0x80), &except_vec3_generic, 0x80);
>                 break;
> 
>         case CPU_UNKNOWN:
>         default:
>                 panic("Unknown CPU type");
>         }
>         if (!(mips_cpu.options & MIPS_CPU_FPU)) {
>                 save_fp_context = fpu_emulator_save_context;
>                 restore_fp_context = fpu_emulator_restore_context;
>         }
> 
> This should overwrite the fp_context save/restore pointers
> with those of the emulator.  If that clause doesn't appear
> in your traps.c file, please try putting it in.

 It's worded a bit differently in the CVS:

	case CPU_UNKNOWN:
	default:
		panic("Unknown CPU type");
	}

	flush_icache_range(KSEG0, KSEG0 + 0x400);

	if (mips_cpu.options & MIPS_CPU_FPU) {
		save_fp_context = _save_fp_context;
		restore_fp_context = _restore_fp_context;
	} else {
		save_fp_context = fpu_emulator_save_context;
		restore_fp_context = fpu_emulator_restore_context;
	}

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
