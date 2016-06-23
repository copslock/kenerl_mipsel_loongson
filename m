Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jun 2016 14:06:44 +0200 (CEST)
Received: from mail-wm0-f54.google.com ([74.125.82.54]:36563 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013713AbcFWMGnTxDxu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Jun 2016 14:06:43 +0200
Received: by mail-wm0-f54.google.com with SMTP id f126so124173219wma.1;
        Thu, 23 Jun 2016 05:06:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=iDaR9bqewn3iYhupYjhj+6h+wemFBBElARaGh3eqMPg=;
        b=OiHmRD3zDOPp2EPfdpl+7QagWVSBTWr+vvGwYvxXUJIPYpM8TVjRlIhnGHLPKX09MZ
         nodIV/e4DjoiZrFE9VXxXgsQm0Z3ZEAWa9Kbw6fMW8y6w7YplSi86W/V4DHQtdSFVaMs
         X3m2ydR8NhW2LKR2jClaWCgMFop3a935/w1ON29sWoyE+dUMMy9Qd7cuhjzHzxigN73w
         dYqWNQY2UsWRfBOUd3Dman5grsbpp9an7JqN2RCEhITTtcSzT3nsvwJGkWdUVTzoe4t2
         WYS8fa/2VtEL5C+fU6b9TbnnKUou+t/ZomMyCmS7bFuLEP9LsihSogAEfl/zCswq/6Du
         fQKA==
X-Gm-Message-State: ALyK8tIFsb0TEVvw+gsGleht1vNbVs//WCIH7g13rMtAEF4oTmuTTW05vXYiKDxIxrpuHA==
X-Received: by 10.194.239.163 with SMTP id vt3mr29023293wjc.78.1466683598009;
        Thu, 23 Jun 2016 05:06:38 -0700 (PDT)
Received: from ?IPv6:2a01:4240:2e27:ad85:aaaa::19f? (f.9.1.0.0.0.0.0.0.0.0.0.a.a.a.a.5.8.d.a.7.2.e.2.0.4.2.4.1.0.a.2.v6.cust.nbox.cz. [2a01:4240:2e27:ad85:aaaa::19f])
        by smtp.gmail.com with ESMTPSA id t188sm3616794wma.8.2016.06.23.05.06.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jun 2016 05:06:36 -0700 (PDT)
Subject: Re: Please apply to stable, commit d7de413475f4 ("MIPS: Fix 64k page
 support for 32 bit kernels.")
To:     James Hogan <james.hogan@imgtec.com>, stable@vger.kernel.org
References: <20160620211712.GO30921@jhogan-linux.le.imgtec.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Harvey Hunt <Harvey.Hunt@imgtec.com>
From:   Jiri Slaby <jslaby@suse.cz>
Message-ID: <837526b3-b6e1-040f-f539-6e2dd37247bd@suse.cz>
Date:   Thu, 23 Jun 2016 14:06:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <20160620211712.GO30921@jhogan-linux.le.imgtec.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="irGWvnoUEdDMJlvfOmhBRrb6cD8C80EMN"
Return-Path: <jirislaby@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54133
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jslaby@suse.cz
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
--irGWvnoUEdDMJlvfOmhBRrb6cD8C80EMN
Content-Type: multipart/mixed; boundary="MBHIrVaOv3PXf8N5AjnpDUneCe186wkpO"
From: Jiri Slaby <jslaby@suse.cz>
To: James Hogan <james.hogan@imgtec.com>, stable@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
 Harvey Hunt <Harvey.Hunt@imgtec.com>
Message-ID: <837526b3-b6e1-040f-f539-6e2dd37247bd@suse.cz>
Subject: Re: Please apply to stable, commit d7de413475f4 ("MIPS: Fix 64k page
 support for 32 bit kernels.")
References: <20160620211712.GO30921@jhogan-linux.le.imgtec.org>
In-Reply-To: <20160620211712.GO30921@jhogan-linux.le.imgtec.org>

--MBHIrVaOv3PXf8N5AjnpDUneCe186wkpO
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/20/2016, 11:17 PM, James Hogan wrote:
> Please could commit d7de413475f443957a0c1d256e405d19b3a2cb22 ("MIPS: Fi=
x
> 64k page support for 32 bit kernels.") be applied to stable branches.
> This fix was merged into mainline for v4.5-rc4.

Applied to 3.12. Thanks.

--=20
js
suse labs


--MBHIrVaOv3PXf8N5AjnpDUneCe186wkpO--

--irGWvnoUEdDMJlvfOmhBRrb6cD8C80EMN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXa9DIAAoJEL0lsQQGtHBJeDYP/2ARlXhM4WcD0kMiTY7e/gGU
WpFbvT+sE7rBqXC7jRKRo3ptjYTosL7nIFT67gQaD4vY3mNLE9Zt/E2f1U9ymVXv
8i4UHNYG+eKZss9pHuVTrdXj7625rjXwTkdE+Piheew3oBGs1eU3tNQ+yX2h6xtr
bcLSeP6ZNxjrSqRye/NEgB+JxsVdaiTdbVGPk/iF7UKew7sLG28KHAzPuOQyAW8J
z1dBqjWKaFOhBxkuhyE9D6nKQt88TZeLTxInhbJ+Odg1x1aDUphuRt4k9nfa2Znu
skNgFa3TEw1bH5D76whgV4dBHKLdoq9EJeszDRdHMmVcN2wKYU8O+aFRXIgV6cv5
QwZA5Q0PbdHIDla+XQ7TuKOePWMiQFzC/04Mxl/7T9ws/erZIN6z6JOpeSSPV2aN
N19oMFKBm81dr+tO7XHG8DqH6BcOiPJoyEofWrs0ZLNZOT6WWpr9Y6cPzvnoyuBy
FI8wPD76aa9w1Q/ypRQq4onx6lhr/RF4oYyNr1GtGuSpnpR3Mgx10H9xxXilSxBs
Ja0q8NGRRylXv3c4PqCZP8B0hd2KwK/RYvXDjkGeZ87DOCTotWY0evLlyPcBtDu+
Q6Qu+IlukfEAZTSCJVN0vrBdDK7AqOHkD6sK5QTrARod/G1JebO5SnzG/5OvsOZ1
pS0vFOXNQtwm3uwAYvKD
=9AIq
-----END PGP SIGNATURE-----

--irGWvnoUEdDMJlvfOmhBRrb6cD8C80EMN--
