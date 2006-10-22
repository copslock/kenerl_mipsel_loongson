Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Oct 2006 22:06:59 +0100 (BST)
Received: from [82.232.2.251] ([82.232.2.251]:20937 "EHLO farad.aurel32.net")
	by ftp.linux-mips.org with ESMTP id S20038636AbWJVVG6 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 22 Oct 2006 22:06:58 +0100
Received: from bode.aurel32.net ([2001:618:400:fc13:211:9ff:feed:c498] helo=[IPv6:2001:618:400:fc13:211:9ff:feed:c498])
	by farad.aurel32.net with esmtps (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1GbkWj-000563-G9; Sun, 22 Oct 2006 23:06:37 +0200
Message-ID: <453BDC78.5080700@aurel32.net>
Date:	Sun, 22 Oct 2006 23:02:48 +0200
From:	Aurelien Jarno <aurelien@aurel32.net>
User-Agent: Thunderbird 1.5.0.7 (X11/20060927)
MIME-Version: 1.0
To:	qemu-devel@nongnu.org
CC:	linux-mips@linux-mips.org
Subject: Re: [Qemu-devel] [PATCH] MIPS: add support for cvt.s.d and cvt.d.s
References: <20060928234505.GA8305@bode.aurel32.net>
In-Reply-To: <20060928234505.GA8305@bode.aurel32.net>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13054
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

Hi all,

The patch below has been posted 3 weeks ago, but I haven't received any 
comment yet. If you need to be convinced that the patch is needed, you 
can download a test case from http://temp.aurel32.net/test_cvt.tar.gz 
made using files from Debian unstable:

[bode:/tmp]$ tar xvfz test_cvt.tar.gz
test_cvt/
test_cvt/bin/
test_cvt/bin/find
test_cvt/etc/
test_cvt/etc/ld.so.cache
test_cvt/lib/
test_cvt/lib/ld.so.1
test_cvt/lib/libc.so.6
[bode:/tmp]$ cd test_cvt/
[bode:/tmp/test_cvt]$ qemu-mips.orig -L $PWD bin/find
qemu: uncaught target signal 4 (Illegal instruction) - exiting
[bode:/tmp/test_cvt]$ qemu-mips -L $PWD bin/find
.
./lib
./lib/libc.so.6
./lib/ld.so.1
./etc
./etc/ld.so.cache
./bin
./bin/find

qemu-mips.orig is the qemu binary without the patch, qemu-mips is the 
qemu binary with the patch.

Could somebody please have a look to the patch (or even merge it)?

Thanks,
Aurelien


Aurelien Jarno a écrit :
> Hi,
> 
> The patch below implements the cvt.s.d and cvt.d.s instructions for the
> mips target. They are need to be able to execute the cp and the find
> programs.
> 
> Bye,
> Aurelien
> 
> 
> Index: target-mips/op.c
> ===================================================================
> RCS file: /sources/qemu/qemu/target-mips/op.c,v
> retrieving revision 1.9
> diff -u -r1.9 op.c
> --- target-mips/op.c	26 Jun 2006 20:29:47 -0000	1.9
> +++ target-mips/op.c	28 Sep 2006 23:42:30 -0000
> @@ -785,12 +785,24 @@
>  
>  #define FLOAT_OP(name, p) void OPPROTO op_float_##name##_##p(void)
>  
> +FLOAT_OP(cvtd, s)
> +{
> +    FDT2 = float32_to_float64(WT0, &env->fp_status);
> +    DEBUG_FPU_STATE();
> +    RETURN();
> +}
>  FLOAT_OP(cvtd, w)
>  {
>      FDT2 = int32_to_float64(WT0, &env->fp_status);
>      DEBUG_FPU_STATE();
>      RETURN();
>  }
> +FLOAT_OP(cvts, d)
> +{
> +    FST2 = float64_to_float32(WT0, &env->fp_status);
> +    DEBUG_FPU_STATE();
> +    RETURN();
> +}
>  FLOAT_OP(cvts, w)
>  {
>      FST2 = int32_to_float32(WT0, &env->fp_status);
> Index: target-mips/translate.c
> ===================================================================
> RCS file: /sources/qemu/qemu/target-mips/translate.c,v
> retrieving revision 1.15
> diff -u -r1.15 translate.c
> --- target-mips/translate.c	26 Jun 2006 20:02:45 -0000	1.15
> +++ target-mips/translate.c	28 Sep 2006 23:42:30 -0000
> @@ -1675,6 +1675,13 @@
>          GEN_STORE_FTN_FREG(fd, WT2);
>          opn = "ceil.w.d";
>          break;
> +    case FOP(33, 16): /* cvt.d.s */
> +        CHECK_FR(ctx, fs | fd);
> +        GEN_LOAD_FREG_FTN(WT0, fs);
> +        gen_op_float_cvtd_s();
> +        GEN_STORE_FTN_FREG(fd, DT2);
> +        opn = "cvt.d.s";
> +        break;
>      case FOP(33, 20): /* cvt.d.w */
>          CHECK_FR(ctx, fs | fd);
>          GEN_LOAD_FREG_FTN(WT0, fs);
> @@ -1782,6 +1789,13 @@
>          GEN_STORE_FTN_FREG(fd, WT2);
>          opn = "trunc.w.s";
>          break;
> +    case FOP(32, 17): /* cvt.s.d */
> +        CHECK_FR(ctx, fs | fd);
> +        GEN_LOAD_FREG_FTN(WT0, fs);
> +        gen_op_float_cvts_d();
> +        GEN_STORE_FTN_FREG(fd, WT2);
> +        opn = "cvt.s.d";
> +        break;
>      case FOP(32, 20): /* cvt.s.w */
>          CHECK_FR(ctx, fs | fd);
>          GEN_LOAD_FREG_FTN(WT0, fs);


-- 
   .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
  : :' :  Debian developer           | Electrical Engineer
  `. `'   aurel32@debian.org         | aurelien@aurel32.net
    `-    people.debian.org/~aurel32 | www.aurel32.net
