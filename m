Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Dec 2014 00:16:36 +0100 (CET)
Received: from utopia.booyaka.com ([74.50.51.50]:32834 "EHLO
        utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007513AbaLJXQdhBESY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Dec 2014 00:16:33 +0100
Received: (qmail 26807 invoked by uid 1019); 10 Dec 2014 23:16:30 -0000
Date:   Wed, 10 Dec 2014 23:16:30 +0000 (UTC)
From:   Paul Walmsley <paul@pwsan.com>
To:     =?ISO-8859-2?Q?Rafa=B3_Mi=B3ecki?= <zajec5@gmail.com>
cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        Ingo Molnar <mingo@elte.hu>, Ingo Molnar <mingo@kernel.org>,
        Jeff Garzik <jgarzik@redhat.com>,
        Jesse Barnes <jbarnes@virtuousgeek.org>,
        Konrad Rzeszutek Wilk <konrad@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matt Fleming <matt.fleming@intel.com>,
        Tony Luck <tony.luck@intel.com>, linux-soc@vger.kernel.org
Subject: Re: [PATCH][RFC] MIPS: BCM47XX: Move NVRAM driver to the
 drivers/firmware/
In-Reply-To: <1418212587-19774-1-git-send-email-zajec5@gmail.com>
Message-ID: <alpine.DEB.2.02.1412102300090.29716@utopia.booyaka.com>
References: <1418212587-19774-1-git-send-email-zajec5@gmail.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="843723315-108983415-1418253390=:29716"
Return-Path: <paul@pwsan.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44618
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul@pwsan.com
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-108983415-1418253390=:29716
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 10 Dec 2014, Rafa=C5=82 Mi=C5=82ecki wrote:

> After Broadcom switched from MIPS to ARM for their home routers we need
> to have NVRAM driver in some common place (not arch/mips/).
> We were thinking about putting it in bus directory, however there are
> two possible buses for MIPS: drivers/ssb/ and drivers/bcma/. So this
> won't fit there neither.
> This is why I would like to move this driver to the drivers/firmware/
>=20
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com>
> ---
> Hey, this is another try for the NVRAM driver. At first I tried moving it=
 to the
> drivers/misc/, but then decided drivers/soc/ will be better. Then after
> discussion with Paul we decided to try drivers/firmware/ and so I do.
>=20
> Meanwhile I've sent few patches cleaning nvram.c: following kernel coding=
 style
> and using helpers like readl.
>=20
> I would like to get few Reviewed-by for this patch. If I get that, then I=
'll
> re-send this patch to Ralf without the RFC.
>=20
> If you want to review nvram.c code, please make sure to check version in
> ralf/upstream-sfr.git repository as it contains many cleanups:
> git://git.linux-mips.org/pub/scm/ralf/upstream-sfr.git
> http://git.linux-mips.org/cgit/ralf/upstream-sfr.git/log/
>=20
> Mentioned patches (more cleanups):
> http://patchwork.linux-mips.org/project/linux-mips/list/?submitter=3D478
>=20
> Finally: why drivers/firmware/? Please see Paul's e-mail:
> <alpine.DEB.2.02.1411271926560.1406@utopia.booyaka.com>
> http://www.linux-mips.org/archives/linux-mips/2014-11/msg00678.html
>=20
> Unfortunately there is no mailing list for drivers/firmware/, so I've
> picked ppl with 5+ commits to this directory. Hope this is OK.

Reviewed-by: Paul Walmsley <paul@pwsan.com>

Just to restate, if it's unclear for any other reviewers (as it initially=
=20
was for me): this isn't an NVRAM driver as most folks understand the term. =
=20
This "NVRAM" code parses SoC configuration data that is passed to the=20
kernel in flash from the bootloader firmware, "CFE".


- Paul
--843723315-108983415-1418253390=:29716--
