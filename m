Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Oct 2016 17:22:38 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:7594 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23991759AbcJQPW3Urxf4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Oct 2016 17:22:29 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id A1EEB41F8EC0;
        Mon, 17 Oct 2016 16:21:59 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.44.0.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 17 Oct 2016 16:21:59 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 17 Oct 2016 16:21:59 +0100
Received: from HHMAIL03.hh.imgtec.org (unknown [10.44.0.21])
        by Forcepoint Email with ESMTPS id F258072C4389;
        Mon, 17 Oct 2016 16:22:19 +0100 (IST)
Received: from HHMAIL01.hh.imgtec.org (10.100.10.19) by HHMAIL03.hh.imgtec.org
 (10.44.0.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 17 Oct 2016
 16:22:23 +0100
Received: from np-p-burton.localnet (10.100.200.11) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 17 Oct
 2016 16:22:22 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Fix build of compressed image
Date:   Mon, 17 Oct 2016 16:22:14 +0100
Message-ID: <19710051.vF94pmxeQo@np-p-burton>
Organization: Imagination Technologies
User-Agent: KMail/5.3.2 (Linux/4.7.6-1-ARCH; KDE/5.27.0; x86_64; ; )
In-Reply-To: <1476695379-1808-1-git-send-email-matt.redfearn@imgtec.com>
References: <1476695379-1808-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart18952760.Fkq5ozJLe9";
        micalg=pgp-sha256; protocol="application/pgp-signature"
X-Originating-IP: [10.100.200.11]
X-ESG-ENCRYPT-TAG: 1cc78754
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55461
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

--nextPart18952760.Fkq5ozJLe9
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, 17 October 2016 10:09:39 BST Matt Redfearn wrote:
> Changes introduced to arch/mips/Makefile for the generic kernel resulted
> in build errors when making a compressed image if platform-y has multiple
> values, like this:
> 
> make[2]: *** No rule to make target `alchemy/'.
> make[1]: *** [vmlinuz] Error 2
> make[1]: Target `_all' not remade because of errors.
> make: *** [sub-make] Error 2
> make: Target `_all' not remade because of errors.
> 
> Fix this by quoting $(platform-y) as it is passed to the Makefile in
> arch/mips/boot/compressed/Makefile
> 
> Reported-by: kernelci.org bot <bot@kernelci.org>
> Link:
> https://storage.kernelci.org/next/next-20161017/mips-gpr_defconfig/build.lo
> g Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
> 
> ---
> 
>  arch/mips/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> index fbf40d3c8123..1a6bac7b076f 100644
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

Hi Matt,

Reviewed-by: Paul Burton <paul.burton@imgtec.com>

Thanks,
    Paul
--nextPart18952760.Fkq5ozJLe9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJYBOymAAoJEIIg2fppPBxlAPsP/3VHTYQoOOc9/1ZzMh64tl3I
QSAHe+xqQtujJPLz2O3ThNJ+1okOE798ois4gn5RDauGFTCIPb9k/8gO0boaNUiE
Enc5J9HIuKcmIHspnDdAmTqxd7+Xoi3C6q50esCfTorKC4AlQNLJW8tQi2nPnVjd
86QYTBAoMlBgLC0kDqng/Cr/ukxSE3XZf54b5ZXs7IvOvoj9kM9+F321WJxvu0JY
GU1Na+T4QRLcThAo/BioHMl+Ll2MIMZZdfYq3rKXe6yenqCx/lmyTPoETwpPfU38
76qWjDYNdHHUve+ojGaPcjNjWPuvPqiSD/L4RXk/IJ34WmIDzukkH7vdm14G4uPT
hVfjD2CmMrC1i22J37Io4ZyRyX02w6uDFzYlMkDfIo14ONhzm6S6IkFmepx7y7wd
g8LEY7z6F2ClXGmNSPogves4IORVOK41u7Pz1M+8kftWtZsVzl6bpMk++saiDxU5
ixk1pUTmAIehXs6toLGvG9UyoZb4MRRlQxh63NwqU2yM2s0aczY7QvNylyfm5nij
VZWTbebT+dpNIwa1KzfQg7wvmxbIqhGjmT6J5gUqjaoAmQVX3tm1bx3z1Ibo4dlx
Xv1JPhaMsuq+f81UEb0KiGRrLlamkdKmmyMxgicsX6ezqmY5BfBOvi7bEsXUjnF3
AkoqopHl8vFu6diH4Kkw
=X9Hg
-----END PGP SIGNATURE-----

--nextPart18952760.Fkq5ozJLe9--
