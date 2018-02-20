Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Feb 2018 23:26:31 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:33486 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994692AbeBTW0YDwVg5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Feb 2018 23:26:24 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx3.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 20 Feb 2018 22:26:01 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 20 Feb
 2018 14:25:44 -0800
Date:   Tue, 20 Feb 2018 22:25:42 +0000
From:   James Hogan <james.hogan@mips.com>
To:     "Maciej W. Rozycki" <macro@mips.com>
CC:     Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        <linux-mips@linux-mips.org>, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Subject: Re: [PATCH V2 08/12] MIPS: Align kernel load address to 64KB
Message-ID: <20180220222542.GF29460@jhogan-linux.mipstec.com>
References: <1517022752-3053-1-git-send-email-chenhc@lemote.com>
 <1517023336-17575-1-git-send-email-chenhc@lemote.com>
 <1517023336-17575-2-git-send-email-chenhc@lemote.com>
 <20180219230719.GC6245@saruman>
 <alpine.DEB.2.00.1802202206490.3553@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Pgaa2uWPnPrfixyx"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1802202206490.3553@tp.orcam.me.uk>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1519165560-298554-4207-8796-4
X-BESS-VER: 2018.2-r1802152108
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.01
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.190239
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.01 BSF_SC0_SA_TO_FROM_DOMAIN_MATCH META: Sender 
        Domain Matches Recipient Domain 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.01 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_SC0_SA_TO_FROM_DOMAIN_MATCH, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <James.Hogan@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62661
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

--Pgaa2uWPnPrfixyx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2018 at 10:14:39PM +0000, Maciej W. Rozycki wrote:
> On Mon, 19 Feb 2018, James Hogan wrote:
>=20
> > > KEXEC assume kernel align to PAGE_SIZE, and 64KB is the largest
> > > PAGE_SIZE.
> >=20
> > Please expand, maybe referring to sanity_check_segment_list() which does
> > the actual check. Maybe something like this:
> >=20
> >  Kexec needs the new kernel's load address to be aligned on a page
> >  boundary (see sanity_check_segment_list()), but on MIPS the default
> >  vmlinuz load address is only explicitly aligned to 16 bytes.
> >=20
> >  Since the largest PAGE_SIZE supported by MIPS kernels is 64KB, increase
> >  the alignment calculated by calc_vmlinuz_load_addr to 64KB.
>=20
>  But why does it have to be hardcoded?  Shouldn't it be inherited from=20
> the image being loaded?  I'm missing bits of context here, but that=20
> would be either CONFIG_PAGE_SIZE_* settings or the ELF program header's=
=20
> `p_align' value, depending on how this code operates.  Wasting say 60kB=
=20
> of memory on smaller systems due to excessive alignment might not be a=20
> good idea.

I presume there's nothing to stop a kernel with 64KB pages (and hence
requiring 64KB alignment of load sections) loading a new kernel with 4KB
pages (which is the one we're looking at).

Cheers
James

--Pgaa2uWPnPrfixyx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqMoGYACgkQbAtpk944
dno25A//XtsxH5AbHEFymyrh43gEVCe/2gtNsVDTPH0eg9zrSo538G57eFCFjsCI
uABuJLoFUsf4cFz2OthP1JHMcRpns/meJIbEKBNpTuTBr56ofhPyCc6jSgSEoTYW
4/fhF4hoZXLw4MHeC3sBkmZBKzeLkDIyJULBdq4Gud1BA/QIDMNqUadhJZeBncja
vpu6v4vLVnC0BNiFxNVcA5Kj9joHv+PwV0wUhU98vYj+f1ux4HrUs9sJ7TDMoQrG
qm/xO8vyaQfFES2r4YTLXHUmQmOMHSP5NNudebU9fBSvlR52QzC8+8j/qYhlxOs3
oGCHVkafbD5bIXPQAx1woAFDef+7x8D/GT9NGNurLLyDzJGuk30CsGoX1lKfWJrx
LKPs67FR76Ak17wiPFBHPyb9VjV+sz1o41LaaMoKIJ10KZQNXSh7biGdM1DF0bgA
ic+ztcHelXAJCw4oE0/QIBBZav3ATk/GhiCsEHc2njaYWjsA6BwuYA+iXuA3PC2o
mWoCadJWEWWGN9WATTqUWw065s1WvDd3XItJow5lFVSeH3CFyx/1bMi1iVnrDc3m
yWYDxmnR7/qgKwANSc5Pf+SW/WuBfsi5QKL+i8TLJa9s3i2Aks1jkmMbyVWa9fPd
Q8lPyIBWwp4+gRuMdlwY0GNHQ9oy0oiQoQJWsHleLCfrlaJz0Fs=
=G/mW
-----END PGP SIGNATURE-----

--Pgaa2uWPnPrfixyx--
