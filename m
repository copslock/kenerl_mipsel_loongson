Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Oct 2016 16:29:31 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:17170 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23990644AbcJYO3Xwj1Sh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Oct 2016 16:29:23 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id D10BB41F8DF9;
        Tue, 25 Oct 2016 15:28:38 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 25 Oct 2016 15:28:38 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 25 Oct 2016 15:28:38 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 7326C53C29146;
        Tue, 25 Oct 2016 15:29:14 +0100 (IST)
Received: from np-p-burton.localnet (10.100.200.225) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 25 Oct
 2016 15:29:17 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     Manuel Lauss <manuel.lauss@gmail.com>
CC:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS: fix build with multiple PLATFORM strings
Date:   Tue, 25 Oct 2016 15:29:12 +0100
Message-ID: <1949974.ncqLyGp0zq@np-p-burton>
Organization: Imagination Technologies
User-Agent: KMail/5.3.2 (Linux/4.8.4-1-ARCH; KDE/5.27.0; x86_64; ; )
In-Reply-To: <20161025141205.244177-1-manuel.lauss@gmail.com>
References: <20161025141205.244177-1-manuel.lauss@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1996882.b33A4RGjNs";
        micalg=pgp-sha256; protocol="application/pgp-signature"
X-Originating-IP: [10.100.200.225]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55571
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

--nextPart1996882.b33A4RGjNs
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, 25 October 2016 16:12:05 BST Manuel Lauss wrote:
> Commit cf2a5e0bb (MIPS: Support generating Flattened Image Trees (.itb))
> broke my alchemy devboard build, because it uses more than one entry
> in the PLATFORM variable:
> 
> make -f kernel/linux/scripts/Makefile.build obj=arch/mips/boot/compressed \
>         VMLINUX_LOAD_ADDRESS=[..] PLATFORM=alchemy/common/
> alchemy/devboards/ [..] vmlinuz make[2]: *** No rule to make target
> 'alchemy/devboards/'.  Stop.
> make[1]: *** [arch/mips/Makefile:371: vmlinuz] Error 2
> 
> Fix this by wrapping the platform-y expansion in quotes.

Hi Manuel,

This same fix was already submitted 8 days ago:

https://patchwork.linux-mips.org/patch/14405/

Thanks,
    Paul

> 
> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
> ---
>  arch/mips/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> index fbf40d3..1a6bac7 100644
> --- a/arch/mips/Makefile
> +++ b/arch/mips/Makefile
> @@ -263,7 +263,7 @@ KBUILD_CPPFLAGS += -DDATAOFFSET=$(if
> $(dataoffset-y),$(dataoffset-y),0)
> 
>  bootvars-y	= VMLINUX_LOAD_ADDRESS=$(load-y) \
>  		  VMLINUX_ENTRY_ADDRESS=$(entry-y) \
> -		  PLATFORM=$(platform-y)
> +		  PLATFORM="$(platform-y)"
>  ifdef CONFIG_32BIT
>  bootvars-y	+= ADDR_BITS=32
>  endif


--nextPart1996882.b33A4RGjNs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJYD2w4AAoJEIIg2fppPBxlkHQP/20JLXeWX9hExeBVpZnL364h
UXz3LyVT7L5fC091GA8u4ZTJi7Hd81VIPDml1MqTnVbP2W9Gvh7GjQ837PMMnsXq
O5AQwVnsW3IlA7768RwVg5vBLcsd0kgMPtynZHiXfvNWvrSATCoLvfcID+HhfIB/
LTN/O03NWUXieQ9Tq/dqQvczReLkTSOm5W7XYYAuSrekSyv0MuZpTOQ0Hg/fGtam
lOMDmPLBmuz8yWdqTyfig09PWwyuQMykgxztPmuSzoeA4f6VCfB5tegx/SyS4uEL
oo09bU3tKTnMyzc/8YYj6NKJ7a+ugx/Esv5dkm83ssagrFYGT3RaAPegLg0eJlxW
IOa7EhulBITPzqmEaAPjOz/0gDu61esHjf+rVgKJ5ONNDvXv/L/Ptoevlui2q6El
27YC/f3FijwdWAGxnyIuHSc3ltoIW0z0AT7FLEwhhd3O6kRgOGKV9YPISCRWiLFK
6676/AQGMSUiDLMHAEGMfhBPelUGqICNGd3bNG89VXoXCMrsaqfykyLmbkGbD3pX
DGiAmNI2xkhS4WgWYBKGk1aWMVS5XIogB+LIeQl9TcSjW358LF875tWZAJqzqpC2
O08A0XdWQqz+vjsWd3DP032QoQgiYY1uEicKsFbE9jhiqpWtpnqkMlkTTHMDib2M
nw8XN2+gAEeDR6isUHFu
=6alZ
-----END PGP SIGNATURE-----

--nextPart1996882.b33A4RGjNs--
