Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Aug 2004 13:06:02 +0100 (BST)
Received: from skl1.ukl.uni-freiburg.de ([IPv6:::ffff:193.196.199.1]:44184
	"EHLO relay1.uniklinik-freiburg.de") by linux-mips.org with ESMTP
	id <S8224929AbUHRMF4>; Wed, 18 Aug 2004 13:05:56 +0100
Received: from ktl77.ukl.uni-freiburg.de (ktl77.ukl.uni-freiburg.de [193.196.226.77])
	by relay1.uniklinik-freiburg.de (Email) with ESMTP
	id 1F2012F314; Wed, 18 Aug 2004 14:05:50 +0200 (CEST)
From: Max Zaitsev <maksik@gmx.co.uk>
Organization: Mutella Dev co.
To: "Kaj-Michael Lang" <milang@tal.org>
Subject: Re: O2 arcboot 32-bit kernel boot fix
Date: Wed, 18 Aug 2004 14:05:53 +0200
User-Agent: KMail/1.6.2
References: <001401c483b8$51d289f0$54dc10c3@amos>
In-Reply-To: <001401c483b8$51d289f0$54dc10c3@amos>
Cc: <linux-mips@linux-mips.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200408181405.53977.maksik@gmx.co.uk>
Return-Path: <maksik@gmx.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5672
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maksik@gmx.co.uk
Precedence: bulk
X-list: linux-mips

Hi,

good news, but I cannot test your fix because I'm not able to compile a 
working arcboot binary. I've tried self-compilation with cgg 3.3 and 3.4 and 
neither worked (the binary was about 500K large and did nothing). I've tried 
cross-compilation, but it did not complete. The only working binary I was 
able to acquire was unpacked from the debian package. But kernel crashed with 
that anyways (I've tried only 64-bit kernels so far).

It would be very helpfull for me if you could enlighten me with the 
instructions to compile arcboot: which gcc version should I use and which 
tricks shall I apply to get it to compile. Or you may just send me the binary 
(or put it out on your Internet site). Or you can do both :-))

Regards,
Max

On Monday 16 August 2004 19:41, Kaj-Michael Lang wrote:
> Hi
>
> Played with arcboot today and fixed (for me atleast) loading of 32-bit
> kernels.
> I've also added a very simple progress thing so you know something is
> happening when
> the kernel is loaded.
> Anyway, the patch can be found here:
> http://fairytale.tal.org/pub/talinux/patches/arcboot-O2boot-and-progress.pa
>tch
>
> The fix was quite simple, arcboot was loading the kernel over itself, the
>  -	.base     = 0x80004000,
> +	.base     = 0x80002000,
>
> change is the actual fix. 64-bit kernels loads fine after the fix.
>
> There is some extra stuff (a patch from gentoo, removal debuging from e2fs
> lib, etc) too..
