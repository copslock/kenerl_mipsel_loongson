Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Dec 2017 12:51:11 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:49972 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990517AbdLVLvEzv2Nm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Dec 2017 12:51:04 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx27.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Fri, 22 Dec 2017 11:50:49 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 22 Dec
 2017 03:49:40 -0800
Date:   Fri, 22 Dec 2017 11:49:39 +0000
From:   James Hogan <james.hogan@mips.com>
To:     Yuri Frolov <crashing.kernel@gmail.com>
CC:     <linux-mips@linux-mips.org>, <paul.burton@mips.com>
Subject: Re: [P5600 && EVA memory caching question] PCI region
Message-ID: <20171222114938.GJ5027@jhogan-linux.mipstec.com>
References: <6132c323-32a7-1d38-b77c-a191be22faa4@gmail.com>
 <20171206114611.GM5027@jhogan-linux.mipstec.com>
 <330a5200-531f-fcfa-674a-c81fb3144e92@gmail.com>
 <20171214152138.GV5027@jhogan-linux.mipstec.com>
 <ca9adcbc-9777-46a0-ce0b-15e83e01fc72@gmail.com>
 <20171215232821.GA5027@jhogan-linux.mipstec.com>
 <b8706fae-aea8-99b5-f91d-37690eff6949@gmail.com>
 <20171221134119.GE5027@jhogan-linux.mipstec.com>
 <d4198e82-5658-1bce-8415-cfc9dee56336@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="a6YTfLRor63AaheO"
Content-Disposition: inline
In-Reply-To: <d4198e82-5658-1bce-8415-cfc9dee56336@gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1513943448-637137-14275-113100-2
X-BESS-VER: 2017.16-r1712182224
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.188257
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <James.Hogan@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61557
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@mips.com
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

--a6YTfLRor63AaheO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2017 at 02:18:26PM +0300, Yuri Frolov wrote:
> Sorry, I forgot to ask,
> > yes, the Malta implementation is slightly ugly as it relies on a
> > hardware physical memory alias of RAM starting at PA 0x80000000.
> any good docs about this hardware aliasing? I'm not sure I understand it=
=20
> correctly, just want to understand things right.

Basically it keeps kseg0 (seg3) and kseg1 (seg2) pointing at PA 0, which
it runs kernel code from (i.e. same place it is loaded, without the EVA
layout enabled yet), but then it does data accesses from seg4 and seg5
which point at PA 0x80000000. I think the intention is to allow the VA
to PA offset to be the same for all cached segments.

However because the caches don't know that different physical addresses
refer to the same underlying RAM they aren't coherent with one another
and the kernel has to be careful not to use both, and to flush the
caches during boot.

Its not an approach I would personally recommend, and if we get EVA
support added to the generic platform I'd hope it would be a lot
cleaner, perhaps using the since added kernel self-relocation.

Cheers
James


--a6YTfLRor63AaheO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlo88TEACgkQbAtpk944
dnqPeBAAjFOSVrrP3W/8C/ozlakf03d4e3a850O3hz+DJE7t7qaMCpkxhyQKEX7h
uWHfdcUAANmjb5VSHUt/Jr8/EDzkGlemiqriOZMMSYAB3IoJcgd2kqNziLR356bo
WY5Ya8b/SPRNYVuhm4Hhrrs4QxqeK20CNuVRMvYSfjL6hJJ5i6kWmbSILA57B4p1
UwdTqCPwcgiJ9FzV6/CxslcNEy+3hg6ekeK88KZz4zm36GAMlqdz2zCmaz2SK0GM
X42gvMSCmrXbmL30X1+mPEHOKT1DKnbhjbQR64L41GEu7Mz3OXzEsMte38Br9G2n
eZQAhvq9ooNwJHg1XaNemb3GpymAVLb05UZ8wxta6WjfXmpVahzxY+E045RqOp3I
AumN1m0f3gXc/wTPPoSCl5UmKnJgQqp48P/tlbddjR4mQmJuykG6SlmpAM+bswjf
+bw5ro4OwD2wOXg4L1nobKZxClPG2xEATUczJSYsNWIN03b8ECVuwC1om+p9swQp
qIKijPIHWZwpFxg6SncXKFOjUGg8JJ1rvh1l+uaZD0ner8OWxdVwr1yKJA0l9J5d
C9/4Cq6z5niLq4Cwx+wujAmHAEHBWHYouhr1iuP3iaM2RTMBtWk3xT3NSJqA8pcG
7zOg5JDbmOzmfeTVOO52SVksVv41QEy99es62LsPN/2WW58o1Wc=
=XyrG
-----END PGP SIGNATURE-----

--a6YTfLRor63AaheO--
