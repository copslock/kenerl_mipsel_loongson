Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2008 14:58:46 +0100 (BST)
Received: from gv-out-0910.google.com ([216.239.58.188]:20197 "EHLO
	gv-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S22135265AbYJVN6k (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 22 Oct 2008 14:58:40 +0100
Received: by gv-out-0910.google.com with SMTP id e6so582247gvc.2
        for <linux-mips@linux-mips.org>; Wed, 22 Oct 2008 06:58:39 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:message-id:sender;
        bh=iBgQ7gQVVBaG6boxU22cryKlfy6MplACS74LcrtVX+c=;
        b=Q+8tKgj1ulvETV9HdwzFjb4BScYcuzCVAV3pz2Ya+F2hxFy+ruPGgYHln6l4LXsqxy
         MwIlgnzt0cir84RxKcbgzev/7sR+DI8NSFsnEmXV3O5iZuXhqLTK0ooVF0z/sMf0Cx4k
         gp1BJs1LQbwaTuY7dPlvex9hOGmoWyl+BHAFA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding:message-id
         :sender;
        b=IFJ8XOXjHs1XCumeuaBrmP4wfzpZrEHVesKo7aMvC++wjqlwc/HbS+t+Vpyvxo+omB
         ePIZ9/vLpaJTeAx/GLHiHYgLWGGbgfxSGwwD++P/riVRh8V5YAr3eMD7ZW7aPxtzgVTo
         4tSzlaLAb4kn5aCCZe4zA0aAzXIR8KAbhtIyE=
Received: by 10.103.226.20 with SMTP id d20mr5216774mur.10.1224683919164;
        Wed, 22 Oct 2008 06:58:39 -0700 (PDT)
Received: from florian.headquarters.openpattern.org (headquarters.openpattern.org [82.240.17.188])
        by mx.google.com with ESMTPS id y37sm17524171mug.13.2008.10.22.06.58.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 22 Oct 2008 06:58:38 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Maxime Bizon <mbizon@freebox.fr>
Subject: Re: [PATCH/RFC v1 00/12] Support for Broadcom 63xx SOCs
Date:	Wed, 22 Oct 2008 15:58:23 +0200
User-Agent: KMail/1.9.9
Cc:	ralf@linux-mips.org, netdev@vger.kernel.org,
	afleming@freescale.com, jgarzik@pobox.com,
	linux-usb@vger.kernel.org, dbrownell@users.sourceforge.net,
	linux-pcmcia@lists.infradead.org, linux-serial@vger.kernel.org,
	linux-mips@linux-mips.org
References: <1224382022-24173-1-git-send-email-mbizon@freebox.fr>
In-Reply-To: <1224382022-24173-1-git-send-email-mbizon@freebox.fr>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2962902.4p7LAVTyHT";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200810221558.27338.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20838
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

--nextPart2962902.4p7LAVTyHT
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,

Le Sunday 19 October 2008 04:07:02 Maxime Bizon, vous avez =E9crit=A0:
> CPUs supported are  6348 and 6358. Support is  provided for integrated
> UART,  USB OHCI  and  EHCI, PCI  controller,  ethernet MAC  & PHY  and
> PCMCIA/Cardbus controller.

I got some pending patches on top of yours to add support for earlier : 633=
8=20
and 6345, as well as newer revisions of the SoC : 6368 and 6816.=20
Additionnaly, the cable version (BCM3348/BCM3349) should be fairly well=20
supported now, for which I need to have a serious try.

I prefer you get some feedback on your patches first before submitting my=20
changes.
=2D-=20
Best regards, Florian Fainelli
Email : florian@openwrt.org
http://openwrt.org
=2D------------------------------

--nextPart2962902.4p7LAVTyHT
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkj/MYEACgkQlyvkmBGtjyamHwCggOIQTTLwf5Y2y0CH7tme3706
CssAnRZXTrJJgdZrFmSwCuVctVowUk15
=PSMQ
-----END PGP SIGNATURE-----

--nextPart2962902.4p7LAVTyHT--
