Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jun 2018 17:00:09 +0200 (CEST)
Received: from heliosphere.sirena.org.uk ([IPv6:2a01:7e01::f03c:91ff:fed4:a3b6]:40684
        "EHLO heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993029AbeFZPABc46su (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jun 2018 17:00:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=1IrhDaB+SKZKqzsbZjzkfWPRayLxpXSofxJ8qgvyiJY=; b=lHRASFTcoJue
        v/fGHqVXrJzquGZg5XlSCTTfQ8Pi4lkhRv3ypQI3/K0/wopQ+sBm34X2Vowv7OQJ2jHrsB8Oz26KB
        li0YqO+xfoWhraVG0FsPAjP10pY+a9KJ4nUlTIAONHtliWFIC91VvwU6XYzolZCHNviaGxijsvi36
        l2TH8=;
Received: from host109-146-194-33.range109-146.btcentralplus.com ([109.146.194.33] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fXpRo-0001IU-Aq; Tue, 26 Jun 2018 15:00:00 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id C26D7440070; Tue, 26 Jun 2018 15:59:59 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     John Crispin <john@phrozen.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-spi@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Applied "spi: ath79: drop pdata support" to the spi tree
In-Reply-To:  <20180625171823.4782-1-john@phrozen.org>
Message-Id: <20180626145959.C26D7440070@finisterre.ee.mobilebroadband>
Date:   Tue, 26 Jun 2018 15:59:59 +0100 (BST)
Return-Path: <broonie@sirena.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64463
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

The patch

   spi: ath79: drop pdata support

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark
