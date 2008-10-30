Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2008 18:16:40 +0000 (GMT)
Received: from ey-out-1920.google.com ([74.125.78.150]:9736 "EHLO
	ey-out-1920.google.com") by ftp.linux-mips.org with ESMTP
	id S22755814AbYJ3SQd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 30 Oct 2008 18:16:33 +0000
Received: by ey-out-1920.google.com with SMTP id 4so358549eyg.54
        for <linux-mips@linux-mips.org>; Thu, 30 Oct 2008 11:16:29 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:message-id:sender;
        bh=V9Ws4t+fYscCiToRCVJfBw01aAFRt/Ptb7enXQn/wmY=;
        b=TTZz4tYVtgPvsYmPWrrPFGequScNZQVgP25zGbAdXFQ9hcNB67Su8jBEB5NOoD7PRA
         XDYgdrxoTlsfDMdfaNdnVuSOTz3T20NmhUw90owICbRFhal/8m1bYP30osZSoVG36Jal
         pMYuCvyuVFjv/oFwJVVq4WOxnqsPUF1M6TFp0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding:message-id
         :sender;
        b=GUMf3/p8/0GgkhRkSnKGWEfbboPEmCjkCYd4l9S2rCL+1PdtUFCmoQvnt7fDyyqXyH
         gOHS6ZDckCsSXAOKFPJ0MIvPqnrs7oIwXIEG1WMAuJNLBcu+SrMTaM5UbHozRDFUDtEs
         X8VZbpOAjy+gLE3MMrs11HVB2DlTtCaV6wRsY=
Received: by 10.86.57.9 with SMTP id f9mr7418450fga.32.1225390589286;
        Thu, 30 Oct 2008 11:16:29 -0700 (PDT)
Received: from florian.headquarters.openpattern.org (headquarters.openpattern.org [82.240.17.188])
        by mx.google.com with ESMTPS id d6sm2730510fga.2.2008.10.30.11.16.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 30 Oct 2008 11:16:28 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Phil Sutter <n0-1@freewrt.org>
Subject: Re: [PATCH] provide functions for gpio configuration
Date:	Thu, 30 Oct 2008 19:16:21 +0100
User-Agent: KMail/1.9.9
Cc:	Linux-Mips List <linux-mips@linux-mips.org>
References: <1225310409-4440-1-git-send-email-n0-1@freewrt.org> <200810301813.05710.florian@openwrt.org> <20081030174715.GA10620@nuty>
In-Reply-To: <20081030174715.GA10620@nuty>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart10054593.SGY4B2At3z";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200810301916.25290.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21125
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

--nextPart10054593.SGY4B2At3z
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Phil,

Le Thursday 30 October 2008 18:47:15 Phil Sutter, vous avez =C3=A9crit=C2=
=A0:
> Sounds reasonable to me. So I'll prepare a patch which:
> * removes the function pointers from rb532_gpio_chip
> * exports getters and setters for interrupt status and level
>
> The GPIO config and function registers should indeed only be accessed at
> bootup, so the corresponding getters/setters will be only locally
> accessible in arch/mips/rb532/gpio.c. Doing it this way also prevents
> any driver from breaking others, as the complete GPIO configuration will
> be done at a single place (i.e., inside gpio.c). IIRC pata-rb532-cf did
> use them only at initialisation state and to prevent the described
> situation.

Perfect.

>
> I got the pata driver working by the way. I just wanted to get a
> solution for the GPIO problem first, as it needs to access interrupt
> level and status at least.

Great :) Good job.
=2D-=20
Best regards, Florian Fainelli
Email : florian@openwrt.org
http://openwrt.org
=2D------------------------------

--nextPart10054593.SGY4B2At3z
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkJ+fUACgkQlyvkmBGtjyb+ZACghJehJFeZR46Zhan5Qa8cCTFq
7pcAoJATTLirELXxbvn3TARhatCQTs7j
=RmBG
-----END PGP SIGNATURE-----

--nextPart10054593.SGY4B2At3z--
