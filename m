Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Aug 2017 22:46:17 +0200 (CEST)
Received: from mail.free-electrons.com ([62.4.15.54]:50755 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993918AbdHMUqKH7SCb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 13 Aug 2017 22:46:10 +0200
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 77B982081E; Sun, 13 Aug 2017 22:46:04 +0200 (CEST)
Received: from windsurf (unknown [77.147.230.132])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 0D8C02080D;
        Sun, 13 Aug 2017 22:46:04 +0200 (CEST)
Date:   Sun, 13 Aug 2017 22:46:02 +0200
From:   Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Matthew Fortune <Matthew.Fortune@imgtec.com>,
        linux-mips@linux-mips.org, Waldemar Brodkorb <wbx@openadk.org>
Subject: Re: undefined reference to `__multi3' when building with gcc 7.x
Message-ID: <20170813224602.25043e8a@windsurf>
In-Reply-To: <20170807083448.GA20713@linux-mips.org>
References: <20170803225547.6caa602b@windsurf.lan>
        <20170804000556.GC30597@linux-mips.org>
        <20170804151920.GA11317@linux-mips.org>
        <20170804174151.2eea9af3@windsurf.lan>
        <20170804222500.GA11675@linux-mips.org>
        <20170805135649.152b0739@windsurf>
        <20170807083448.GA20713@linux-mips.org>
Organization: Free Electrons
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <thomas.petazzoni@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59558
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.petazzoni@free-electrons.com
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

Hello,

On Mon, 7 Aug 2017 10:34:48 +0200, Ralf Baechle wrote:

> > > Chances are it's something specific to MIPS64 R6.  Before trying your
> > > config file I also tried a number of other defconfigs and all built
> > > well.
> > > 
> > > Here's a test case which generates a reference to __multi3:
> > > 
> > > unsigned long func(unsigned long a, unsigned long b)
> > > {
> > >         return a > (~0UL) / b;
> > > }
> > > 
> > > GCC rearanges above statement to:
> > > 
> > > 	return (unsigned __int128)a * (unsigned __int128) b > 0xffffffff;  
> > 
> > And this is normal/expected ?  
> 
> Without consideration of performance, It's certainly is valid code.  And
> with that I can't drop the issue as a GCC code generation bug.
> 
> However it seems GCC itself doesn't seem to have a __multi3 in its
> libgcc2 - which indeed would be a GCC issue - at least none I was easily
> able to find with grep so I'm adding Matthew Fortune to cc in the hope he
> can shed some light on this.

Indeed, I don't see __multi3 implemented in libgcc in the source code,
but it's probably because it's tricky to see its implementation,
as it really is there:

$ ./bin/mips64el-linux-readelf -a ./mips64el-buildroot-linux-uclibc/sysroot/lib/libgcc_s.so.1 | grep multi3
  1747: 00011700   100 FUNC    GLOBAL DEFAULT   11 __multi3@@GCC_3.0
  5511: 00011700   100 FUNC    GLOBAL DEFAULT   11 __multi3
  000435e4 -32236(gp) 00011700 00011700 FUNC     11 __multi3

Objdump says:

00011700 <__multi3>:
   11700:       0006103e        dsrl32  v0,a2,0x0
   11704:       7c89f803        dext    a5,a0,0x0,0x20
   11708:       0004403e        dsrl32  a4,a0,0x0
   1170c:       7ccaf803        dext    a6,a2,0x0,0x20
   11710:       012a589c        dmul    a7,a5,a6
   11714:       010a509c        dmul    a6,a4,a6
   11718:       0122489c        dmul    a5,a5,v0
   1171c:       0102409c        dmul    a4,a4,v0
   11720:       012a482d        daddu   a5,a5,a6
   11724:       000b103e        dsrl32  v0,a7,0x0
   11728:       0049102d        daddu   v0,v0,a5
   1172c:       184a0003        bgeuc   v0,a6,1173c <.L2>
   11730:       24090001        li      a5,1
   11734:       0009483c        dsll32  a5,a5,0x0
   11738:       0109402d        daddu   a4,a4,a5

The same __multi3 problem also occurred on SPARC64, and they fixed it
by adding a __multi3 implementation in the kernel. See:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/sparc?id=1b4af13ff2cc6897557bb0b8d9e2fad4fa4d67aa.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
