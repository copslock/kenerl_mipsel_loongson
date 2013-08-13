Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Aug 2013 20:58:11 +0200 (CEST)
Received: from cassiel.sirena.org.uk ([80.68.93.111]:59370 "EHLO
        cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6824782Ab3HMS6HcNe9n (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Aug 2013 20:58:07 +0200
Received: from cpc11-sgyl31-2-0-cust68.sgyl.cable.virginmedia.com ([94.175.92.69] helo=finisterre)
        by cassiel.sirena.org.uk with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <broonie@sirena.org.uk>)
        id 1V9Jn8-0003G2-UO; Tue, 13 Aug 2013 19:58:04 +0100
Received: from broonie by finisterre with local (Exim 4.80)
        (envelope-from <broonie@sirena.org.uk>)
        id 1V9Jn8-0007Iz-GS; Tue, 13 Aug 2013 19:58:02 +0100
Date:   Tue, 13 Aug 2013 19:58:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     John Crispin <blogic@openwrt.org>
Cc:     Gabor Juhos <juhosg@openwrt.org>, linux-spi@vger.kernel.org,
        linux-mips@linux-mips.org
Message-ID: <20130813185802.GE6427@sirena.org.uk>
References: <1376074288-29302-1-git-send-email-blogic@openwrt.org>
 <1376074288-29302-2-git-send-email-blogic@openwrt.org>
 <20130811132642.GB6427@sirena.org.uk>
 <520A7E67.1060604@openwrt.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="T7HNq/m++EF3pl6p"
Content-Disposition: inline
In-Reply-To: <520A7E67.1060604@openwrt.org>
X-Cookie: Many pages make a thick book.
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SA-Exim-Connect-IP: 94.175.92.69
X-SA-Exim-Mail-From: broonie@sirena.org.uk
Subject: Re: [PATCH 2/2] SPI: ralink: add Ralink SoC spi driver
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:57:07 +0000)
X-SA-Exim-Scanned: Yes (on cassiel.sirena.org.uk)
Return-Path: <broonie@sirena.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37539
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: broonie@kernel.org
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


--T7HNq/m++EF3pl6p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 13, 2013 at 08:43:51PM +0200, John Crispin wrote:

> >There is presumably a maximum transfer size here from the FIFO that is
> >holding the data?

> The hardware is not running in DMA/IRQ mode and hence it can only
> read/write 1 byte at a time.

OK, then the code looks buggy since it does all the Tx then all the Rx
so a bidirectional transfer should fail.  I'd expect Tx and Rx to be
part of the same loop in this case.

> >Set min_speed_hz in the spi_master and the core will check this for you.

> it seems that min_speed is not handled by the core yet. I saw
> several drivers do minimum speed testing. I am leaving this code in
> the driver until there is a generic minimum speed check

Or add the check to the core...

> >clk_prepare_enable(), and it'd be nice to use runtime PM and enable the
> >clock only when doing transfers though that's not essential.

> The clock is free running and always running.

It's still nice to turn it off for power, and very cheap to implement.

--T7HNq/m++EF3pl6p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSCoG3AAoJELSic+t+oim9iGYQAIFDRiN+niH9bBxFp9plHDoC
xykr2WZpy1t/hmvmZX8yHJMum1VepnrhhkBobV0bpHGlbxt3d13QTKKH5oqt4IDr
WzDgyk5IUNfTwFfsqK1GdpmHkXSQ8luz+Q1XHMzVGXpbcefHvjUESps+PWSjJ36d
y/zfNhsFoI1S2VL6CxoXL/pcozEBDlvC/7vlMNOQ6duUH+BHHaIfEuUGjeqOoR/k
9JUkmFHiMVNq4dVtsE9P/hkcNCjV5AOhriNqx+9k6Nl10NrR8MUw4Yxf61LEck37
5lZNLmuVV058XGVra01bULrgg5OpL15pjZkugeupb8EdpmG3h+UJ7vGPJhFgInEG
bOteSHABXjDuIePxigbotOKAeBg8z/RRzDPq1EvYz+GBRBGDFlxUzYaR7+urqtHE
QMEYJowOecE4qpbjfSBWMd+/5KjeZaahRjKPYcK6Q1byqGTVp5kwcn7ggVaYVI7O
Hw0ccAbpdL3MAU+gW6Ups8aweSFLPtJW17eeFwRLsR+6Qv7q7xsSQSGKGnt7L29g
oeg2lbUHmYKb/VD6+NzLnTdKoxJb7dZLVb60807B0Lh6q780Jpubl/feRmhVaos5
dFiRh5aQLUKAQmCwtqeJdc1rsP2nCTYhJ3SbRnV0Ij3+DRqWhyfY21wTdHCRPhlS
Uf/bENfY3d5uYALkLnVa
=PWRC
-----END PGP SIGNATURE-----

--T7HNq/m++EF3pl6p--
