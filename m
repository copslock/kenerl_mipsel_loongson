Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Jun 2015 04:07:55 +0200 (CEST)
Received: from chaos.universe-factory.net ([37.72.148.22]:37694 "EHLO
        chaos.universe-factory.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27005162AbbFSCHx1xjd6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Jun 2015 04:07:53 +0200
Received: from [IPv6:fd1b:c28a:2fd6:0:b08e:2965:c7f8:e048] (unknown [IPv6:fd1b:c28a:2fd6:0:b08e:2965:c7f8:e048])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by chaos.universe-factory.net (Postfix) with ESMTPSA id EA659189D47;
        Fri, 19 Jun 2015 04:07:52 +0200 (CEST)
To:     musl@lists.openwall.com, linux-mips@linux-mips.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>
From:   Matthias Schiffer <mschiffer@universe-factory.net>
Subject: musl-libc/MIPS: detached thread exit broken since kernel commit
 46e12c07b
X-Enigmail-Draft-Status: N1110
Message-ID: <55837978.7020801@universe-factory.net>
Date:   Fri, 19 Jun 2015 04:07:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.0.1
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="2Qrjcblkhk9LKAh8GTXHGx3Dh8s5o1Vtq"
Return-Path: <mschiffer@universe-factory.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47976
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mschiffer@universe-factory.net
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2Qrjcblkhk9LKAh8GTXHGx3Dh8s5o1Vtq
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,
I've come across the issue that applications with detached threads
(using pthread_detach or a pthread_attr_t with
pthread_attr_setdetachstate) will segfault using musl-libc on MIPS as
soon as the detached thread exits. As far as I can tell, the underlying
issue is the following:

To clean up after itself, the finishing thread will call __unmapself,
which will unmap the thread's own stack and call the exit syscall
directly after that, without accessing the now unmapped stack.

This worked fine in 2012, when pthread support for MIPS was implemented
in musl. It seems to have been broken by kernel commit 46e12c07b "MIPS:
O32 / 32-bit: Always copy 4 stack arguments." (also in 2012) which made
the kernel unconditionally copy 4 stack arguments, even when the syscall
doesn't even use the arguments.

I guess this would be reasonably easy to fix up in musl, but let's also
get the linux-mips people's opinions, as that commit obviously broke the
kernel ABI...


--2Qrjcblkhk9LKAh8GTXHGx3Dh8s5o1Vtq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJVg3l4AAoJEBbvP2TLIB2cA+AP/i2svAhs7B62wUPA5qXCnYKk
Yr1gLGh8tL9YygB8NJ800BGZXqp45fuwH/49nHDuIdTyjRK8riF6qXaLqgo3Ig6X
F5ZIE8QF5r4Lf1iW72W9NlHDDw079aeMcR6NLfXdojaakC3IUT/yMrNSkfCydUyw
5T2V4o3004uHuIsaARyN56YevrM2rqGdx8YxC4o7/QJ9gySehsWUOI9EO4NSZvgg
O8Omjig2IlMwAWnsqmtw9SLUcyBK8Yqbp628IOgYLuDXfkYLTERf0CgEh14vIexZ
JWnadBxKvkYmdvBMQqbQ9ynUCO29COm75p5l5U8iwFhVlPZHvIo61eyOJfLH8lgj
2EADhYSJGCT4UnbIMytSr9h1gxivSILL9QIyAOKF7d9im72vFNr3dD7Gim08Nyxn
oLuc/CdIRQWXIqdwCqnPB0C85Jeso6pM2t5XFLY4IUQYtAYEG6fSz1zEG/zaRQPd
6L3HLH0lQC927iAnOg72etdgjT+8c6BKrx8mo5vnt2u0CtEZrcTL7h1WFQxN3s02
E/l4qMNNGXjTaCwC60bjXytVNZNXHB6sL463g4u2nt3SLgNvuLWIPkAq2MfPEz58
5VN3RP5Uaj1OtYkrEXjJQ1Yk2EnocSbt1hO4nxyQjEtyeB2JinTsLwW8dY776B1a
jv/R/+nPFy0MEV0BqF5W
=/zA2
-----END PGP SIGNATURE-----

--2Qrjcblkhk9LKAh8GTXHGx3Dh8s5o1Vtq--
