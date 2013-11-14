Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Nov 2013 10:40:23 +0100 (CET)
Received: from mail-wi0-f170.google.com ([209.85.212.170]:47757 "EHLO
        mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822311Ab3KNJkP7YUaG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 Nov 2013 10:40:15 +0100
Received: by mail-wi0-f170.google.com with SMTP id f4so483407wiw.3
        for <linux-mips@linux-mips.org>; Thu, 14 Nov 2013 01:40:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type;
        bh=Hus7Xe9Dvt8RhHV8vsEe8s+6GC003tKGv2m/dKMqbno=;
        b=K529EsyjTxVUS1YR76SEFCqON1UV/Fq3+QdwwV1GIJRX3wm3ofJPEfGYoP5AGPIGfV
         JMF52mgNcZzN0e5tf6O10pH6FB8qemgooZeFeljpzYBm2w+aC6inuaLznoi9D7fE5UJk
         /TXxfx/shTeqToPJOiLXyxj7BTYr7BHFNjK0LToNXs8snEQjiyOOjtksqNR/aut8QANf
         b/mHZ/TKGDK67wzqHYP/SW26OEM91oPiopifl+dzlLJ1rXh9kIAHXzFf9rRp4bR0DsfW
         ZM83V9KuWKSJREXODdO6APH2rjdKaouavT1NQy80+Aq21EzJgvVTNcKXnUhWA7y4xNrP
         qbtw==
X-Gm-Message-State: ALoCoQkSyx96ZxYMCQnFgZ5AYctBDvcYQ5KZhn1pQrdbgbe38A+DdHu8BizVw3/QZtO+PPerV6V9
X-Received: by 10.180.12.67 with SMTP id w3mr1612234wib.0.1384422010460;
        Thu, 14 Nov 2013 01:40:10 -0800 (PST)
Received: from [192.168.0.100] (nat-63.starnet.cz. [178.255.168.63])
        by mx.google.com with ESMTPSA id e1sm64153285wij.6.2013.11.14.01.39.58
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Nov 2013 01:40:08 -0800 (PST)
Message-ID: <52849A65.9030500@monstr.eu>
Date:   Thu, 14 Nov 2013 10:39:49 +0100
From:   Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130330 Thunderbird/17.0.5
MIME-Version: 1.0
To:     Mark Salter <msalter@redhat.com>
CC:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Richard Kuo <rkuo@codeaurora.org>,
        linux-hexagon@vger.kernel.org,
        James Hogan <james.hogan@imgtec.com>,
        linux-metag@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 00/11] Consolidate asm/fixmap.h files
References: <1384262545-20875-1-git-send-email-msalter@redhat.com>  <52824BBC.9020401@monstr.eu> <1384271711.24631.5.camel@deneb.redhat.com>
In-Reply-To: <1384271711.24631.5.camel@deneb.redhat.com>
X-Enigmail-Version: 1.6
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="iQtiGn9GE0PIJmOHe35N72OtEjLmxDLif"
Return-Path: <monstr@monstr.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38518
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: monstr@monstr.eu
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
--iQtiGn9GE0PIJmOHe35N72OtEjLmxDLif
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/12/2013 04:55 PM, Mark Salter wrote:
> On Tue, 2013-11-12 at 16:39 +0100, Michal Simek wrote:
>> On 11/12/2013 02:22 PM, Mark Salter wrote:
>>>
>>>  arch/arm/include/asm/fixmap.h        |  25 ++------
>>>  arch/hexagon/include/asm/fixmap.h    |  40 +------------
>>>  arch/metag/include/asm/fixmap.h      |  32 +----------
>>>  arch/microblaze/include/asm/fixmap.h |  44 +-------------
>>>  arch/mips/include/asm/fixmap.h       |  33 +----------
>>>  arch/powerpc/include/asm/fixmap.h    |  44 +-------------
>>>  arch/sh/include/asm/fixmap.h         |  39 +------------
>>>  arch/tile/include/asm/fixmap.h       |  33 +----------
>>>  arch/um/include/asm/fixmap.h         |  40 +------------
>>>  arch/x86/include/asm/fixmap.h        |  59 +------------------
>>>  include/asm-generic/fixmap.h         | 107 +++++++++++++++++++++++++=
++++++++++
>>>  11 files changed, 125 insertions(+), 371 deletions(-)
>>>  create mode 100644 include/asm-generic/fixmap.h
>>
>> Any repo/branch with all these patches will be helpful.
>=20
> https://github.com/mosalter/linux (fixmap branch)

Thanks,

For Microblaze
Tested-by: Michal Simek <monstr@monstr.eu>

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform



--iQtiGn9GE0PIJmOHe35N72OtEjLmxDLif
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlKEmmUACgkQykllyylKDCF4AQCgjhFOcr0jquPeAeSfJ6XEBDsZ
dTIAn2jGHts/85REgK0/IHvrLywyWO8a
=ZN3C
-----END PGP SIGNATURE-----

--iQtiGn9GE0PIJmOHe35N72OtEjLmxDLif--
