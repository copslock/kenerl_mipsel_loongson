Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Feb 2015 12:06:38 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:60120 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27007076AbbBYLGhTchmg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Feb 2015 12:06:37 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 663BC41F800E;
        Wed, 25 Feb 2015 11:06:32 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Wed, 25 Feb 2015 11:06:32 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Wed, 25 Feb 2015 11:06:32 +0000
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id B7C913EA3B22C;
        Wed, 25 Feb 2015 11:06:29 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 25 Feb 2015 11:06:32 +0000
Received: from [192.168.154.110] (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 25 Feb
 2015 11:06:31 +0000
Message-ID: <54EDACB7.7070907@imgtec.com>
Date:   Wed, 25 Feb 2015 11:06:31 +0000
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Jason Wessel <jason.wessel@windriver.com>,
        <kgdb-bugreport@lists.sourceforge.net>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        "Andrew Bresticker" <abrestic@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH 0/9] Add MIPS EJTAG Fast Debug Channel TTY driver
References: <1422530054-7976-1-git-send-email-james.hogan@imgtec.com>
In-Reply-To: <1422530054-7976-1-git-send-email-james.hogan@imgtec.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature";
        boundary="VhTDhhw5gEJMgA7rfb7MP395vFrqQ5Ogm"
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: da4c5968
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45956
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

--VhTDhhw5gEJMgA7rfb7MP395vFrqQ5Ogm
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi,

On 29/01/15 11:14, James Hogan wrote:
> This patchset adds a TTY, console, and KGDB driver for the MIPS Fast
> Debug Channel (FDC) hardware, for communicating with a debugger via an
> EJTAG probe. 16 TTY ports are created per FDC device, corresponding to
> the 16 FDC channels. Each VPE usually has its own FDC instance.

It'd be great to get these patches upstream for v4.1 via the MIPS tree
along with my other two patchsets it depends on ([v2] Add MIPS CDMM bus
support, and MIPS: Allow shared IRQ for timer & perf counter), so
Acks/Reviews from TTY maintainers in particular would be really
appreciated.

Btw, more info about the FDC can be found here:
http://www.linux-mips.org/wiki/FDC

And a git branch containing the latest version of all 3 patchsets
(basically just rebased on v4.0-rc1 to resolve conflicts) can be found
here:
git://git.kernel.org/pub/scm/linux/kernel/git/jhogan/mips.git fdc

Thanks
James

>=20
> This patchset depends on my recent CDMM bus patchset (the FDC is in the=

> per-CPU CDMM region), and my recent MIPS timer & perf counter IRQ
> sharing patchset (the FDC IRQ is a local CPU IRQ which may similarly
> share CPU IRQ lines with the other local IRQs).
>=20
> Patches 1 to 6 add the necessary architecture bits for the FDC
> interrupt, and a workaround in the MIPS idle code to avoid the wait
> instruction on certain cores if FDC driver is enabled.
>=20
> Finally patches 7-9 add the main TTY/console driver, wire up some early=

> console code, and implement KGDB operations & magic sysrq.
>=20
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Andrew Bresticker <abrestic@chromium.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.cz>
> Cc: Jason Wessel <jason.wessel@windriver.com>
> Cc: linux-mips@linux-mips.org
> Cc: kgdb-bugreport@lists.sourceforge.net
>=20
> James Hogan (9):
>   MIPS: Add architectural FDC IRQ fields
>   MIPS: Read CPU IRQ line that FDC to routed to
>   irqchip: mips-gic: Don't treat FDC IRQ as percpu devid
>   irqchip: mips-gic: Add function for retrieving FDC IRQ
>   MIPS: Malta: Implement get_c0_fdc_int()
>   MIPS: idle: Workaround wait + FDC problems
>   tty: Add MIPS EJTAG Fast Debug Channel TTY driver
>   MIPS, ttyFDC: Add early FDC console support
>   ttyFDC: Implement KGDB IO operations.
>=20
>  arch/mips/include/asm/cdmm.h     |   11 +
>  arch/mips/include/asm/irq.h      |    3 +
>  arch/mips/include/asm/mipsregs.h |    4 +
>  arch/mips/kernel/idle.c          |   13 +-
>  arch/mips/kernel/setup.c         |    2 +
>  arch/mips/kernel/traps.c         |   11 +
>  arch/mips/mti-malta/malta-time.c |   16 +
>  drivers/irqchip/irq-mips-gic.c   |   38 +-
>  drivers/tty/Kconfig              |   47 ++
>  drivers/tty/Makefile             |    1 +
>  drivers/tty/mips_ejtag_fdc.c     | 1303 ++++++++++++++++++++++++++++++=
++++++++
>  include/linux/irqchip/mips-gic.h |    1 +
>  12 files changed, 1443 insertions(+), 7 deletions(-)
>  create mode 100644 drivers/tty/mips_ejtag_fdc.c
>=20


--VhTDhhw5gEJMgA7rfb7MP395vFrqQ5Ogm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJU7ay3AAoJEGwLaZPeOHZ642kQAJCfrNW5SMowo/Be+efIAcuq
xokak6QixsdYxTlGfb24TTuJI9++lXbFwq8v9HzpjEoH13v6154mJyRKUz0I90IG
Idq0oGNTxfuaETID0MLHfSAEkmNErhaoQMHlGxy/mKRkJS29/aZSSvLyuO81Dra1
Y7k/k8KRMawehG6Hk105VqVZ1P+Ex6e7HGnIDpgyWf61t4aZpjzhKaWGt5+bnGTY
O8A5fBSut76zu0xzsoysxM3KlbjbciHd2dJvc9Ps6z9auzmbX0HJBr2dnzDGS9J7
BIkug5mvL8KaG47yxV1no6PvxojGI98ZW3JHRn8S8bwImwhtYzAvBaWDTE2qvfpx
Mwl9XljoBsImlBVncCidRiv18mfICtxexgaJpLCNj17r2kJeuaarZb9+vfO5PbWJ
uulOnYZmUg/hn5EIuklI0XrlNPy/a2vxSTH8sSPSWpBXuxJXFaXnFf/nwjFHljL+
wNZlhQ1+TBe7wBaMza8VMsSUkXvPPx9NDsQm2/ovVg/0c1LFJZduKXfceF2+tjCk
HkX0w/77g2/PjpzhyxWgEv3uzPscaKsCsr+pTVH5TAeXaddrdYONRAqmnUp7CBXZ
Wq6O9KcWs+JQtP8hvJk8QI2H7jaSLjreXWyUTfKEROkXf4mCMnKindLXMBCMF4E+
K2mQLnXULqhtfyoIPyHU
=pfS2
-----END PGP SIGNATURE-----

--VhTDhhw5gEJMgA7rfb7MP395vFrqQ5Ogm--
