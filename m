Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6B7UsRw015855
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 11 Jul 2002 00:30:54 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6B7UsGN015854
	for linux-mips-outgoing; Thu, 11 Jul 2002 00:30:54 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (mx2.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6B7UHRw015844
	for <linux-mips@oss.sgi.com>; Thu, 11 Jul 2002 00:30:17 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g6B7YUXb010999;
	Thu, 11 Jul 2002 00:34:34 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id AAA01957;
	Thu, 11 Jul 2002 00:34:29 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g6B7YTb16347;
	Thu, 11 Jul 2002 09:34:29 +0200 (MEST)
Message-ID: <3D2D3504.164F4988@mips.com>
Date: Thu, 11 Jul 2002 09:34:28 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Jon Burgess <Jon_Burgess@eur.3com.com>
CC: linux-mips@oss.sgi.com
Subject: Re: mips32_flush_cache routine corrupts CP0_STATUS with gcc-2.96
References: <80256BF2.004ECBE6.00@notesmta.eur.3com.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This sound more like a hardware bug to me.
What CPU are you running on ?

/Carsten

Jon Burgess wrote:

> Symptom:
> ====
> The linux mips 2.4.17 kernel compiled with gcc-2.96-110 (from H.J.Lu) hangs
> before reaching the 'Calibrating delay loop'. When the same kernel is compiled
> with gcc-3.0.4 or egcs-1.1.2 it works OK. I have included what I think is the
> cause, some patches to test the theory and some possible fixes.
>
> Cause:
> ====
> I tracked the problem back to the CP0_STATUS being corrupted by the
> mips32_flush_cache_all_pc routine, leading to a lockup once interrupts are
> enabled. Looking at a disassembly of the code suggests the broken code changes
> the value of the AT register while the working code leaves it alone. The
> compiler is allowed to do this, but it exposes the real problem which appears to
> be a problem between the 'cache' instruction of blast_icache() and the 'mfc0' of
> the __restore_flags(). The 'mfc0 at, $12' seems to be ignored. This isn't a
> problem with the gcc-3.0.4 code since AT still contains the value of CP0_STATUS
> from the __save_and_cli at the start of the routine.
>
> This may be caused by the cache routines running from the a cached kseg0, it
> looks like it can be fixed by making sure that the are always called via
> KSEG1ADDR(fn) which looks like it could be done with a bit of fiddling of the
> setup_cache_funcs code. I have included a patch below which starts this, but I
> haven't caught all combinations of how the routines are called.
>
> Alternatively it could be a CP0 pipeline interaction of the cache instruction
> and mfc0 but I can't find anything detailed about it. I thought this was the
> problem initially and have included a patch below which adds an extra nop.
>
> I believe the root of the problem is that the routines are running in kseg0, but
> If anyone has any other ideas as to what could causing the problem then i'd be
> glad to know.
>
> You can test this by inserting some extra code to change AT between the save &
> restore and see if it causes a problem (see included patches below)
>
> Current source:
> static inline void mips32_flush_cache_all_pc(void)
> {
>      unsigned long flags;
>
>      __save_and_cli(flags);
>      blast_dcache(); blast_icache();
>      __restore_flags(flags);
> }
>
> Disassembly of  mips32_flush_cache_all_pc() for broken code gcc-2.96:
> 00000c30 <mips32_flush_cache_all_pc>:
>  c30:   40066000        mfc0    a2,$12
>  c34:   00000000        nop
>  c38:   34c10001        ori     at,a2,0x1
>  c3c:   38210001        xori    at,at,0x1
>  c40:   40816000        mtc0    at,$12
>  c44:   00000040        ssnop
>  c48:   00000040        ssnop
>  c4c:   00000040        ssnop
>  c50:   3c030000        lui     v1,0x0
>  c54:   8c630000        lw      v1,0(v1)
>  c58:   3c048000        lui     a0,0x8000
>  c5c:   3c018000        lui     at,0x8000
> *** See here how the compiler has changed AT here
>  c60:   00231821        addu    v1,at,v1
>  c64:   0083102b        sltu    v0,a0,v1
>  c68:   10400008        beqz    v0,c8c <mips32_flush_cache_all_pc+0x5c>
>  c6c:   00000000        nop
>  c70:   3c050000        lui     a1,0x0
>  c74:   8ca50000        lw      a1,0(a1)
>  c78:   bc810000        cache   0x1,0(a0)
>  c7c:   00852021        addu    a0,a0,a1
>  c80:   0083102b        sltu    v0,a0,v1
>  c84:   1440fffc        bnez    v0,c78 <mips32_flush_cache_all_pc+0x48>
>  c88:   00000000        nop
>  c8c:   3c030000        lui     v1,0x0
>  c90:   8c630000        lw      v1,0(v1)
>  c94:   3c048000        lui     a0,0x8000
>  c98:   3c018000        lui     at,0x8000
>  c9c:   00231821        addu    v1,at,v1
>  ca0:   0083102b        sltu    v0,a0,v1
>  ca4:   10400008        beqz    v0,cc8 <mips32_flush_cache_all_pc+0x98>
>  ca8:   00000000        nop
>  cac:   3c050000        lui     a1,0x0
>  cb0:   8ca50000        lw      a1,0(a1)
>  cb4:   bc800000        cache   0x0,0(a0)
>  cb8:   00852021        addu    a0,a0,a1
>  cbc:   0083102b        sltu    v0,a0,v1
>  cc0:   1440fffc        bnez    v0,cb4 <mips32_flush_cache_all_pc+0x84>
>  cc4:   00000000        nop
>  cc8:   40016000        mfc0    at,$12
> *** The instruction above is the one which seems to be skipped.
>  ccc:   30c60001        andi    a2,a2,0x1
>  cd0:   34210001        ori     at,at,0x1
>  cd4:   38210001        xori    at,at,0x1
>  cd8:   00c13025        or      a2,a2,at
>  cdc:   40866000        mtc0    a2,$12
>         ...
>  cec:   03e00008        jr      ra
>  cf0:   00000000        nop
>
> Patches to demonstrate the problem:
> ====
> Here is a patch to change AT in the cache_flush routine to show that this
> corrupts the CP0_STATUS value (for a mips32 processor with no secondary cache).
> When this is applied in conjunction with the patch above you should see the
> CP0_STATUS being corrupted and the kernel will probably hang. I have
> demonstrated that this change is enough to break a working kernel/compiler
> combination.
>
> --- linux/arch/mips/mm/c-mips32.c-orig   Wed Jul 10 14:12:09 2002
> +++ linux/arch/mips/mm/c-mips32.c  Wed Jul 10 14:18:17 2002
> @@ -74,7 +74,9 @@
>      unsigned long flags;
>
>      __save_and_cli(flags);
> -    blast_dcache(); blast_icache();
> +    blast_dcache();
> +    __asm__("lui\t$at, 0x8000\n\t");
> +    blast_icache();
>      __restore_flags(flags);
>  }
>
> Here is the patch that I used to catch the problem when CP0_STATUS is being
> corrupted by the cache flush routine. The CP0_STATUS should not be changed by
> the call to the cache flush routine.
>
> --- linux/arch/mips/kernel/traps.c Thu May 23 15:19:35 2002
> +++ ../traps.c Wed Jul 10 13:46:54 2002
> @@ -889,7 +889,10 @@
>      memcpy((void *)(KSEG0 + 0x80), &except_vec1_generic, 0x80);
>      memcpy((void *)(KSEG0 + 0x100), &except_vec2_generic, 0x80);
>      memcpy((void *)(KSEG0 + 0x180), &except_vec3_generic, 0x80);
> +
> +    printk("CP0_STATUS before flush = 0x%x\n",
> read_32bit_cp0_register(CP0_STATUS));
>      flush_icache_range(KSEG0 + 0x80, KSEG0 + 0x200);
> +    printk("CP0_STATUS after flush  = 0x%x\n",
> read_32bit_cp0_register(CP0_STATUS));
>      /*
>       * Setup default vectors
>       */
>
> Fix (to call cache routines via uncached Kseg1)
> ====
> Assuming the root of the problem is that the cache flush routines are running
> from cached kseg0. This patch needs a bit more work to make sure that all the
> other routines are called similarly.
>
> --- linux/arch/mips/mm/c-mips32.c-orig   Wed Jul 10 14:12:09 2002
> +++ linux/arch/mips/mm/c-mips32.c  Wed Jul 10 14:45:03 2002
> @@ -606,8 +608,13 @@
>  {
>      _clear_page = (void *)mips32_clear_page_dc;
>      _copy_page = (void *)mips32_copy_page_dc;
> +#if 1
> +    _flush_cache_all =   (void (*)(u32,u32)) KSEG1ADDR((unsigned
> long)mips32_flush_cache_all_pc);
> +    ___flush_cache_all = (void (*)(u32,u32)) KSEG1ADDR((unsigned
> long)mips32_flush_cache_all_pc);
> +#else
>      _flush_cache_all = mips32_flush_cache_all_pc;
>      ___flush_cache_all = mips32_flush_cache_all_pc;
> +#endif
>      _flush_cache_mm = mips32_flush_cache_mm_pc;
>      _flush_cache_range = mips32_flush_cache_range_pc;
>      _flush_cache_page = mips32_flush_cache_page_pc;
>
> Fix (If the root of the problem is a pipeline hazard)
> ====
> The patch below fix is to insert an extra 'nop' at the end of the various
> blast_[id]cache routines to clear the hazard condition before the code returns.
> The 'sc' routines may need a similar fix. A different  workaround places a 'nop'
> at the start of the __restore_flags routine, but I believe it is better to fix
> the problem at the source of the hazard.
>
> --- linux/include/asm-mips/mips32_cache.h     Wed Apr 10 22:53:12 2002
> +++ ../mips32_cache.h    Wed Jul 10 13:10:40 2002
> @@ -189,73 +189,85 @@
>  static inline void blast_dcache(void)
>  {
>      unsigned long start = KSEG0;
>      unsigned long end = (start + dcache_size);
>
>      while(start < end) {
>           cache_unroll(start,Index_Writeback_Inv_D);
>           start += dc_lsize;
>      }
> +    /* Prevent hazard with following mfc0 */
> +    __asm__("nop\n\t");
>  }
>
>  static inline void blast_dcache_page(unsigned long page)
>  {
>      unsigned long start = page;
>      unsigned long end = (start + PAGE_SIZE);
>
>      while(start < end) {
>           cache_unroll(start,Hit_Writeback_Inv_D);
>           start += dc_lsize;
>      }
> +    /* Prevent hazard with following mfc0 */
> +        __asm__("nop\n\t");
>  }
>
>  static inline void blast_dcache_page_indexed(unsigned long page)
>  {
>      unsigned long start = page;
>      unsigned long end = (start + PAGE_SIZE);
>
>      while(start < end) {
>           cache_unroll(start,Index_Writeback_Inv_D);
>           start += dc_lsize;
>      }
> +    /* Prevent hazard with following mfc0 */
> +        __asm__("nop\n\t");
>  }
>
>  static inline void blast_icache(void)
>  {
>      unsigned long start = KSEG0;
>      unsigned long end = (start + icache_size);
>
>      while(start < end) {
>           cache_unroll(start,Index_Invalidate_I);
>           start += ic_lsize;
>      }
> +    /* Prevent hazard with following mfc0 */
> +        __asm__("nop\n\t");
>  }
>
>  static inline void blast_icache_page(unsigned long page)
>  {
>      unsigned long start = page;
>      unsigned long end = (start + PAGE_SIZE);
>
>      while(start < end) {
>           cache_unroll(start,Hit_Invalidate_I);
>           start += ic_lsize;
>      }
> +    /* Prevent hazard with following mfc0 */
> +        __asm__("nop\n\t");
>  }
>
>  static inline void blast_icache_page_indexed(unsigned long page)
>  {
>      unsigned long start = page;
>      unsigned long end = (start + PAGE_SIZE);
>
>      while(start < end) {
>           cache_unroll(start,Index_Invalidate_I);
>           start += ic_lsize;
>      }
> +    /* Prevent hazard with following mfc0 */
> +        __asm__("nop\n\t");
>  }
>
>  static inline void blast_scache(void)
>  {
>      unsigned long start = KSEG0;
>      unsigned long end = KSEG0 + scache_size;
>
>      while(start < end) {
>           cache_unroll(start,Index_Writeback_Inv_SD);
>
>      Jon Burgess

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
