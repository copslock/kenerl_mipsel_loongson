Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Aug 2009 23:37:52 +0200 (CEST)
Received: from mail-ew0-f225.google.com ([209.85.219.225]:50579 "EHLO
	mail-ew0-f225.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493402AbZHaVhq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 31 Aug 2009 23:37:46 +0200
Received: by ewy25 with SMTP id 25so4267493ewy.33
        for <multiple recipients>; Mon, 31 Aug 2009 14:37:39 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=iJz1YPZxFmcDPJqMCInWzTB55vZBn9Cfmtn9oje4Mu4=;
        b=fZqt1vfvkVW70npGA5BMGo2BXIcS2ZT1oMexUF51QcN8ncL9KwqfC/Y/mf7RBRb+6G
         grZXsJIbMIqpoF+FPnG4Olp4fUQmMSYS5L8mfHBmKn5nAS4+M+ODtSigvlDcCSM98II0
         W16qhr4wSelt4HM30s9U1oNx4Erf4Mnt3/UdQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding:message-id;
        b=MJRb+oXOHeSzHQx/nSLs7QdSjZAvZOc3BupfNHZ7AFAnR6uVIWYDqI6W0NCIK2AkNf
         FcAqq+qRev+b8S7pM4T/EuM52dTUuAuJdWxElc9G7yX36JsIBwqOnGasgGMnEDeRxOz0
         F6qWFwolUhMDynkSgtIzbvKVaVSNXHbJG3/Gg=
Received: by 10.210.223.13 with SMTP id v13mr6008216ebg.65.1251754659770;
        Mon, 31 Aug 2009 14:37:39 -0700 (PDT)
Received: from lenovo.localnet (39.87.196-77.rev.gaoland.net [77.196.87.39])
        by mx.google.com with ESMTPS id 5sm133253eyh.10.2009.08.31.14.37.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 31 Aug 2009 14:37:39 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	mbizon@freebox.fr
Subject: Re: [PATCH 2/2] bcm63xx: only set the proper GPIO overlay settings
Date:	Mon, 31 Aug 2009 23:37:31 +0200
User-Agent: KMail/1.11.4 (Linux/2.6.29-2-686; KDE/4.2.4; i686; ; )
Cc:	ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
References: <200908312028.10931.florian@openwrt.org> <1251750389.10420.24.camel@sakura.staff.proxad.net>
In-Reply-To: <1251750389.10420.24.camel@sakura.staff.proxad.net>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4782777.z69GNHW7dz";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200908312337.36634.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23972
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

--nextPart4782777.z69GNHW7dz
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Le lundi 31 ao=FBt 2009 22:26:29, Maxime Bizon a =E9crit :
> On Mon, 2009-08-31 at 20:28 +0200, Florian Fainelli wrote:
> > This patch makes the GPIO pin multiplexing configuration
> > read the initial GPIO mode register value instead of
> > setting it initially to 0, then setting the correct
> > bits, this is safer.
>
> I disagree, now we get working or not working devices depending on the
> CFE version used, for which we don't have any public source code nor
> changelog.

I did not think this could break other boards, it is required on BCM6345=20
though.

>
> I cleared the register for that purpose.
>
> If a particular pin muxing config is needed for some board, we should
> add this to the board specific struct instead.

Then I will make it BCM6345 specific.

Thanks.
=2D-=20
Best regards, Florian Fainelli
Email: florian@openwrt.org
Web: http://openwrt.org
IRC: [florian] on irc.freenode.net
=2D------------------------------

--nextPart4782777.z69GNHW7dz
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10rc1 (GNU/Linux)

iEYEABECAAYFAkqcQpwACgkQlyvkmBGtjyZo7wCfTLRLQ8MEYYMhuEnbHrGb5sF5
uWcAoJJbCHwNuqyO6CkBIDjcctKcBE2q
=n7jI
-----END PGP SIGNATURE-----

--nextPart4782777.z69GNHW7dz--
