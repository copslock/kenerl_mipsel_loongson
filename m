Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Nov 2017 17:43:59 +0100 (CET)
Received: from fldsmtpe03.verizon.com ([140.108.26.142]:63402 "EHLO
        fldsmtpe03.verizon.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990593AbdKIQnvKtM9l convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Nov 2017 17:43:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=one.verizon.com; i=@one.verizon.com; q=dns/txt;
  s=corp; t=1510245830; x=1541781830;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=sa0BsZIlP/T9zHWgL9iY3zbnXm59R332HQti7zqnoyE=;
  b=YdR7GNGbqX5+Xu9L6t7mH2xqyj3WIfMSQio9J8o90TQTNvImAGFk5po0
   UqblNKHSE4Hw7v8aj/wIMSvnY0o11sNiZEYuOPQdQcI+bRYgnwZ1CfOBi
   ksiQFaQPahXDGhec/8IDLWRSAUc6qG34BwOXTk15M13Y+jjk4Q9A/8lYx
   o=;
Received: from unknown (HELO fldsmtpi01.verizon.com) ([166.68.71.143])
  by fldsmtpe03.verizon.com with ESMTP; 09 Nov 2017 16:43:43 +0000
Received: from rogue-10-255-192-101.rogue.vzwcorp.com (HELO apollo.verizonwireless.com) ([10.255.192.101])
  by fldsmtpi01.verizon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 09 Nov 2017 16:42:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=verizon.com; i=@verizon.com; q=dns/txt; s=corp;
  t=1510245743; x=1541781743;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=sa0BsZIlP/T9zHWgL9iY3zbnXm59R332HQti7zqnoyE=;
  b=QNmycXtfHk+lm8H9QoOBA0oAgEZQnAh10XY14uS1tTm1diY0Xniptl6C
   6zdgGYTnaCSpFLBxsyBR8eCsVjMDnXHpKIXukBfrKTNaZ0P9vjpF4JtTX
   X9CvOjb5UGccG+b+jQJvbZmZdAAVKC/AZUmsmM3OBZwsrugD8TNun06Xx
   Y=;
Received: from mariner.tdc.vzwcorp.com (HELO eris.verizonwireless.com) ([10.254.88.84])
  by apollo.verizonwireless.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 09 Nov 2017 11:42:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=verizon.com; i=@verizon.com; q=dns/txt; s=corp;
  t=1510245742; x=1541781742;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=sa0BsZIlP/T9zHWgL9iY3zbnXm59R332HQti7zqnoyE=;
  b=ob+ncqiHeMiXZBM05qeGmwhFs72u4INyS3Vu+rLllPEf4cqP3uXo5itp
   R9JaA/Zjqb3/Xfq5do78vFIJKthAR9grp4LdvbIxLwluWesQOrDpibm55
   GWIM0JODPdkjXQe721XeIDI4cVEjJSqA0692ok1N9dDnkZjSrMiNIrII8
   I=;
X-Host: mariner.tdc.vzwcorp.com
Received: from ohtwi1exh002.uswin.ad.vzwcorp.com ([10.144.218.44])
  by eris.verizonwireless.com with ESMTP/TLS/AES128-SHA256; 09 Nov 2017 16:42:22 +0000
Received: from tbwexch14apd.uswin.ad.vzwcorp.com (153.114.162.38) by
 OHTWI1EXH002.uswin.ad.vzwcorp.com (10.144.218.44) with Microsoft SMTP Server
 (TLS) id 14.3.248.2; Thu, 9 Nov 2017 11:42:22 -0500
Received: from OMZP1LUMXCA17.uswin.ad.vzwcorp.com (144.8.22.195) by
 tbwexch14apd.uswin.ad.vzwcorp.com (153.114.162.38) with Microsoft SMTP Server
 (TLS) id 15.0.1263.5; Thu, 9 Nov 2017 11:42:22 -0500
Received: from OMZP1LUMXCA17.uswin.ad.vzwcorp.com (144.8.22.195) by
 OMZP1LUMXCA17.uswin.ad.vzwcorp.com (144.8.22.195) with Microsoft SMTP Server
 (TLS) id 15.0.1263.5; Thu, 9 Nov 2017 10:42:21 -0600
Received: from OMZP1LUMXCA17.uswin.ad.vzwcorp.com ([144.8.22.195]) by
 OMZP1LUMXCA17.uswin.ad.vzwcorp.com ([144.8.22.195]) with mapi id
 15.00.1263.000; Thu, 9 Nov 2017 10:42:21 -0600
From:   "Levin, Alexander (Sasha Levin)" <alexander.levin@one.verizon.com>
To:     Matt Redfearn <matt.redfearn@mips.com>
CC:     "Levin, Alexander (Sasha Levin)" <alexander.levin@one.verizon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH AUTOSEL for-4.4 39/39] MIPS: Use Makefile.postlink to
 insert relocations into vmlinux
