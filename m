Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Apr 2018 15:05:30 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:39746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993856AbeDXNFX5Hruw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 24 Apr 2018 15:05:23 +0200
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A51B21774;
        Tue, 24 Apr 2018 13:05:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A51B21774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Tue, 24 Apr 2018 14:05:12 +0100
From:   James Hogan <jhogan@kernel.org>
To:     Matt Redfearn <matt.redfearn@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Huacai Chen <chenhc@lemote.com>, linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Robert Richter <rric@kernel.org>, oprofile-list@lists.sf.net
Subject: Re: [RFC PATCH] MIPS: Oprofile: Drop support
Message-ID: <20180424130511.GB28813@saruman>
References: <1524574554-7451-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZoaI/ZTpAVc4A5k6"
Content-Disposition: inline
In-Reply-To: <1524574554-7451-1-git-send-email-matt.redfearn@mips.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63727
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


--ZoaI/ZTpAVc4A5k6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Tue, Apr 24, 2018 at 01:55:54PM +0100, Matt Redfearn wrote:
> Since it appears that MIPS oprofile support is currently broken, core
> oprofile is not getting many updates and not as many architectures
> implement support for it compared to perf, remove the MIPS support.

That sounds reasonable to me. Any idea how long its been broken?

I'll let it sit on the list for a bit in case anybody does object and
wants to fix it instead.

Thanks
James

--ZoaI/ZTpAVc4A5k6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWt8rhwAKCRA1zuSGKxAj
8lZfAP9eSR44etV2E3TeKaFlQdlxvJdyf/JV8kY8kvLjADfstQEA8TIZDjOp0bcZ
CDH4FQuVp/SeqEFuxNED3nw+3UudqQ8=
=hVzL
-----END PGP SIGNATURE-----

--ZoaI/ZTpAVc4A5k6--
