Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Feb 2018 12:05:27 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:55068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990393AbeBOLFUttkeQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 15 Feb 2018 12:05:20 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14CDE217BB;
        Thu, 15 Feb 2018 11:05:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14CDE217BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Thu, 15 Feb 2018 11:05:07 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Subject: Re: [PATCH V2 00/12] MIPS: Loongson: new features and improvements
Message-ID: <20180215110506.GH3986@saruman>
References: <1517022752-3053-1-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HuscSE0D68UGttcd"
Content-Disposition: inline
In-Reply-To: <1517022752-3053-1-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62549
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jhogan@kernel.org
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


--HuscSE0D68UGttcd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 27, 2018 at 11:12:20AM +0800, Huacai Chen wrote:
> This patchset is prepared for the next 4.16 release for Linux/MIPS. It
> add Loongson-3A R3.1 support, enable Loongson-3's SFB at runtime, adds
> "model name" and "CPU MHz" knobs in /proc/cpuinfo which is needed by
> some userspace tools, adds Loongson-3 kexec/kdump and CPUFreq support,
> fixes CPU UART irq delivery problem, and introduces WAR_LLSC_MB to
> improve stability.
>=20
> V1 -> V2:
> 1, Add Loongson-3A R3.1 basic support.
> 2, Fix CPU UART irq delivery problem.
> 3, Improve code and descriptions (Thank James Hogan).
> 4, Sync the code to upstream.

I few general suggestions that I hope will help you to get your patches
applied quicker:

- Please have a separate series for each group of related changes in
  future. It makes them more manageable, makes dependencies clearer, and
  avoids unchanged resends of unrelated patches when you respin the
  whole series. Series are mainly to group tightly related patches, or
  because of dependencies of later patches on earlier ones (and even if
  you have a series of 30 dependent patches, you can still sometimes
  split it into groups and mention in the cover letters which other
  pending series each series depends on).

- More importantly, avoid moving patches between series or adding
  unrelated patches to a series if possible (so probably best not to
  split this series now). It makes it harder to see what has changed,
  whether past feedback has been addressed, and whether new/removed
  patches are new/abandoned or simply moved from/to a different series.

- Please don't resend a series without changes, ping it if you are
  concerned. It clutters patchwork for no good reason and makes it
  harder to see if past feedback has been addressed.

- Please run checkpatch on all patches before submission, and fix any
  reasonable warnings and errors (i.e. there are various lines exceeding
  80 characters in this series which should be split, but some are
  acceptable where its to keep a string together).

- Please include Fixes tags where appropriate, especially where you've
  Cc'd stable.

- If you Cc stable, please state how far back it should be backported
  wherever possible,
  E.g. Cc: <stable@vger.kernel.org> # 4.14+
  This may help finding what version a commit is first included in:
  https://www.linux-mips.org/archives/linux-mips/2017-07/msg00149.html

- Please run get_maintainer.pl on each patch to make sure you cc the
  appropriate maintainers and lists (and Cc them on the cover letter
  too). Its fine to skip LKML for lots of MIPS patches, but don't miss
  out the appropriate subsystem maintainers and lists for patches
  touching drivers/ or they'll never get acked and never get applied.

- Split arch/mips/ and drivers/ patches wherever possible.

Cheers
James

--HuscSE0D68UGttcd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqFaVwACgkQbAtpk944
dnokaBAAjvTgO3Z7wjaE1Bwqx/9YHiQC3k9Dh/do7d/YMqoNJYvznc389mHXJULl
kV3G56RHWOeeQ0m9G3vSPTtki8zaPYfqGiplSFliu1GfjUNw7g8UP/fh3DsgnoyD
Klqvgzt9XfPkYpfE6OR126bDWnoBzKDn7kuN1kgWrnZc+/YtpkFVynk60FjeIkh7
6MBuDFShtsW4ckJFO82Iwvl3phxomY2MOlFk38H40NZgn9bEzs7VrXJEn4/7YXQN
Vz2JO4wqmv7wEavQ5R/6pckO4KlFyut5uZnmQDcCpfTVGWSexa8wchxp+/YIQSKh
ySD+CkJelVGuP/Tud92UQJsNJiNgqJ8m/PtE9ZQSoU59ro0icUHGeDcpQayomdsl
A8mDNui6Liju6T5ZFbQZwIvzt4a4f72pH0IAy/D4zd0WojhwANj2wjb4Nukz9Im7
y1FvDu36VZxqUNyUGplQ/F4pl2pMcWSeWTFmI9p1oWr8SbqRVIgpKq10HV6KYmvY
lcwZsPwXjFjNOSvUM6ktCKiY7COAdvVabt215i2z5RUu/19Tl00ts/sCeV0FQcWf
CN+lUyPlFUapjswgDB5qMqokGpR8WFvDr7G4HwbcXYFjVFTcK+Oxfzh0NhTGmtZv
d+7dmIwTi0zqw5eKyC2KGQviIRX12mVOglhDrEugFUfx9JIsbmY=
=cwTp
-----END PGP SIGNATURE-----

--HuscSE0D68UGttcd--
