Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Aug 2017 09:15:47 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:58514 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992241AbdHQHPhm80Ne (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 17 Aug 2017 09:15:37 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v7H7FZ49000607;
        Thu, 17 Aug 2017 09:15:35 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v7H7FYAf000606;
        Thu, 17 Aug 2017 09:15:34 +0200
Date:   Thu, 17 Aug 2017 09:15:34 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc:     Matthew Fortune <Matthew.Fortune@imgtec.com>,
        linux-mips@linux-mips.org, Waldemar Brodkorb <wbx@openadk.org>
Subject: Re: undefined reference to `__multi3' when building with gcc 7.x
Message-ID: <20170817071534.GH13257@linux-mips.org>
References: <20170803225547.6caa602b@windsurf.lan>
 <20170804000556.GC30597@linux-mips.org>
 <20170804151920.GA11317@linux-mips.org>
 <20170804174151.2eea9af3@windsurf.lan>
 <20170804222500.GA11675@linux-mips.org>
 <20170805135649.152b0739@windsurf>
 <20170807083448.GA20713@linux-mips.org>
 <20170813224602.25043e8a@windsurf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170813224602.25043e8a@windsurf>
User-Agent: Mutt/1.8.3 (2017-05-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59605
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

On Sun, Aug 13, 2017 at 10:46:02PM +0200, Thomas Petazzoni wrote:
> Date:   Sun, 13 Aug 2017 22:46:02 +0200
> From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> To: Ralf Baechle <ralf@linux-mips.org>
> Cc: Matthew Fortune <Matthew.Fortune@imgtec.com>,
>  linux-mips@linux-mips.org, Waldemar Brodkorb <wbx@openadk.org>
> Subject: Re: undefined reference to `__multi3' when building with gcc 7.x
> Content-Type: text/plain; charset=US-ASCII
> 
> Hello,
> 
> On Mon, 7 Aug 2017 10:34:48 +0200, Ralf Baechle wrote:
> 
> > > > Chances are it's something specific to MIPS64 R6.  Before trying your
> > > > config file I also tried a number of other defconfigs and all built
> > > > well.
> > > > 
> > > > Here's a test case which generates a reference to __multi3:
> > > > 
> > > > unsigned long func(unsigned long a, unsigned long b)
> > > > {
> > > >         return a > (~0UL) / b;
> > > > }
> > > > 
> > > > GCC rearanges above statement to:
> > > > 
> > > > 	return (unsigned __int128)a * (unsigned __int128) b > 0xffffffff;  
> > > 
> > > And this is normal/expected ?  
> > 
> > Without consideration of performance, It's certainly is valid code.  And
> > with that I can't drop the issue as a GCC code generation bug.
> > 
> > However it seems GCC itself doesn't seem to have a __multi3 in its
> > libgcc2 - which indeed would be a GCC issue - at least none I was easily
> > able to find with grep so I'm adding Matthew Fortune to cc in the hope he
> > can shed some light on this.
> 
> Indeed, I don't see __multi3 implemented in libgcc in the source code,
> but it's probably because it's tricky to see its implementation,
> as it really is there:
> 
> $ ./bin/mips64el-linux-readelf -a ./mips64el-buildroot-linux-uclibc/sysroot/lib/libgcc_s.so.1 | grep multi3
>   1747: 00011700   100 FUNC    GLOBAL DEFAULT   11 __multi3@@GCC_3.0
>   5511: 00011700   100 FUNC    GLOBAL DEFAULT   11 __multi3
>   000435e4 -32236(gp) 00011700 00011700 FUNC     11 __multi3
> 
> Objdump says:
> 
> 00011700 <__multi3>:
>    11700:       0006103e        dsrl32  v0,a2,0x0
>    11704:       7c89f803        dext    a5,a0,0x0,0x20
>    11708:       0004403e        dsrl32  a4,a0,0x0
>    1170c:       7ccaf803        dext    a6,a2,0x0,0x20
>    11710:       012a589c        dmul    a7,a5,a6
>    11714:       010a509c        dmul    a6,a4,a6
>    11718:       0122489c        dmul    a5,a5,v0
>    1171c:       0102409c        dmul    a4,a4,v0
>    11720:       012a482d        daddu   a5,a5,a6
>    11724:       000b103e        dsrl32  v0,a7,0x0
>    11728:       0049102d        daddu   v0,v0,a5
>    1172c:       184a0003        bgeuc   v0,a6,1173c <.L2>
>    11730:       24090001        li      a5,1
>    11734:       0009483c        dsll32  a5,a5,0x0
>    11738:       0109402d        daddu   a4,a4,a5

I happened to have a GCC build dir around so I greped for __multi3 and
found it hiding in muldi3.o.

Maybe that'obvious for those in the know, not me :)  Also that .o file
contained MIPS III code and I was able to get GCC to emit a reference
to __multi3 for MIPS III or MIPS64R1 targets, so version of __multi3
even seems unused.

  Ralf
