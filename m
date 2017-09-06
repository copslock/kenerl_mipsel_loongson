Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Sep 2017 13:14:46 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:33812 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991438AbdIFLOiz2MEq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 6 Sep 2017 13:14:38 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v86BEa5W005597;
        Wed, 6 Sep 2017 13:14:36 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v86BEZmv005596;
        Wed, 6 Sep 2017 13:14:35 +0200
Date:   Wed, 6 Sep 2017 13:14:35 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Rocco Folino <rocco.folino@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Antony Pavlov <antonynpavlov@gmail.com>,
        Alban Bedel <albeu@free.fr>, John Crispin <john@phrozen.org>
Subject: Re: [PATCH] MIPS: ath79: support devicetree selection
Message-ID: <20170906111435.GA1856@linux-mips.org>
References: <b78cb3ef8df8531efdb7b011743ad3f38978015d.1503070362.git.rocco.folino@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b78cb3ef8df8531efdb7b011743ad3f38978015d.1503070362.git.rocco.folino@gmail.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59944
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Fri, Aug 18, 2017 at 05:32:42PM +0200, Rocco Folino wrote:

> Allow to choose devicetrees from Kconfig.
> 
> Signed-off-by: Rocco Folino <rocco.folino@gmail.com>
> ---
>  arch/mips/ath79/Kconfig         | 44 +++++++++++++++++++++++++++++++++++++++++
>  arch/mips/boot/dts/qca/Makefile | 10 +++++-----
>  2 files changed, 49 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/mips/ath79/Kconfig b/arch/mips/ath79/Kconfig
> index dfc60209dc63..b43d116187af 100644
> --- a/arch/mips/ath79/Kconfig
> +++ b/arch/mips/ath79/Kconfig
> @@ -1,5 +1,49 @@
>  if ATH79
>  
> +menu "Atheros AR71XX/AR724X/AR913X devicetree selection"
> +
> +config DTB_ATH_DPT_MODULE
> +	bool "DPTechnics DPT-Module"
> +	select SOC_933X

There is no symbol SOC_933X.  Did you mean SOC_AR933X?

Anyway, your patch does more than the changelog ("Allow to choose
devicetrees from Kconfig") says, so please either fix the changelog
or split that into multiple patches with proper changelogs.

  Ralf
