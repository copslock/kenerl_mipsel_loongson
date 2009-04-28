Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Apr 2009 14:01:53 +0100 (BST)
Received: from mail-bw0-f177.google.com ([209.85.218.177]:36484 "EHLO
	mail-bw0-f177.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20025448AbZD1NBr (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 28 Apr 2009 14:01:47 +0100
Received: by bwz25 with SMTP id 25so552165bwz.0
        for <linux-mips@linux-mips.org>; Tue, 28 Apr 2009 06:01:41 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=vYxTf754qxWV8+7RQiOZIgkhy63JRe52ibOYahS2MDk=;
        b=NgN1ZQW33T2MGb5/iRjb2es4+6A7oj7K7K0itUatKN0aQAarb1z91vhWicCWAYblFg
         vQkw378kT/bKrJEgVufYefHt7FYaWTyROnP+VbSn0tZ+UnyRtyVp3XHZx5F881/P9ZO/
         MRyi/qKGe2xIbiQRwJ3H0MndoXcGXj3OJ13hQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding:message-id;
        b=sCKNYgmfQmklx+y0AcYA1+CoaeIPr14Us81elUfVNqx6FrJrrkoA9Oocog0kBQMLMD
         vb/7HP5myCwmLt6WaR8gbebalh5MZfCCUd4E3GkeVV2GI0ZJSqdFpnwEgpzmFngMekN7
         hv26QGy9kmYchu2X88AyiwRAmh72WqTbv8g6M=
Received: by 10.204.55.140 with SMTP id u12mr6411410bkg.127.1240923701527;
        Tue, 28 Apr 2009 06:01:41 -0700 (PDT)
Received: from florian.lab.openpattern.org (lab.openpattern.org [82.240.16.241])
        by mx.google.com with ESMTPS id g28sm10198195fkg.25.2009.04.28.06.01.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Apr 2009 06:01:41 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Andrew Wiley <debio264@gmail.com>
Subject: Re: Linux on Linksys PSUS4?
Date:	Tue, 28 Apr 2009 15:01:35 +0200
User-Agent: KMail/1.9.9
Cc:	linux-mips@linux-mips.org
References: <ecbbfeda0904280458s4bb2de2q6c629ed79a472adc@mail.gmail.com>
In-Reply-To: <ecbbfeda0904280458s4bb2de2q6c629ed79a472adc@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3531336.vUfGevqA2q";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200904281501.37811.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22511
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

--nextPart3531336.vUfGevqA2q
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Le Tuesday 28 April 2009 13:58:38 Andrew Wiley, vous avez =C3=A9crit=C2=A0:
> I stumbled onto this website while doing some research on a Linksys
> printserver I retired a while back (the firmware kept crashing, but I don=
't
> think it was a hardware problem), and I'm wondering if it would be possib=
le
> to install Linux on it. It has an ADM5120P, and the hardware seems to be
> supported, but how would I go about installing anything? Is there a serial
> port header that I need to use? Would using it equate to soldering a seri=
al
> port to it?

Soldering a seria port is not an option if you want to do something serious=
=20
with it.

> Is it even feasible to have a linux system running on 1MB of flash and 4 =
MB
> of RAM?

That's too small you would need at least 2MB Flash and 8MB RAM.
=2D-=20
Best regards, Florian Fainelli
Email : florian@openwrt.org
http://openwrt.org
=2D------------------------------

--nextPart3531336.vUfGevqA2q
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkn2/jAACgkQlyvkmBGtjyZ0dQCeJjnM84wVfq8i1YH1UjCkH72T
IyAAoLHlncq/Ci03ApORoh6GFhYtayWd
=0WlE
-----END PGP SIGNATURE-----

--nextPart3531336.vUfGevqA2q--
