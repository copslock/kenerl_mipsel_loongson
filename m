Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 May 2012 10:41:23 +0200 (CEST)
Received: from mail-lpp01m010-f49.google.com ([209.85.215.49]:36742 "EHLO
        mail-lpp01m010-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903611Ab2EFIlQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 6 May 2012 10:41:16 +0200
Received: by laap9 with SMTP id p9so145592laa.36
        for <multiple recipients>; Sun, 06 May 2012 01:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:references
         :content-type:x-mailer:mime-version;
        bh=XhQqW23WgQ1pPtm8IxQXKqXsfYYHEs1HLRBD/sTksBo=;
        b=A07KtA981MVMKXlvDaQIWp1hBCiOWg6AAy+nnKMcS4zFlPLhofAsMvCFZzpYWWvrr2
         vorijhMQg5+3RbH9AvWh6x57w+Xoy3ZiLiz7Hq5SG1i8Adexw6Pa7TOWpxXfZbRFHRh2
         MFGzlkhgvXn7zlsrabUU1akkz/DiN6W97XwVCSrAUR6fC23Kk/2/IcqTCkXJNmXutHRl
         lAgvZEWFhkDWETigf3iFsdxuRLWfoinjvxcw/c1bn76WNn8o9L5J46x8FXPmYmtEJCai
         BGOk6LWhHYJzEkA2wYaATrGVlcXc3dtB8b+DJReiyUF2ROR4bCHozIsGnsrsJcbthz0R
         g7Tg==
Received: by 10.112.46.9 with SMTP id r9mr5371828lbm.81.1336293670658;
        Sun, 06 May 2012 01:41:10 -0700 (PDT)
Received: from [192.168.255.6] (host-94-101-1-70.igua.fi. [94.101.1.70])
        by mx.google.com with ESMTPS id n6sm18428266lbn.11.2012.05.06.01.41.09
        (version=SSLv3 cipher=OTHER);
        Sun, 06 May 2012 01:41:09 -0700 (PDT)
Message-ID: <1336293478.2801.4.camel@brekeke>
Subject: Re: [PATCH 1/2] MIPS: Kbuild: remove -Werror
From:   Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>
Date:   Sun, 06 May 2012 11:37:58 +0300
In-Reply-To: <alpine.LFD.2.00.1205060925070.3701@eddie.linux-mips.org>
References: <1335534510-12573-1-git-send-email-dedekind1@gmail.com>
                 <4F9AD14E.9060008@gmail.com>
                 <alpine.LFD.2.00.1205060754390.19691@eddie.linux-mips.org>
         <1336289676.1996.3.camel@koala>
         <alpine.LFD.2.00.1205060925070.3701@eddie.linux-mips.org>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
        boundary="=-zx+FSKpyo6Iigd1GpIWq"
X-Mailer: Evolution 3.2.3 (3.2.3-3.fc16) 
Mime-Version: 1.0
X-archive-position: 33172
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dedekind1@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>


--=-zx+FSKpyo6Iigd1GpIWq
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2012-05-06 at 09:32 +0100, Maciej W. Rozycki wrote:
>  And my opinion is based on experience.  Please check the LMO archives fo=
r=20
> why Ralf added this option in the first place -- many years ago.  It's=
=20
> probably recorded in the git repository too (I'm not sure if the option=
=20
> was added before or after we moved away from CVS, but in any case old=20
> change logs have been imported when our current repo was created).

We need to figure out how to make -Werror be applied only when we do not
have W=3D[123].

--=20
Best Regards,
Artem Bityutskiy

--=-zx+FSKpyo6Iigd1GpIWq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABAgAGBQJPpjhmAAoJECmIfjd9wqK0Iu0P/ResM+xG1yFV6VxH307EfkB7
9PUcwBdciN88g2XvYKvDAGJTN4o2uVRAHVtDuob76yp1o+YbHSHtKWQnu++nFZGF
EyVFWpNXFALhJ+tP8GiwZe+t4GGXb5iFWkDMZKGTYz1TokXeHF7uOtH9LbTMss8P
hFgkfD9VmaN1BE5HHWndQH5MkQPG6nB0z/L03SzZd5VR7BZcKYYyEbb1wsq4awHD
AeO6wpqS5ILtv81lmX5AT2eXbEfMOouXitfgf7VTort2A2KVV0zxBfORqUO+jvvx
rPt/dXwYzgJRfOjLly+VUJ0A+2h9nHqGZqNnu6wyh7vfKhWRRSgv1aJkBNCNV0dL
87YGbF1i09hViFUXo9p1gHpcAVKP58T3VQcFg0RmfeBEtKMud9iehiOO7Lb8MPxk
J/Td7Ehy9z1Kb+WYd2hWUeFA+7dJVl/5B8GT0sN4K6Zj9007nj67Dt/vqXPF0/Tf
VMKzAB8sD1JCehj0YFI1vJPN/A+YN+zOmKVkUE5K5Lpa8AygzMeTHrmNCXNTivhd
7MbTAWhGf1VKtmeI7ZqHaR3imxb6H5wuxnx8LuTSFhaYm1rLWOamMxcKBgSwAAfu
X+vyZz/t+gNvqJ0bJF6Gf9PyBMYdyDOctBZcNvVjFkUQnBKu7AIpIpx9e/XVGVUD
FYT3A9ldZOgDu4KVgvHS
=gV0L
-----END PGP SIGNATURE-----

--=-zx+FSKpyo6Iigd1GpIWq--