Thread-Topic: [PATCH AUTOSEL for-4.4 39/39] MIPS: Use Makefile.postlink to
 insert relocations into vmlinux
Thread-Index: AQHTWXm2W6bekiepBUS6EG41KvexAg==
Date:   Thu, 9 Nov 2017 16:42:21 +0000
Message-ID: <20171109164218.vdnku5kzm3trezuw@sasha-lappy>
References: <20171108205027.27525-1-alexander.levin@verizon.com>
 <20171108205027.27525-39-alexander.levin@verizon.com>
 <fc334f42-f3ca-b03c-d8de-ce7d9ffdf5e3@mips.com>
In-Reply-To: <fc334f42-f3ca-b03c-d8de-ce7d9ffdf5e3@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20170113 (1.7.2)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.144.60.250]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <13A63AD4DCF7DD45B7BA0B52C6129BC3@vzwcorp.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <alexander.levin@one.verizon.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60811
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexander.levin@one.verizon.com
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

On Thu, Nov 09, 2017 at 09:16:44AM +0000, Matt Redfearn wrote:
>
>
>On 08/11/17 20:50, Levin, Alexander (Sasha Levin) wrote:
>>From: Matt Redfearn <matt.redfearn@imgtec.com>
>>
>>[ Upstream commit 44079d3509aee89c58f3e4fd929fa53ab2299019 ]
>>
>>When relocatable support for MIPS was merged, there was no support for
>>an architecture to add a postlink step for vmlinux. This meant that only
>>invoking a target within the boot directory, such as uImage, caused the
>>relocations to be inserted into vmlinux. Building just the vmlinux
>>target would result in a relocatable kernel with no relocation
>>information present.
>>
>>Commit fbe6e37dab97 ("kbuild: add arch specific post-link Makefile")
>
>Hi,
>
>This patch depends on upstream commit fbe6e37dab97 ("kbuild: add arch 
>specific post-link Makefile") which was introduced in v4.9.
>
>This patch is an improvement to the build flow and I would not 
>consider it for backporting - certainly not to v4.8 or earlier which 
>is missing the dependency. Applying it will not break anything, 
>however, it will perform no function either without the supporting 
>dependency.

I'll just drop it from 4.9 and 4.4 then, Thanks Matt.

-- 

Thanks,
Sasha
From James.Hogan@mips.com Thu Nov  9 17:45:09 2017
Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Nov 2017 17:45:16 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.150.245]:42234 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990765AbdKIQpIzaO1l (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Nov 2017 17:45:08 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Thu, 09 Nov 2017 16:43:49 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 9 Nov 2017
 08:43:45 -0800
Date:   Thu, 9 Nov 2017 16:43:43 +0000
From:   James Hogan <james.hogan@mips.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Wim Van Sebroeck <wim@iguana.be>,
        Mathieu Malaterre <malat@debian.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>, <linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH 2/3] watchdog: jz4780: Allow selection of jz4740-wdt
 driver
Message-ID: <20171109164342.GR15235@jhogan-linux>
References: <20170908183558.1537-1-malat@debian.org>
 <20170908183558.1537-2-malat@debian.org>
 <20171109074718.GR15260@jhogan-linux>
 <20171109160147.GB19959@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hI0HXimLkvfVxAyB"
