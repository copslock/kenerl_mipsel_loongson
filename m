Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Sep 2017 12:47:46 +0200 (CEST)
Received: from heliosphere.sirena.org.uk ([IPv6:2a01:7e01::f03c:91ff:fed4:a3b6]:40656
        "EHLO heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991615AbdIAKrixWw0Q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Sep 2017 12:47:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=x6lS955ktFfM+ieI7cutVrBz+1TkuLhpeURSIp7LesA=; b=PlqgqWR74WaC
        YHuRZCOtnaj9c0HXgoJJHhPI0gRoqoZazP3BeRHgW5KhsB1stYPo7dVecRsR4BeCb/rCy3z23dzvJ
        6JAdyYsNAslNhadPQnXtpJ9BA0hDPDAPAjC0SDLkhmxVcrKa/hrEU69MmCwwiJ9FQmz07h761bXyO
        iy3YM=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1dnjTz-000555-5d; Fri, 01 Sep 2017 10:47:27 +0000
Received: from broonie by debutante with local (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1dnjTy-0006AD-Ox; Fri, 01 Sep 2017 11:47:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, ralf@linux-mips.org,
        linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        martin.blumenstingl@googlemail.com, john@phrozen.org,
        linux-spi@vger.kernel.org, hauke.mehrtens@intel.com,
        linux-spi@vger.kernel.org
Subject: Applied "spi: spi-falcon: drop check of boot select" to the spi tree
In-Reply-To:  <20170417192942.32219-4-hauke@hauke-m.de>
Message-Id: <E1dnjTy-0006AD-Ox@debutante>
Date:   Fri, 01 Sep 2017 11:47:26 +0100
Return-Path: <broonie@sirena.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59908
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

   spi: spi-falcon: drop check of boot select

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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
