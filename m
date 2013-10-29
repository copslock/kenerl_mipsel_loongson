Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Oct 2013 00:54:55 +0100 (CET)
Received: from perceval.ideasonboard.com ([95.142.166.194]:59905 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823051Ab3J2Xyv03DtW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Oct 2013 00:54:51 +0100
Received: from avalon.localnet (199.21-200-80.adsl-dyn.isp.belgacom.be [80.200.21.199])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 79D0D35A6D;
        Wed, 30 Oct 2013 00:54:08 +0100 (CET)
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Sebastian Reichel <sre@ring0.de>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-arm-kernel@lists.infradead.org, mturquette@linaro.org,
        linux@arm.linux.org.uk, jiada_wang@mentor.com,
        kyungmin.park@samsung.com, linux-kernel@vger.kernel.org,
        uclinux-dist-devel@blackfin.uclinux.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org
Subject: Re: [PATCH v7 1/5] omap3isp: Modify clocks registration to avoid circular references
Date:   Wed, 30 Oct 2013 00:55:06 +0100
Message-ID: <15201376.PVPE5NrGdO@avalon>
User-Agent: KMail/4.10.5 (Linux/3.10.7-gentoo-r1; KDE/4.10.5; x86_64; ; )
In-Reply-To: <20131029232837.GB2266@earth.universe>
References: <1383076268-8984-1-git-send-email-s.nawrocki@samsung.com> <16467881.81yEf9zq68@avalon> <20131029232837.GB2266@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart24267327.NWieDcb5ZA"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-Path: <laurent.pinchart@ideasonboard.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38410
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: laurent.pinchart@ideasonboard.com
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


--nextPart24267327.NWieDcb5ZA
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Sebastian,

On Wednesday 30 October 2013 00:28:39 Sebastian Reichel wrote:
> On Tue, Oct 29, 2013 at 11:28:37PM +0100, Laurent Pinchart wrote:
> > On Tuesday 29 October 2013 20:51:04 Sylwester Nawrocki wrote:
> > > The clock core code is going to be modified so clk_get() takes
> > > reference on the clock provider module. Until the potential circular
> > > reference issue is properly addressed, we pass NULL as as the first
> > > argument to clk_register(), in order to disallow sub-devices taking
> > > a reference on the ISP module back trough clk_get(). This should
> > > prevent locking the modules in memory.
> > > 
> > > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> > > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > 
> > Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > 
> > Do you plan to push this to mainline as part of this patch series ? I
> > don't have pending patches for the omap3isp that would conflict with this
> > patch, so that would be fine with me.
> 
> I plan to add support for DT to omap3isp + ADP1653 shortly. I have
> not yet started to work on this, but expect to send some first RFC
> patches in November.

That's very nice to hear ! And thanks for the heads up, I would have started 
working on it shortly.

-- 
Regards,

Laurent Pinchart

--nextPart24267327.NWieDcb5ZA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJScErfAAoJEIkPb2GL7hl1IekH/0CY1YWUNcUAQpUr0aeJoBOl
1zcvSIjk2nF0jgf+ayjndSr16epbblODJh5aFcYz+VCweP/aA+xArg5p6tmDO4f9
Ijk76QN6GjdsiEMvRYnARqysDJEFPvepurpQDrN3YNFmH56tsFytCzBGSzA4qIQy
4+ouLUFz6q8lOkSZ39F51NYOOw8XyX66y2XfV99psUEnUlaOyizyxocDmmRxUg2s
9gq6I7TFNTgipo9zbGKxCCwGbxacUPnc2cEg7SuGQuHitwkPSL9yTbNoScKDwoeb
tTUtPKN9JZzeGmbtvHPPt8GILQsejskvW3Iaj5lp8Tvr8hoOqd8AaesTfha6P6U=
=dhkA
-----END PGP SIGNATURE-----

--nextPart24267327.NWieDcb5ZA--
