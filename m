Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 May 2014 23:25:10 +0200 (CEST)
Received: from [217.156.133.130] ([217.156.133.130]:58724 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-FAIL-FAIL-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6836419AbaEMVZDYCqfL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 May 2014 23:25:03 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 7D60741F8E33
        for <linux-mips@linux-mips.org>; Tue, 13 May 2014 22:24:57 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 13 May 2014 22:24:57 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 13 May 2014 22:24:57 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 7B4C8CB805CCC
        for <linux-mips@linux-mips.org>; Tue, 13 May 2014 22:24:53 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Tue, 13 May 2014 22:24:57 +0100
Received: from localhost (192.168.154.79) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.174.1; Tue, 13 May
 2014 22:24:56 +0100
Date:   Tue, 13 May 2014 22:24:56 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     <matthew.fortune@imgtec.com>
Subject: O32 FPXX ABI
Message-ID: <20140513212456.GQ34353@pburton-linux.le.imgtec.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZqRzwd/9tauJXEMK"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.79]
X-ESG-ENCRYPT-TAG: 96d62635
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40098
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

--ZqRzwd/9tauJXEMK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi all,

I just wanted to bring to the attention of the list the O32 FPXX ABI
proposal:

  https://dmz-portal.mips.com/wiki/MIPS_O32_ABI_-_FR0_and_FR1_Interlinking

This is the proposal that I mentioned in commit 06e2e88292e9 "MIPS: mark
O32+FP64 experimental for now". The goal is to reduce fragmentation of
the O32 ABI whilst allowing use of 64b FP registers (Status.FR=1) and
the MIPS SIMD Architecture (MSA) which requires them.

It removes the need for the EF_MIPS_FP64 flag and instead produces code
which can safely be linked with existing FP32 binaries until such time
as a new FP64-using binary becomes involved (either by being the
executable or a linked shared library). That is, it preserves
compatibility with existing binaries whilst allowing a gradual migration
towards an FPXX/FP64 world. The proposal has been discussed on the GCC
development mailing list:

  http://gcc.1065356.n5.nabble.com/RFC-Introducing-MIPS-O32-ABI-Extension-for-FR0-and-FR1-Interlinking-td1013453.html

As it affects the kernel too, now would be a good time to raise any
comments or suggestions. I have written patches to implement the
requirements in the kernel (handling .MIPS.abiflags, currently emulated
UFR support, HWCAP flags) and will post them to the list once discussion
about O32 FPXX settles down, or sooner as an RFC if people are
interested in that.

Thanks,
    Paul

--ZqRzwd/9tauJXEMK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJTco2oAAoJEIIg2fppPBxlmfUP/2NB9ZK84oykYscG/A62UGli
+sUO1WcxiybCNxHlvlKMEJMXIJH4UmkXEYKcnYUMnCQIUlPyt33NdljtV0sd0Y2X
E26Y8w3XyndDEl5UcrcVBFUu0d324/LLgOmpYH7+JY5W/4TYhnDNgh9otlOlnYKG
2bkCnf+urfLX2vJbLVhrsy7t2Vaa84AE/04fjbUeVnvxo8OVo9Nz9nXubdB3MmzF
dkvjbqhrtLSBBotLBHBB+NKovss1kK5pPnWVUMTAzw/iKbYcF972e4GMDDtf1ZX4
Ub/dtIeRXMCwbUEMNXLrASGRTyPUf++nBBdzwTCA5QUZU/Ii5M9/nHpk2ThKO04O
KzH0YUCwa/tichKzunZ/6w8P+1DH1IMPuvuU+4+9T05Ant70+ZeQ6SQag7mqS/HM
jJA+fyUTRuwy4KTbFOQJMubWt5zkSMQbEEg+p3pE00UgF8G64VAe05hSSx/v+aRP
GHYV5IOJep+uaf6SaA7esS8LUmJgYqnx+OIxYjemU1w95ZgEHC/y+/e/OXnyylRc
Pg6t1ylr7oWxSuFvuVE9l9vdDd0wEa5ddPWBvpstMsb9WfN6a93D1kZh1XTDTq2w
Nh1Ghfk4LO3XehuU/DYeqo9Cx6cvSeizc5mAj/RkJR2d9BBWQKjuJOV/pZEzTXCz
xAk+YbeUzcNBxyPiP4qL
=dk5z
-----END PGP SIGNATURE-----

--ZqRzwd/9tauJXEMK--
