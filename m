Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jul 2018 16:33:14 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:54096 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993256AbeGFOdDhpYc8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Jul 2018 16:33:03 +0200
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D8DAE601CF; Fri,  6 Jul 2018 14:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530887576;
        bh=TyHiDGBpa8TNqP+Y63y6EIP6o8sV3sUIKbHpq75Pqv4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=SsqNj9ojni3HvFXkrVlxqPfxvSYK9Z0VbrpiwK0RqeE0Ti/lp4Ta8HPEVHmPBjW0X
         GpJRO2citvyVTdV0yL4WYkVH0Zixxboh6dz4ZFoMb0Z4hNCBlF23XHeQVrRjl1onD9
         6yWxAGAUIcM5c7Byz+mkK6qZZgAs2DeNbGdEaRvE=
Received: from purkki.adurom.net (purkki.adurom.net [80.68.90.206])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D696E60290;
        Fri,  6 Jul 2018 14:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530887575;
        bh=TyHiDGBpa8TNqP+Y63y6EIP6o8sV3sUIKbHpq75Pqv4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=OFUoK6dOYlUeSNHuFKF0ReHE61EqBVu6XvsSVU+jOjk0OadbGff6iz+giDo6HJUuZ
         IniaugqKtn7X1yH1symufdGWZG8wcn8d06ciEjQrzWiObA4HSYh+EipcF7n6koVis2
         /pTDCLWLFSqVIrxf6MHHLdo4wA/pGLCEFhBmMSXs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D696E60290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        =?utf-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 21/27] bcma: Allow selection of this driver when COMPILE_TEST=y
References: <20180705094522.12138-1-boris.brezillon@bootlin.com>
        <20180705094522.12138-22-boris.brezillon@bootlin.com>
Date:   Fri, 06 Jul 2018 17:32:50 +0300
In-Reply-To: <20180705094522.12138-22-boris.brezillon@bootlin.com> (Boris
        Brezillon's message of "Thu, 5 Jul 2018 11:45:16 +0200")
Message-ID: <87zhz4tox9.fsf@purkki.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <kvalo@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64700
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kvalo@codeaurora.org
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

Boris Brezillon <boris.brezillon@bootlin.com> writes:

> This allows us to increase compile-test coverage without having to build
> a kernel for MIPS.  That's particularly interesting for subsystem
> maintainers that want to test as many drivers as possible in a single
> build.
>
> We also add a dependency on HAS_IOMEM in BCMA_HOST_SOC to make sure the
> driver is not selected when the arch does not implement IO accessors.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
> ---
>  drivers/bcma/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Acked-by: Kalle Valo <kvalo@codeaurora.org>

I assume this patch will go via some other tree and I can drop it.

-- 
Kalle Valo
