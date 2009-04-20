Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Apr 2009 09:57:27 +0100 (BST)
Received: from mail-qy0-f103.google.com ([209.85.221.103]:7341 "EHLO
	mail-qy0-f103.google.com") by ftp.linux-mips.org with ESMTP
	id S20024164AbZDTI5R (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Apr 2009 09:57:17 +0100
Received: by qyk1 with SMTP id 1so3694311qyk.22
        for <linux-mips@linux-mips.org>; Mon, 20 Apr 2009 01:57:10 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=IywtukjQfrz3/QEePxOzU6hndG+XMhh0kdlnbDkJ8k8=;
        b=oHvdLfHWq8HguOJXl/JVs5H+qAAogSNvIFp/REJW1PsIV3O/AXM3PInhAnaIi6Gz9b
         MxpBOkPmPIBpmhe2Hc0Fh5TT7z9T0X32F8GuCAfGCJMfHnBRj9KNt7yJaxL3vJJN4WTY
         J8gQpTa7i6lzuXlJNIrioAJVXwDkKvscn3ZOA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding:message-id;
        b=u5a02ztDYDLnCJz6jjWdTePpT6rcyerLAD4K5D0okgect8iqORjXjhTRzQz/C+3ZoL
         Rr9OpzDJxUBXU8lm6PE3PhCtUu7EhuktFIms+Sk+WPNVWpiWUMBVDvijAq0gmA3OSHZs
         GLKq0rgkpWDSd1cWXpJ8wywPDjvpdaWbfH7qE=
Received: by 10.220.92.80 with SMTP id q16mr5515487vcm.58.1240217829913;
        Mon, 20 Apr 2009 01:57:09 -0700 (PDT)
Received: from florian.lab.openpattern.org (lab.openpattern.org [82.240.16.241])
        by mx.google.com with ESMTPS id 6sm16993085yxg.30.2009.04.20.01.57.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 20 Apr 2009 01:57:09 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Carlos Mitidieri <cam@sysgo.com>
Subject: Re: Boot program interface
Date:	Mon, 20 Apr 2009 10:57:02 +0200
User-Agent: KMail/1.9.9
Cc:	linux-mips@linux-mips.org
References: <1240213045.49ec26350fa49@www.sysgo.com>
In-Reply-To: <1240213045.49ec26350fa49@www.sysgo.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1571897.qfJFpkZRCP";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200904201057.04833.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22381
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

--nextPart1571897.qfJFpkZRCP
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Carlos,

Le Monday 20 April 2009 09:37:25 Carlos Mitidieri, vous avez =E9crit=A0:
> Hello,
>
> I am working on a project that requires an extensive boot program
> interface.
>
> It turns out that the device tree used on PPC architecture meets the
> requirements.
>
> I have been looking, and I could not find any similar concept implemented
> for MIPS.

I do not know any MIPS board using a device tree either.

>
> So, I am now considering to port the OFDT library into the MIPS arch.
>
> What do you think about this? Is there anyone working on a similar projec=
t?

You should see how Sparc, PowerPC and Microblaze use it and how they do sha=
re=20
code. Also condiser seeing how u-boot handles device trees, specifically on=
=20
PowerPC and Microblaze.

Hope that helps.
=2D-=20
Best regards, Florian Fainelli
Email : florian@openwrt.org
http://openwrt.org
=2D------------------------------

--nextPart1571897.qfJFpkZRCP
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAknsON8ACgkQlyvkmBGtjyZG/QCfcS5lD/LS5PrbZs46wXvdd5uR
ZwkAn02SDY2BzRGWcm4cDhBmy2Q7l6Zd
=+98k
-----END PGP SIGNATURE-----

--nextPart1571897.qfJFpkZRCP--
