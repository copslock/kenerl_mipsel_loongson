Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Sep 2012 09:26:58 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:52090 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903373Ab2IXH0w (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 24 Sep 2012 09:26:52 +0200
X-Virus-Scanned: at arrakis.dune.hu
Received: from [192.168.254.50] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 7B52223C00B5;
        Mon, 24 Sep 2012 09:26:46 +0200 (CEST)
Message-ID: <50600B35.3050101@openwrt.org>
Date:   Mon, 24 Sep 2012 09:26:45 +0200
From:   Gabor Juhos <juhosg@openwrt.org>
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org, stable@vger.kernel.org
Subject: Re: [PATCH] MIPS: ath79: fix CPU/DDR frequency calculation for SRIF
 PLLs
References: <1347105741-23091-1-git-send-email-juhosg@openwrt.org> <20120923174851.GG13842@linux-mips.org>
In-Reply-To: <20120923174851.GG13842@linux-mips.org>
X-Enigmail-Version: 1.4.4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-archive-position: 34543
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

2012.09.23. 19:48 keltezéssel, Ralf Baechle írta:
> On Sat, Sep 08, 2012 at 02:02:21PM +0200, Gabor Juhos wrote:
> 
> Applied but I had to fix a conflict:
> 
> @@ -65,6 +65,8 @@
>  #define AR934X_WMAC_SIZE	0x20000
>  #define AR934X_EHCI_BASE	0x1b000000
>  #define AR934X_EHCI_SIZE	0x200
> +#define AR934X_SRIF_BASE	(AR71XX_APB_BASE + 0x00116000)
> +#define AR934X_SRIF_SIZE	0x1000
>  
>  /*
>   * DDR_CTRL block
> 
> The EHCI lines don't exist yet.  Seems harmless though.

Hm, I'm sure that the line was present a few days ago. It has been added by the
following commit:

commit 00ffed582fe8a3f7556593c0e8baaf3da3df85b0
Author: Gabor Juhos <juhosg@openwrt.org>
Date:   Sat Aug 4 15:03:56 2012 +0000

    MIPS: ath79: add USB platform setup code for AR934X

    Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
    Patchwork: http://patchwork.linux-mips.org/patch/4172/
    Signed-off-by: John Crispin <blogic@openwrt.org>

However I don't see that commit in the 'mips-for-linux-next' branch of the
'upstream-sfr.git' tree anymore.

Also these changes are missing:
 MIPS: ath79: register USB host controller on the DB120 board
 MIPS: ath79: use a helper function for USB resource initialization

-Gabor
