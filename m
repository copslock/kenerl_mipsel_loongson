Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Feb 2018 23:59:23 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:40860 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994692AbeBTW7QVk7j5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Feb 2018 23:59:16 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1412.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 20 Feb 2018 22:58:55 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 20 Feb
 2018 14:58:48 -0800
Date:   Tue, 20 Feb 2018 22:58:46 +0000
From:   James Hogan <james.hogan@mips.com>
To:     "Maciej W. Rozycki" <macro@mips.com>
CC:     Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        <linux-mips@linux-mips.org>, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Subject: Re: [PATCH V2 08/12] MIPS: Align kernel load address to 64KB
Message-ID: <20180220225845.GG29460@jhogan-linux.mipstec.com>
References: <1517022752-3053-1-git-send-email-chenhc@lemote.com>
 <1517023336-17575-1-git-send-email-chenhc@lemote.com>
 <1517023336-17575-2-git-send-email-chenhc@lemote.com>
 <20180219230719.GC6245@saruman>
 <alpine.DEB.2.00.1802202206490.3553@tp.orcam.me.uk>
 <20180220222542.GF29460@jhogan-linux.mipstec.com>
 <alpine.DEB.2.00.1802202249410.3553@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PpAOPzA3dXsRhoo+"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1802202249410.3553@tp.orcam.me.uk>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1519167532-452060-16015-12713-3
X-BESS-VER: 2018.2.1-r1802152107
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.01
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.190241
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
X-archive-position: 62663
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

--PpAOPzA3dXsRhoo+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2018 at 10:53:19PM +0000, Maciej W. Rozycki wrote:
> On Tue, 20 Feb 2018, James Hogan wrote:
>=20
> > > >  Since the largest PAGE_SIZE supported by MIPS kernels is 64KB, inc=
rease
> > > >  the alignment calculated by calc_vmlinuz_load_addr to 64KB.
> > >=20
> > >  But why does it have to be hardcoded?  Shouldn't it be inherited fro=
m=20
> > > the image being loaded?  I'm missing bits of context here, but that=
=20
> > > would be either CONFIG_PAGE_SIZE_* settings or the ELF program header=
's=20
> > > `p_align' value, depending on how this code operates.  Wasting say 60=
kB=20
> > > of memory on smaller systems due to excessive alignment might not be =
a=20
> > > good idea.
> >=20
> > I presume there's nothing to stop a kernel with 64KB pages (and hence
> > requiring 64KB alignment of load sections) loading a new kernel with 4KB
> > pages (which is the one we're looking at).
>=20
>  As I say, I'm missing bits of context.  If you say that a 64kiB-page=20
> kernel loads a 4kiB-page kernel, then the alignment for the latter is=20
> obviously 4kiB.  So I repeat my question: why hardcode the alignment to=
=20
> 64kiB while we only need 4kiB in this case?

Because its the 1st kernel which is doing the kexec'ing of the 2nd
kernel. The 2nd kernel might not even have kexec enabled, but you still
might want to boot it using kexec.

The only alternative is for the kexec userland tools to be able to
automatically adjust the load segments to load a bit more before the
start of the kernel image so that its aligned, and i'm not sure how
universally safe that would be.

Cheers
James

--PpAOPzA3dXsRhoo+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqMqCUACgkQbAtpk944
dnoReQ//bBnMVurSWEYMcJ0owqonmERnm+5CGtmIUFTAZLzeeMAnu38gxUZEmGDk
pjM20k9/9JaJY41WhC6D7ciI/HrAeowCw9c0Vj4/o2SlTYcj5VqV0IO/HdMZ1yZR
xE7zpsH+/uv064SjVSeJnqUqwEoQUkr9QyKuYJ2AWLDpLoQriDb2otJZ/KtHnDGr
bFqz+HJUekbotbUPjcRj1HYO+aQPXGXSW81X7HzMEQY+LCji6zrTpF5kRb2pOU4k
rG1apTiG5Be06qQ0o8O8JrIvIVWKAP/sfw/BgxbHLe1KII4TOG4n5hcxdDnAxRze
rKlUatz4ZJPGlC/BUqbPOUBi3TsbkcPdCJQ6lcfRiFfDaKT2mZ4gucGMta9HmhAo
e57siAmJhEeykiAD/k9NoJFmWhWHETzBaTsCWMMloM97jlwamq4RStwkskFP6HMf
tGqPfiYoOxOtueAiTQ07aidBqrwqb8nl56PQ702v0MyVs/v/QxCBt+YlxWqPgKto
08au/TJBICbXgyXlOyC7Rj5gxnKWcMG9oxx7utiHHF5pyNSJniZmp1AZgb8kjJOH
XC3EGa2XvYHovCb1aoPs/VB5ZtANmm6wMJby/9WPM+Tkk7ksPMvwWT+S1GPaoQ2Q
cYLR5Mox0IUwYk13LeTxQdSaT+De+r6wvpi0pjZs/yD5/kIOqoQ=
=Yk6l
-----END PGP SIGNATURE-----

--PpAOPzA3dXsRhoo+--
