Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Jun 2009 16:02:55 +0100 (BST)
Received: from mail-ew0-f219.google.com ([209.85.219.219]:58711 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20025397AbZFAPCt (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 1 Jun 2009 16:02:49 +0100
Received: by ewy19 with SMTP id 19so8166561ewy.0
        for <multiple recipients>; Mon, 01 Jun 2009 08:02:43 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=YhoxV5rbhpKfcn6DLieHyRTtod6Tj2j3dNAo79LQ+NM=;
        b=U5BggflPSHXrJ1g5+41GNBqARNadRTMpqSQmSfAM3jn0pqv1SKg4e2XukFbIhYA5f+
         15gP3Nk3xpHTWiPM1NzCH5FG+n5dDP/BdytIicRwIRVQDu7FGMWK/id3wNOPSahnAsv8
         UUl6mQ3JYMcTlgGjLrwuX33jtSJjbdI1wx0ic=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding:message-id;
        b=hAAwYk5M7buJKEcble3UH2Q2RN2m1ssspO+7fLqp2H9eP1sRCpi3bZGXgkYJdhrkNe
         isUr8qvlFQL6xBbgZRRqT3Frkj9FfbE7iZ1xRfu1giNYN6kTOt6nyu8bFRMAoxWoF2uy
         009dhI18iFIe+xYkOmSzXQAKI4ibcMqWKjK4A=
Received: by 10.210.80.17 with SMTP id d17mr6498475ebb.27.1243868563256;
        Mon, 01 Jun 2009 08:02:43 -0700 (PDT)
Received: from florian.lab.openpattern.org (lab.openpattern.org [82.240.16.241])
        by mx.google.com with ESMTPS id 28sm398157eyg.14.2009.06.01.08.02.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Jun 2009 08:02:42 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 10/10] bcm63xx: compile fixes for bcm63xx_enet.c
Date:	Mon, 1 Jun 2009 17:02:38 +0200
User-Agent: KMail/1.9.9
Cc:	linux-mips@linux-mips.org, Maxime Bizon <mbizon@freebox.fr>
References: <200905312031.35241.florian@openwrt.org> <20090601145552.GI6604@linux-mips.org>
In-Reply-To: <20090601145552.GI6604@linux-mips.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart7950347.cy3bj5dT6T";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200906011702.40561.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23119
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

--nextPart7950347.cy3bj5dT6T
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Le Monday 01 June 2009 16:55:52 Ralf Baechle, vous avez =E9crit=A0:
> On Sun, May 31, 2009 at 08:31:34PM +0200, Florian Fainelli wrote:
> > This patch makes the ethernet driver compile again
> > after commit 908a7a1. netif_rx_schedule became
> > napi_schedule and __netif_rx_complete became
> > __napi_rx_complete.
> >
> > Signed-off-by: Florian Fainelli <florian@openwrt.org>
>
> Folded into the "MIPS: BCM63XX: Add integrated ethernet mac support."
> patch.

Thanks.

>
> You should eventually run this patch by the network maintainers.  It's
> a driver patch so I won't merge it upstream unless it's been acked by one
> of the network guys.

Actually Maxime already submitted those patches, without much answer from t=
he=20
network guys so I guess they just skipped it.
=2D-=20
Best regards, Florian Fainelli
Email : florian@openwrt.org
http://openwrt.org
=2D------------------------------

--nextPart7950347.cy3bj5dT6T
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkoj7Y4ACgkQlyvkmBGtjyZUoQCePsvQsSSEVHbgnlysyCRRz1wr
JRkAnjYIDPy7lNraFl0SdjeiG6y04dKe
=dAb+
-----END PGP SIGNATURE-----

--nextPart7950347.cy3bj5dT6T--
