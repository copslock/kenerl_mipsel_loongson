Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Apr 2006 11:16:28 +0100 (BST)
Received: from pproxy.gmail.com ([64.233.166.176]:25444 "EHLO pproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133480AbWD0KQQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 27 Apr 2006 11:16:16 +0100
Received: by pproxy.gmail.com with SMTP id d80so2085646pyd
        for <linux-mips@linux-mips.org>; Thu, 27 Apr 2006 03:16:15 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Tqfa/nj+DDVtbkbljGces7tW9QMLZQhmyMPmSywTn2RyMdSgdAcStaCVvM8Jt8dFNTyzCxppHuTnR7Q1jJ0YxU++vNxgxVf9vtJupzGeBiygfaBHI+pGgWuyLRpVkerzm/Bo1n7Cr7hnQaMXeyQPurdot97fWVhBIehHUDKwOlM=
Received: by 10.35.37.18 with SMTP id p18mr1123880pyj;
        Thu, 27 Apr 2006 03:16:15 -0700 (PDT)
Received: by 10.35.60.20 with HTTP; Thu, 27 Apr 2006 03:16:15 -0700 (PDT)
Message-ID: <3857255c0604270316h30bd675fv2d47b48549f3966e@mail.gmail.com>
Date:	Thu, 27 Apr 2006 15:46:15 +0530
From:	"Shyamal Sadanshio" <shyamal.sadanshio@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>,
	"Nigel Stephens" <nigel@mips.com>
Subject: Re: Crosstools for MALTA MIPS in little endian
Cc:	linux-mips@linux-mips.org
In-Reply-To: <3857255c0604262339p3fd8c53fy50d70cf898d7b6c6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <3857255c0604210808y1208045by3449b003b4b2ffea@mail.gmail.com>
	 <4448F638.9060502@mips.com>
	 <3857255c0604260145i65356e12w89c6667756cddd3c@mail.gmail.com>
	 <20060426221254.GA21670@linux-mips.org>
	 <3857255c0604262339p3fd8c53fy50d70cf898d7b6c6@mail.gmail.com>
Return-Path: <shyamal.sadanshio@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11222
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shyamal.sadanshio@gmail.com
Precedence: bulk
X-list: linux-mips

Hi All,

To further to add on to info and to bring one point to notice,
I had build my kernel with SDE toolset (gcc version 3.4.4
mipssde-6.02.03-20050629) and binutils 2.15.94 (for e.g., GNU objcopy
2.15.94 mipssde-6.02.03-20050629)
It is mentioned on SDE site, that the SDE package will only install
compiler but I found that it installed binutils package also.

I am going to try with binutils 2.16 and lets see if it helps.

Thanks and Regards,
Shyamal




On 4/27/06, Shyamal Sadanshio <shyamal.sadanshio@gmail.com> wrote:
> Hi Nigel, Ralf,
>
> Yes, I'm using the default config with option set to R1 processor.
> I am using NFS filesystem and loading the image through ethernet using
> minicom.
>
> Here's the sequence:
>   Start NFS service
>   load tftp://192.168.2.237/vmlinux.srec
>   go .nfsroot=192.168.2.237/linux/mipsel ip=192.168.2.24
>
> Here's the YAMON boot message:
> NUX started...
> Config serial console: console=ttyS0,38400n8r
>
> * Exception (user) : Breakpoint *
> CAUSE    = 0x10808024  STATUS   = 0x10002c02
> CONFIG   = 0x80030083  CONFIG1  = 0x1e9b4d8a
> EPC      = 0x80549830  ERROREPC = 0x80029cf4
> BADVADDR = 0xffffffff  HI       = 0x00000000
> LO       = 0x04000000
>
> $ 0(zr):0x00000000  $ 8(t0):0x804c18dc  $16(s0):0x8056d0b8
> $24(t8):0x804bfddd
> $ 1(at):0x10002c00  $ 9(t1):0x0000007f  $17(s1):0x80490000
> $25(t9):0x80571f77
> $ 2(v0):0xffffffff  $10(t2):0x00000040  $18(s2):0x80570000
> $26(k0):0x00000000
> $ 3(v1):0xffffffe1  $11(t3):0x80570000  $19(s3):0x8056d0bc
> $27(k1):0x00000000
> $ 4(a0):0x00000040  $12(t4):0x80570000  $20(s4):0x00000000
> $28(gp):0x804be000
> $ 5(a1):0x00000000  $13(t5):0x00000000  $21(s5):0x804bffc0
> $29(sp):0x804bff50
> $ 6(a2):0x08000000  $14(t6):0x80571b91  $22(s6):0x00000000
> $30(s8):0x8009e0c0
> $ 7(a3):0xbbe00000  $15(t7):0x00000010  $23(s7):0x00000000
> $31(ra):0x8054b22c
>
> I have attached my config file along with this mail.
>
> Thanks and Regards,
> Shyamal
>
>
> On 4/27/06, Ralf Baechle <ralf@linux-mips.org> wrote:
> > On Wed, Apr 26, 2006 at 02:15:29PM +0530, Shyamal Sadanshio wrote:
> >
> > > I am facing boot problem with the Malta specific 2.6.12-rc6 kernel.
> > > The kernel is not booting up on our Malta 4kc development board.
> > > I do not see any error messages on the minicom window.
> >
> > In case you're using the default configuration file, it's set to
> > MIPS32R1 but the 4Kc is an R1 processor.  Are you sure you really have a
> > 4Kc and not a 4Kec?  The latter is an R2 processor.
> >
> >   Ralf
> >
>
>
