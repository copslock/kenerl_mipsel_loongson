Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Feb 2014 07:27:36 +0100 (CET)
Received: from ozlabs.org ([203.10.76.45]:54947 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816822AbaBEG1dRJH2z (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 5 Feb 2014 07:27:33 +0100
Received: from canb.auug.org.au (ibmaus65.lnk.telstra.net [165.228.126.9])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 91F6E2C0097;
        Wed,  5 Feb 2014 17:27:29 +1100 (EST)
Date:   Wed, 5 Feb 2014 17:27:23 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linux-m68k@vger.kernel.org,
        akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        rusty@rustcorp.com.au, linux-arch@vger.kernel.org,
        kvm@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [GIT PULL] tree-wide: clean up no longer required #include
 <linux/init.h>
Message-Id: <20140205172723.3fa841793b3fa3f3f534937f@canb.auug.org.au>
In-Reply-To: <20140205060633.GE30094@gmail.com>
References: <1391547118-21967-1-git-send-email-paul.gortmaker@windriver.com>
        <CAP=VYLp+zus5591g-1YQBCJifbk+UY59yJ7rV06ZN3QhhdnK7w@mail.gmail.com>
        <20140205060633.GE30094@gmail.com>
X-Mailer: Sylpheed 3.4.0beta7 (GTK+ 2.24.22; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Wed__5_Feb_2014_17_27_23_+1100_gh/a8HjiUdsUGOqJ"
Return-Path: <sfr@canb.auug.org.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39217
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sfr@canb.auug.org.au
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

--Signature=_Wed__5_Feb_2014_17_27_23_+1100_gh/a8HjiUdsUGOqJ
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ingo,

On Wed, 5 Feb 2014 07:06:33 +0100 Ingo Molnar <mingo@kernel.org> wrote:
>=20
> So, if you meant Linus to pull it, you probably want to cite a real=20
> Git URI along the lines of:
>=20
>    git://git.kernel.org/pub/scm/linux/kernel/git/paulg/init.git

Paul provided the proper git url further down in the mail along with the
usual pull request message (I guess he should have put that bit at the
top).

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Wed__5_Feb_2014_17_27_23_+1100_gh/a8HjiUdsUGOqJ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJS8dnPAAoJEMDTa8Ir7ZwVybEP/31Z6vmdSzqXa6CGStETJw23
6BXTjf+UbSse//B/vkCLZLm698gmOezpw5NCnCKkK/rYTSJoE89rKmPnXB9H+0mD
96PWZbw2vTR6TzU9Om85nOdui2ly7mMCvtg7d+U4vqGM4bRzetFxSM0YV3yCKYaq
J0xttn7NnVnhCJpLVOofz9ulsnygMG6Gn0TSOomANZsBUpxZotvgdWGRZWgg1oVF
MILuhwwwu0mbgf+a1SSWQvAChiuCP63vveXTiwvjT57lDlJXRODyl912lp0SyGug
7Av6juPn1van5sXsHVqba3GT+4qeWN4DQkq017KZlJ0lGUiPg3HLCxagUzY64NfX
HPEVmRBlDpFRgX8ivTJmV/hYkL0aVhTsnqubd+q6E2MH3szdU/Gf3GAo4Dl/7QnG
nnkSUN0RP93xnM6hEORgGwkSSoEM0E4dvgZeGkPBs223BaEPAL+JLnEgHTXGk8gI
muoC0oBA1DvmbTYp6UgLTSRdQZYfMb/IdpExQGpEd7lF2DfOOKqm3pcktcG7nCSs
AaNdRepdtAY9vc2ISzNunqXta4TsOpKI7YPXEFvcuciVmj0lXkdKLCkp/1xj3v9t
vupSRjKH9tocr8kOS3uc+i9T8wZkHZ5I0/LRNux8AVLAtLKUQeYAt6ZAyrsDvToM
xuVmB/iHm04LyVGRQ59z
=XhOK
-----END PGP SIGNATURE-----

--Signature=_Wed__5_Feb_2014_17_27_23_+1100_gh/a8HjiUdsUGOqJ--
