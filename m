Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Nov 2016 16:18:31 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:51197 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23991964AbcKGPSYwqaRw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Nov 2016 16:18:24 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id DF94841F8E31;
        Mon,  7 Nov 2016 15:17:14 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 07 Nov 2016 15:17:14 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 07 Nov 2016 15:17:14 +0000
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 1997991D74C7;
        Mon,  7 Nov 2016 15:18:16 +0000 (GMT)
Received: from np-p-burton.localnet (10.100.200.221) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 7 Nov
 2016 15:18:18 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 03/10] MIPS: End asm function prologue macros with .insn
Date:   Mon, 7 Nov 2016 15:18:13 +0000
Message-ID: <12999809.y5kg6YqSxt@np-p-burton>
Organization: Imagination Technologies
User-Agent: KMail/5.3.2 (Linux/4.8.4-1-ARCH; KDE/5.27.0; x86_64; ; )
In-Reply-To: <alpine.DEB.2.20.17.1611071400340.10580@tp.orcam.me.uk>
References: <20161107111417.11486-1-paul.burton@imgtec.com> <20161107111417.11486-4-paul.burton@imgtec.com> <alpine.DEB.2.20.17.1611071400340.10580@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2929313.q0WNSp2J4G";
        micalg=pgp-sha256; protocol="application/pgp-signature"
X-Originating-IP: [10.100.200.221]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55716
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

--nextPart2929313.q0WNSp2J4G
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Maciej,

On Monday, 7 November 2016 14:33:03 GMT Maciej W. Rozycki wrote:
>  As these macros can be used at such places too I think it makes sense to
> imply `.insn' with the macro itself so that it's semantically consistent
> rather than requiring people to explicitly place the pseudo-op at macro
> expansion sites as required.  I'm not sure if I indeed like the idea of
> placing EXPORT_SYMBOL in the middle of a code block, as I find it
> inconsistent with C usage where, by convention, it only comes at the end
> of a function's body.  That is a separate matter though, so for this
> change only:
> 
> Reviewed-by: Maciej W. Rozycki <macro@imgtec.com>
> 
>  Thank you for your work in this area!

And thanks for your review :)

For the record, the reason I went with placing the EXPORT_SYMBOL invocations 
at the start of the functions rather than the end is that the end isn't always 
the end of the code in question. For example (until another patch of mine) 
memcpy ends part way through user_copy, with code continuing afterwards. We 
would then need to place a .insn after the use of EXPORT_SYMBOL if any code 
may branch there. Containing the need for .insn to the start of the function 
seems neater since a function should always begin with an instruction, which 
after this patch will be marked as such, and users of the macros will just get 
behaviour that seems natural & expected.

Of course another alternative would be to place EXPORT_SYMBOL before LEAF/
NESTED/FEXPORT, but I don't think that would really make any difference  
presuming people agree that this patch is a good idea regardless.

Thanks,
    Paul
--nextPart2929313.q0WNSp2J4G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJYIJs1AAoJEIIg2fppPBxlhfoP/0V0D7tLGnX8Q7ZkA0KYqqle
gluhs3CRPj1yJTLr25k1Dtkzdis+oKdBpF4IvFSvTPMVHzooGzuaxKmFFsf7be/L
FrD62536t869ZjJl2OaCQjMQmsZxU8C4F8q4J0BPlv/2mHFf2qGjKfimAMoVKium
7HI1EHdJPL926O6OLH0DYFILQZHmutbYQj6o1SIZiJghXVnwiwMjMe/YWWyF23Nu
a9zcCqfiugUlOl7UGlr1u4gq2xujK+xS/a/BSOPRZZ4TJ3nErdE+RwIOLRsIRpw7
XfW4u7HUR3hm97tIwB8t7IpNSJxXFnFHpBvfuQVtQKCwXII2H8A1ZpYjJuLuZMPk
YUEXXm4A4MSYPv4nfVyqVcMNdWO/zUwR03iWmqFW37oPN3HeWfu6NAguYQYk2eXi
qCCePxHrivf346VyNXlkZiqKt1hwTLo5KI1fs+P1yr96aeCiVm/90iTuD6M86Ggi
4p/iNHTFZxiQ3K9AxK0ZndnYcfIxAeHwpdJG3EvDknRoSKqEASQdLBwKKQ9Dotvk
dcihk8ow7hr4tzhuRa+Do4cYQjwIGhCIN7WtS6zzM/uSU93i2Nab+UlmrCDub1Rt
6LI3Pk3SxR3jNBr1biziCDM3V0pFwmlL5EaZ3BalOgyXzLO9501AUeEcINNfNRGs
/v63O1l0hXRtiPziAo3G
=RNQ2
-----END PGP SIGNATURE-----

--nextPart2929313.q0WNSp2J4G--