Content-Disposition: inline
In-Reply-To: <20171109160147.GB19959@roeck-us.net>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1510245829-298552-3576-60841-1
X-BESS-VER: 2017.12-r1710252241
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186759
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
X-archive-position: 60812
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

--hI0HXimLkvfVxAyB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 09, 2017 at 08:01:47AM -0800, Guenter Roeck wrote:
> On Thu, Nov 09, 2017 at 07:47:19AM +0000, James Hogan wrote:
> > Hi Wim,
> >=20
> > On Fri, Sep 08, 2017 at 08:35:54PM +0200, Mathieu Malaterre wrote:
> > > This driver works for jz4740 & jz4780
> > >=20
> > > Suggested-by: Maarten ter Huurne <maarten@treewalker.org>
> > > Signed-off-by: Mathieu Malaterre <malat@debian.org>
> >=20
> > I just noticed that though Ralf applied the other two patches in this
> > series (defconfig + dt), he hadn't applied this patch.
> >=20
> > Please can we have an ack from a watchdog maintainer so this can get
> > into 4.15 via the MIPS tree? It could alternatively go via the watchdog
> > tree if you prefer.
> >=20
>=20
> FWIW, according to my logs I did send out a Reviewed-by: some time ago,
> which normally means that I expect it to go through the watchdog tree.
> I wasn't aware that you wanted the patch to go through the mips tree.
> Sorry if I missed that earlier. For the record,
>=20
> Acked-by: Guenter Roeck <linux@roeck-us.net>
>=20
> since I don't care one way or another.

Okay thanks, I wasn't sure and don't much mind which way it goes.

>=20
> I assume you want me to drop this and the related patches from my own
> watchdpog-next tree to prevent it from showing up in Wim's tree (if
> it isn't already there). Is that correct ?

I haven't seen this patch in linux-next, or I wouldn't have mentioned
it. If its already in some staging tree for 4.15 that I've missed then
it may as well stay there, otherwise I'll just take it through the MIPS
tree with your ack.

Cheers
James

--hI0HXimLkvfVxAyB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAloEhb4ACgkQbAtpk944
dnrSKQ/9HFjsZh9YkvycI/pPI2bSCk7IU7lI9rU73J99fBKu5sImGtJTfwT3icOX
S1Qd4jjs9M4ue7TGLtgFYIs/5adVYLEFkb14BvEneHJZt87thDqcLIdNlaMWf4dZ
oGBmeazdmEmHAUfb63AU2/jmEOewHqvoLl2Q5FWzHLGsMrQzgiyHUveiBeEup/6E
G3bX5PheTVxKjiEzV+4KY1Vvz7uef/v9mgXjbxDuqsGdaZlP94SKpBgaIuTrpLZA
LXx2+kFrLRKVyhB/S8NfyB09rAgw61R8TVOX9crThaT86qywtzwWkG/LIyvM71+y
ULtgDGutbDsA0XUftinxSnn9YlDg/UN7tJoXcYWKj5Ne7o73zP0Ug1CnYO632aLO
moeiNTBWlkD7LLc4cPi3E+x5/lAfgwCm2yvczkblu8Y/sDVp+YgpNXIuv1bkTX6T
4exB46T30d6gFj3/p032c7LjcD2JVY0D0118qgeIwHEPSEp/gZ9a5+oR4eVCoyZw
6ss40CNP84ofuhfOUAYL3nwYOkFPKlPZYkliB3C6iQ5e9+BJNen36EZQzr0rTVOx
rP0JyCXs/2ZLOnl+f5/dlFDYArar95eYLdDWObdnzVF+h22Si2GvLylgbE2rsJaV
FkjvYOipD3kMmD/WFwO0DuEk3V/VPaXaD4qctV32CDT+sFTq0VE=
=h0L4
-----END PGP SIGNATURE-----

--hI0HXimLkvfVxAyB--
