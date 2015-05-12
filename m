Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 May 2015 14:29:18 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:36024 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27012536AbbELM3RZk-bZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 May 2015 14:29:17 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 1243741F8D52;
        Tue, 12 May 2015 13:29:14 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 12 May 2015 13:29:14 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 12 May 2015 13:29:14 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 151D9EC793B25;
        Tue, 12 May 2015 13:29:11 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 12 May 2015 13:27:10 +0100
Received: from [192.168.154.110] (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 12 May
 2015 13:27:10 +0100
Message-ID: <5551F19D.10602@imgtec.com>
Date:   Tue, 12 May 2015 13:27:09 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        <linux-mips@linux-mips.org>
CC:     Paul Martin <paul.martin@codethink.co.uk>,
        "Maciej (LMO)" <macro@linux-mips.org>
Subject: Re: "BUG: using smp_processor_id() in preemptible" on v4.1-rc3
References: <555153F9.2020300@imgtec.com>
In-Reply-To: <555153F9.2020300@imgtec.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature";
        boundary="L3O1dPJq4Xk3WW6QtVXM5P1Ct9vnOwt6W"
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: b93fcccb
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47343
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

--L3O1dPJq4Xk3WW6QtVXM5P1Ct9vnOwt6W
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ezequiel,

Could you confirm whether your problem is the same as that described here=
?:

http://patchwork.linux-mips.org/patch/9830/

Cheers
James

On 12/05/15 02:14, Ezequiel Garcia wrote:
> Whenever I run a command, I get a "BUG: using smp_processor_id()
> in preemptible...". I'm running v4.1-rc3 with CONFIG_PREEMPT.
>=20
> Kernel log and config attached -- You can see the BUG during boot
> a few times as well.
>=20
> Not sure where's the smp_processor_id call in load_elf_binary, but
> it seems to be MIPS-related.
>=20
> # ls
> [   14.881148] BUG: using smp_processor_id() in preemptible [00000000] =
code: sh/97
> [   14.889499] caller is load_elf_binary+0x4cc/0x1320
> [   14.894991] CPU: 0 PID: 97 Comm: sh Not tainted 4.1.0-rc3+ #134
> [   14.901700] Stack : 00000000 00000000 81c90d52 00000033 666c655f 000=
00000 00000001 8049c350
> 	  8049c31c 80c20000 80b8e8c4 00000061 00000000 814e37f0 00000007 00000=
000
> 	  860bbcc8 8049c350 860bbcc8 80790fac 00000003 814d0000 80b8e8c4 860bb=
c2c
> 	  00000061 80a66e04 814e37f0 8042e1c8 00000000 00000000 860bbc2c dc8ba=
300
> 	  80c1f327 006cda88 00000000 00000000 00000000 00000000 00000000 00000=
000
> 	  ...
> [   14.942591] Call Trace:
> [   14.945471] [<8040c1a4>] show_stack+0x6c/0xac
> [   14.950475] [<80a67f3c>] dump_stack+0xc8/0x128
> [   14.955628] [<807a366c>] check_preemption_disabled+0xec/0x118
> [   14.962180] [<805f33c0>] load_elf_binary+0x4cc/0x1320
> [   14.967978] [<80593594>] search_binary_handler+0xbc/0x214
> [   14.974135] [<805f28e8>] load_script+0x288/0x2b0
> [   14.979426] [<80593594>] search_binary_handler+0xbc/0x214
> [   14.985587] [<80594460>] do_execveat_common+0x638/0xa74
> [   14.991562] [<805948d4>] do_execve+0x38/0x44
> [   14.996469] [<80414840>] handle_sys+0x160/0x184
> [   15.001652] bin  etc   init  lib32	  media  opt   root  sbin  tmp	va=
r
> dev  home  lib	 linuxrc  mnt	 proc  run   sys   usr
>=20


--L3O1dPJq4Xk3WW6QtVXM5P1Ct9vnOwt6W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVUfGdAAoJEGwLaZPeOHZ6wTcQAIfbCQWcG92zUZ/zLc/DALI9
zOH69XCccut4RP+Y+ZEj8yYMYElgAEzVV3sWyOXzcFfG+ymv2ClJxpxBetc2D9Ab
iL+4N+uwzqY3lEuGZhrjd5LM7J07ufA8wzMS2Topsp7ktD9bvocrK0dyYkmzQf+S
bHFivPhG1PBoanUyDDq+GBQlYpqFUI/+nAU/66gG2drAiBt0mcjAxkl1PeM+xU4p
0KCWGje9sMdgJfkOuFSHvWyV54QucPYNg/ev7WXWKehw7pACORvfMXQGSntYM2Zb
6FxK/EHa/RwLUI5k7tDryRWOpHVXh5w2CE9plAB3NXYIyjw6uoQkgu9OuPBDikL5
C+9tEQ6JfaF66Q03Vefzp1O+xSeDrBLfXDSuUgm29CnZItSH5mqJXhfZ6KB1nw/O
PKjjVcaP/sYnOdLYzWRwRBJE60gKiwa4pewM6yDmYxjhze9p//NsaVExp6+Lknsn
jqeeI4ne+HaaOAFVwEf5cdYMYlb+mlu+6uup2/hzaXJwAzU8ogNlN4LAEB1yLJAj
RhewX3ib9Hp2Inmm5Pd4udAENCdGjJssdlZSZKW/n8nuecs0N0UBaq5PXqp8bk2W
wTZ17UmfQ7qBrQI7g39shxDLTcJ3ms50vnguZhYQPq9J9iJ0FstwtBhPYFTl07xE
mQmIn+H1T1Zz7ZSmZyNF
=cBS9
-----END PGP SIGNATURE-----

--L3O1dPJq4Xk3WW6QtVXM5P1Ct9vnOwt6W--
