Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Aug 2017 00:19:48 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:33498 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994885AbdHQWTet8Amu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 18 Aug 2017 00:19:34 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v7HMJWet010016;
        Fri, 18 Aug 2017 00:19:32 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v7HMJVoe010015;
        Fri, 18 Aug 2017 00:19:31 +0200
Date:   Fri, 18 Aug 2017 00:19:31 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Matthew Fortune <Matthew.Fortune@imgtec.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Waldemar Brodkorb <wbx@openadk.org>
Subject: Re: undefined reference to `__multi3' when building with gcc 7.x
Message-ID: <20170817221931.GB12588@linux-mips.org>
References: <20170803225547.6caa602b@windsurf.lan>
 <20170804000556.GC30597@linux-mips.org>
 <20170804151920.GA11317@linux-mips.org>
 <20170804174151.2eea9af3@windsurf.lan>
 <20170804222500.GA11675@linux-mips.org>
 <20170805135649.152b0739@windsurf>
 <20170807083448.GA20713@linux-mips.org>
 <20170813224602.25043e8a@windsurf>
 <20170817071534.GH13257@linux-mips.org>
 <6D39441BF12EF246A7ABCE6654B0235380DAB457@hhmail02.hh.imgtec.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6D39441BF12EF246A7ABCE6654B0235380DAB457@hhmail02.hh.imgtec.org>
User-Agent: Mutt/1.8.3 (2017-05-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59640
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Thu, Aug 17, 2017 at 08:49:13AM +0000, Matthew Fortune wrote:
> Date:   Thu, 17 Aug 2017 08:49:13 +0000
> From: Matthew Fortune <Matthew.Fortune@imgtec.com>
> To: Ralf Baechle <ralf@linux-mips.org>, Thomas Petazzoni
>  <thomas.petazzoni@free-electrons.com>
> CC: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>, Waldemar
>  Brodkorb <wbx@openadk.org>
> Subject: RE: undefined reference to `__multi3' when building with gcc 7.x
> Content-Type: text/plain; charset="us-ascii"
> 
> Ralf Baechle <ralf@linux-mips.org> writes:
> > On Sun, Aug 13, 2017 at 10:46:02PM +0200, Thomas Petazzoni wrote:
> > > Date:   Sun, 13 Aug 2017 22:46:02 +0200
> > > From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> > > To: Ralf Baechle <ralf@linux-mips.org>
> > > Cc: Matthew Fortune <Matthew.Fortune@imgtec.com>,
> > >  linux-mips@linux-mips.org, Waldemar Brodkorb <wbx@openadk.org>
> > > Subject: Re: undefined reference to `__multi3' when building with gcc 7.x
> > > Content-Type: text/plain; charset=US-ASCII
> > >
> > > Hello,
> > >
> > > On Mon, 7 Aug 2017 10:34:48 +0200, Ralf Baechle wrote:
> > >
> > > > > > Chances are it's something specific to MIPS64 R6.  Before trying your
> > > > > > config file I also tried a number of other defconfigs and all built
> > > > > > well.
> > > > > >
> > > > > > Here's a test case which generates a reference to __multi3:
> > > > > >
> > > > > > unsigned long func(unsigned long a, unsigned long b)
> > > > > > {
> > > > > >         return a > (~0UL) / b;
> > > > > > }
> > > > > >
> > > > > > GCC rearanges above statement to:
> > > > > >
> > > > > > 	return (unsigned __int128)a * (unsigned __int128) b > 0xffffffff;
> > > > >
> > > > > And this is normal/expected ?
> > > >
> > > > Without consideration of performance, It's certainly is valid code.  And
> > > > with that I can't drop the issue as a GCC code generation bug.
> > > >
> > > > However it seems GCC itself doesn't seem to have a __multi3 in its
> > > > libgcc2 - which indeed would be a GCC issue - at least none I was easily
> > > > able to find with grep so I'm adding Matthew Fortune to cc in the hope he
> > > > can shed some light on this.
> > >
> > > Indeed, I don't see __multi3 implemented in libgcc in the source code,
> > > but it's probably because it's tricky to see its implementation,
> > > as it really is there:
> > >
> > > $ ./bin/mips64el-linux-readelf -a ./mips64el-buildroot-linux-
> > uclibc/sysroot/lib/libgcc_s.so.1 | grep multi3
> > >   1747: 00011700   100 FUNC    GLOBAL DEFAULT   11 __multi3@@GCC_3.0
> > >   5511: 00011700   100 FUNC    GLOBAL DEFAULT   11 __multi3
> > >   000435e4 -32236(gp) 00011700 00011700 FUNC     11 __multi3
> > >
> > > Objdump says:
> > >
> > > 00011700 <__multi3>:
> > >    11700:       0006103e        dsrl32  v0,a2,0x0
> > >    11704:       7c89f803        dext    a5,a0,0x0,0x20
> > >    11708:       0004403e        dsrl32  a4,a0,0x0
> > >    1170c:       7ccaf803        dext    a6,a2,0x0,0x20
> > >    11710:       012a589c        dmul    a7,a5,a6
> > >    11714:       010a509c        dmul    a6,a4,a6
> > >    11718:       0122489c        dmul    a5,a5,v0
> > >    1171c:       0102409c        dmul    a4,a4,v0
> > >    11720:       012a482d        daddu   a5,a5,a6
> > >    11724:       000b103e        dsrl32  v0,a7,0x0
> > >    11728:       0049102d        daddu   v0,v0,a5
> > >    1172c:       184a0003        bgeuc   v0,a6,1173c <.L2>
> > >    11730:       24090001        li      a5,1
> > >    11734:       0009483c        dsll32  a5,a5,0x0
> > >    11738:       0109402d        daddu   a4,a4,a5
> > 
> > I happened to have a GCC build dir around so I greped for __multi3 and
> > found it hiding in muldi3.o.
> > 
> > Maybe that'obvious for those in the know, not me :)  Also that .o file
> > contained MIPS III code and I was able to get GCC to emit a reference
> > to __multi3 for MIPS III or MIPS64R1 targets, so version of __multi3
> > even seems unused.
> 
> Sorry for the long delay in replying.
> 
> I think this could be considered a GCC bug. The multiply pattern support
> in MIPS GCC is incredibly complex but the net effect is supposed to be
> a guarantee that certain multiply operations will never need to use
> helpers and as such we don't provide the helpers in those cases. There
> are however special cases of course. The widening multiply from DImode
> to TImode can't be generated by the compiler when working around R4000
> errata and the extension is unsigned from DImode to TImode. I don't
> believe TImode multiplies (i.e. full width 128-bit multiplies) are
> generated from MIPS GCC but I don't know whether we have sleep-walked
> into having __int128 support which would muddy the water somewhat.
> 
> So... In an R6 build I don't think the __multi3 helper should be generated
> and I think the offending pattern needs extending for R6 support:
> 
> (define_expand "<u>mulditi3"
>   [(set (match_operand:TI 0 "register_operand")
>         (mult:TI (any_extend:TI (match_operand:DI 1 "register_operand"))
>                  (any_extend:TI (match_operand:DI 2 "register_operand"))))]
>   "ISA_HAS_DMULT && !(<CODE> == ZERO_EXTEND && TARGET_FIX_VR4120)"
> {
>   rtx hilo;
> 
>   if (TARGET_MIPS16)
>     {
>       hilo = gen_rtx_REG (TImode, MD_REG_FIRST);
>       emit_insn (gen_<u>mulditi3_internal (hilo, operands[1], operands[2]));
>       emit_move_insn (operands[0], hilo);
>     }
>   else if (TARGET_FIX_R4000)
>     emit_insn (gen_<u>mulditi3_r4000 (operands[0], operands[1], operands[2]));
>   else
>     emit_insn (gen_<u>mulditi3_internal (operands[0], operands[1],
>                                          operands[2]));
>   DONE;
> })
> 
> For SI->DI mode multiplies on 32bit R6 we have the following which naturally
> ports to DI->TI:
> 
> (define_expand "<u>mulsidi3_32bit_r6"
>   [(set (match_operand:DI 0 "register_operand")
>         (mult:DI (any_extend:DI (match_operand:SI 1 "register_operand"))
>                  (any_extend:DI (match_operand:SI 2 "register_operand"))))]
>   "!TARGET_64BIT && ISA_HAS_R6MUL"
> {
>   rtx dest = gen_reg_rtx (DImode);
>   rtx low = mips_subword (dest, 0);
>   rtx high = mips_subword (dest, 1);
> 
>   emit_insn (gen_mulsi3_mul3_nohilo (low, operands[1], operands[2]));
>   emit_insn (gen_<su>mulsi3_highpart_r6 (high, operands[1], operands[2]));
> 
>   emit_move_insn (mips_subword (operands[0], 0), low);
>   emit_move_insn (mips_subword (operands[0], 1), high);
>   DONE;
> })
> 
> Despite the theory being simple, wiring this up will take time as it also
> involves getting the costing calculations updated.
> 
> Please can you submit it as a GCC bug?

Will do.

> As a workaround you may want to include a version of __multi3 in the kernel
> until it is resolved.

Yes, working on that.  This has been made harder by the fact that the
implementation of __umulti3 is well hidden in the source :)  I now have
functioning implementation of __multi3 but it's still too ugly to be
committed to the kernel.

And while I agree it should be fixed in GCC at the same time the
generated code while convoluted and unnecessarily slow appears to be
correct so I think we should support this by adding a suitable __umulti3
to the kernel code as you suggest.

  Ralf
