Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Apr 2014 21:23:05 +0200 (CEST)
Received: from mail-wi0-f173.google.com ([209.85.212.173]:46839 "EHLO
        mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6843063AbaDYTXCp59Lv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 Apr 2014 21:23:02 +0200
Received: by mail-wi0-f173.google.com with SMTP id z2so3173332wiv.6
        for <linux-mips@linux-mips.org>; Fri, 25 Apr 2014 12:22:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :organization:user-agent:in-reply-to:references:mime-version
         :content-type;
        bh=S4VoxxEMfdemUOcWxjYVwtcGQH5QlU7wsEecwMQcZkg=;
        b=Nga+U9qXy6i7k+CBi6O81pgDxyNm3VdJsKk/LBGIGGgLcr3q53AMRUGKabcs7yN0C6
         77CHrYGBCpqm71OtltxcI5NmN5WvJB+qdzOAtiDcuJR4Br76xQsIDZpwML5crlOXtZ+D
         Gqi7Ygsa2YN4rDykKMEHfYv+VF1LX3Txz4r3jua58toT5m9qPSWoOXvrucLdU+ddxcDA
         d9ZdBRjmlan1J/TIgq+MB2Y4KBGl6i4Ws3IMIALu4a1zRNAUa/NXtfNX3qCui7Ua4xpC
         zWhrhDDhgXJX370zvfnr6Y/JyEAeea/I5Pi5p+eWbSpzD4Xl1sMdnmpUnYE7XnsnByug
         fUvA==
X-Gm-Message-State: ALoCoQm/bEdXzr6+562krC8SAOeu0bCtS7i0JIV+rkYPfiHYSBeDEDE07EfIXIEnUsRxRp36sYCw
X-Received: by 10.194.222.227 with SMTP id qp3mr8002513wjc.37.1398453776934;
        Fri, 25 Apr 2014 12:22:56 -0700 (PDT)
Received: from radagast.localnet (jahogan.plus.com. [212.159.75.221])
        by mx.google.com with ESMTPSA id co9sm12502457wjb.22.2014.04.25.12.22.54
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 25 Apr 2014 12:22:55 -0700 (PDT)
From:   James Hogan <james.hogan@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Gleb Natapov <gleb@kernel.org>, kvm@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Sanjay Lal <sanjayl@kymasys.com>
Subject: Re: [PATCH 04/21] MIPS: KVM: Fix CP0_EBASE KVM register id
Date:   Fri, 25 Apr 2014 20:22:40 +0100
Message-ID: <6139466.gSWQB3IZPa@radagast>
Organization: Imagination Technologies
User-Agent: KMail/4.11.5 (Linux/3.14.0+; KDE/4.11.5; x86_64; ; )
In-Reply-To: <535A8F22.4090402@caviumnetworks.com>
References: <1398439204-26171-1-git-send-email-james.hogan@imgtec.com> <1398439204-26171-5-git-send-email-james.hogan@imgtec.com> <535A8F22.4090402@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1475874.trHGXRUAiO"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-Path: <james@albanarts.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39952
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


--nextPart1475874.trHGXRUAiO
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi David,

On Friday 25 April 2014 09:36:50 David Daney wrote:
> On 04/25/2014 08:19 AM, James Hogan wrote:
> > -#define KVM_REG_MIPS_CP0_EBASE=09=09MIPS_CP0_64(15, 1)
> > +#define KVM_REG_MIPS_CP0_EBASE=09=09MIPS_CP0_32(15, 1)
>=20
> According to:
>=20
>   MIPS=AE Architecture Reference Manual
>    Volume III: The MIPS64=AE and
> microMIPS64TM Privileged Resource
> Architecture
>=20
> Document Number: MD00089
> Revision 5.02
> April 30, 2013
>=20
> In section 9.39 EBase Register (CP0 Register 15, Select 1), we see th=
at
> EBase can be either 32-bits or 64-bits wide.
>=20
> I would recommend leaving this as a 64-bit wide register, so that CPU=

> implementations with the wider EBase can be supported.

Yes, you're quite right. I should have checked that one for carefully (=
I did=20
think it was a bit odd for it to be 32bit on MIPS64). I'll drop this pa=
tch.

Thanks
James

>=20
> Alternately, probe for the width and use the appropriate 32-bit or
> 64-bit to more closely reflect reality.
>=20
> >   #define KVM_REG_MIPS_CP0_CONFIG=09=09MIPS_CP0_32(16, 0)
> >   #define KVM_REG_MIPS_CP0_CONFIG1=09MIPS_CP0_32(16, 1)
> >   #define KVM_REG_MIPS_CP0_CONFIG2=09MIPS_CP0_32(16, 2)

--nextPart1475874.trHGXRUAiO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAABAgAGBQJTWrYOAAoJEKHZs+irPybfsrEP/3bnml+heYrpVKp+JGLiDNGm
lD3n14J7Kzcaq8FWFINHXsAYc0nL+U23K3iPCN/nycc5fqQqpR+VTv/xkGPTa5g/
FUaFFNtH1Z7jUzTqwCmLL8X6gnhmXCP2tMV2nm0ltMCk+HloqwTS6eRo3/LISYOE
ifW95Tji5yH/3im9Wz8nHaB5p7bRcOF3AdCYSW/MRhTnzTnwTe3LliWyTsa6rHhs
UW/l7Y20WgdTWWA61NLpMUnP3UkscUjiRg4QK4utKKTzgbGWhEbNAt8DSPyjwXrg
3Ua54U63Oafx1M10LU/oWIo1aRGEswGjrfTCLhBd3L0hnTAUsbMzZfAqcEQzNlkI
ptZQ8fZip06QdNkJWLONp8RF/Hv4IuzaNyEetoV+E9fxRzOp9FAMB/HNMJmknc77
Tlb0CJuKs8PuKf8lAsZL6aVEBDSZjorogL3X6sLJRR+fqR/AYm4UXw2X9h0ZCFL1
9b/Mg9/oLKYLe5uUqgNrZk9dlGuXJcO4MJUsfl4ZZDLvW9w+wNBMsX9wtJ366h+m
I7e6X4di4Wpc/Ciyb/BSZZK4YF/zeSoIds+0tK/nt8GGD3L9+jfsJe+gJo6h8VSM
/jeOM3CPz7SLbeBTPlZYUnYwgcQp19VttftUG/JCByNw1SsAbI2ja0BwSv+mJcyC
aaGepKIq4ZtGO2scK2Ad
=am+u
-----END PGP SIGNATURE-----

--nextPart1475874.trHGXRUAiO--
