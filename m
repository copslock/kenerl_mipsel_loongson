Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 May 2018 08:40:16 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:49168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990412AbeENGkJEW4kc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 May 2018 08:40:09 +0200
Received: from jamesdev (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EB992184C;
        Fri, 11 May 2018 21:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1526075776;
        bh=4q89doqwTzuIH7mFLKdQMW1Z6hclnYkoq6fOjrO3Wzw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oebdb4uutOn+i+CzS7HpbMA3MpF1Dk1xBSrJdgb55xW+mriUQ6v9VZxn5dVPEqwXy
         jr0dXgJ1wF9/e/Gst2MqUoZ7fNEyVXNpBkv606ndg+BmYDV8H4sbwFwqe+NJDwAzV9
         uwTskZAcEEuRjSaNLEZdI0Q2TThZ3K2B1CFrwSV8=
Date:   Fri, 11 May 2018 22:56:12 +0100
From:   James Hogan <jhogan@kernel.org>
To:     NeilBrown <neil@brown.name>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] MIPS: c-r4k: fix data corruption related to cache
 coherence.
Message-ID: <20180511215611.GB20355@jamesdev>
References: <87sh7klyhc.fsf@notabene.neil.brown.name>
 <20180425214650.GA25917@saruman>
 <87h8nzlzf1.fsf@notabene.neil.brown.name>
 <20180425220834.GC25917@saruman>
 <87vacdlf8d.fsf@notabene.neil.brown.name>
 <87lgcwcvj2.fsf@notabene.neil.brown.name>
 <20180507201655.GA27369@jamesdev>
 <87o9hraqlf.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XOIedfhf+7KOe/yw"
Content-Disposition: inline
In-Reply-To: <87o9hraqlf.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.9.5 (2018-04-13)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63918
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


--XOIedfhf+7KOe/yw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 08, 2018 at 11:22:36AM +1000, NeilBrown wrote:
> On Mon, May 07 2018, James Hogan wrote:
>=20
> > On Mon, May 07, 2018 at 07:40:49AM +1000, NeilBrown wrote:
> >>=20
> >> Hi James,
> >>  this hasn't appear in linux-next yet, or in any branch
> >>  of
> >>    git://git.kernel.org/pub/scm/linux/kernel/git/jhogan/mips.git
> >>=20
> >>  Should I expect it to?
> >
> > Sorry Neil, I haven't applied it yet. I'm planning to get a few fixes
> > sorted this week, at which point it would land in the mips-fixes branch
> > at the above repo.
>=20
> Cool, thanks.  I just wanted to be sure it hadn't got lost somehow.

Now pushed.

Thanks
James

--XOIedfhf+7KOe/yw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWvYRegAKCRA1zuSGKxAj
8k+cAPwINk3TzhEwI2ihwliaC2od+nT6EC7fExzUTqgV/oRjNwEAxDNL493COhi0
X1TZWyeMreE6ETF8yPlL5483oyRagQ0=
=p3I8
-----END PGP SIGNATURE-----

--XOIedfhf+7KOe/yw--
