Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Dec 2015 04:30:06 +0100 (CET)
Received: from mail-pf0-f170.google.com ([209.85.192.170]:35886 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006513AbbLHDaDw2-Ke (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Dec 2015 04:30:03 +0100
Received: by pfdd184 with SMTP id d184so4568081pfd.3;
        Mon, 07 Dec 2015 19:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=G8Kz9KMmQsA3fjhjnVIzxHnPhQeybE5JJvshGcr/IKQ=;
        b=hVu1y5Crxt2mAXsUKNV84e85CRsWtYKtGoGlN5M7z8YfVKzyPrBXs9eSygtPDkSKBG
         9bnO+sJ8uqpBt1UwrkxfX7iSiBm3kLQXdPnZMWGdi9rVxDKiLjTuRqNWQ4tbaRcHqQST
         MQlI1P+ZhA2pS4vhcBYWqAEAX5A/LGXn6KWgIUSvrsw1kGvjS9G3gyTwn4gM4D5tH8BP
         94AXS7vC6S/UUV/UyRSMgwClX3YhKQc5LEh+H92Xxi695zGhiHGeOohtQ0/foYnB009v
         e/4KNdDT9sU7e0mSntGAzBTIyAASThAUDdFQYq+RZ4KAcrAbHjDpap+vuPiczlVl0xe6
         bySg==
X-Received: by 10.98.0.137 with SMTP id 131mr1738032pfa.137.1449545397717;
        Mon, 07 Dec 2015 19:29:57 -0800 (PST)
Received: from google.com ([2620:0:1000:1301:5ca9:672c:7da0:50e1])
        by smtp.gmail.com with ESMTPSA id 87sm928946pfj.23.2015.12.07.19.29.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 07 Dec 2015 19:29:57 -0800 (PST)
Date:   Mon, 7 Dec 2015 19:29:55 -0800
From:   Brian Norris <computersforpeace@gmail.com>
To:     Boris Brezillon <boris.brezillon@free-electrons.com>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mtd@lists.infradead.org, linux-mips@linux-mips.org
Subject: Re: [PATCH v2 04/25] mips: nand: make use of mtd_to_nand() where
 appropriate
Message-ID: <20151208032955.GS120110@google.com>
References: <1448967802-25796-1-git-send-email-boris.brezillon@free-electrons.com>
 <1448967802-25796-5-git-send-email-boris.brezillon@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1448967802-25796-5-git-send-email-boris.brezillon@free-electrons.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <computersforpeace@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50410
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: computersforpeace@gmail.com
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

(Trim CC list)

Hi Ralf,

On Tue, Dec 01, 2015 at 12:03:01PM +0100, Boris Brezillon wrote:
> mtd_to_nand() was recently introduced to avoid direct accesses to the
> mtd->priv field. Update all MIPS specific implementations to use this
> helper.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  arch/mips/alchemy/devboards/db1200.c | 2 +-
>  arch/mips/alchemy/devboards/db1300.c | 2 +-
>  arch/mips/alchemy/devboards/db1550.c | 2 +-
>  arch/mips/pnx833x/common/platform.c  | 2 +-
>  arch/mips/rb532/devices.c            | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/mips/alchemy/devboards/db1200.c b/arch/mips/alchemy/devboards/db1200.c
> index 8c13675..992442a 100644
> --- a/arch/mips/alchemy/devboards/db1200.c
> +++ b/arch/mips/alchemy/devboards/db1200.c
> @@ -200,7 +200,7 @@ static struct i2c_board_info db1200_i2c_devs[] __initdata = {
>  static void au1200_nand_cmd_ctrl(struct mtd_info *mtd, int cmd,
>  				 unsigned int ctrl)
>  {
> -	struct nand_chip *this = mtd->priv;
> +	struct nand_chip *this = mtd_to_nand(mtd);
>  	unsigned long ioaddr = (unsigned long)this->IO_ADDR_W;
>  
>  	ioaddr &= 0xffffff00;
> diff --git a/arch/mips/alchemy/devboards/db1300.c b/arch/mips/alchemy/devboards/db1300.c
> index b580770..d3c087f 100644
> --- a/arch/mips/alchemy/devboards/db1300.c
> +++ b/arch/mips/alchemy/devboards/db1300.c
> @@ -150,7 +150,7 @@ static void __init db1300_gpio_config(void)
>  static void au1300_nand_cmd_ctrl(struct mtd_info *mtd, int cmd,
>  				 unsigned int ctrl)
>  {
> -	struct nand_chip *this = mtd->priv;
> +	struct nand_chip *this = mtd_to_nand(mtd);
>  	unsigned long ioaddr = (unsigned long)this->IO_ADDR_W;
>  
>  	ioaddr &= 0xffffff00;
> diff --git a/arch/mips/alchemy/devboards/db1550.c b/arch/mips/alchemy/devboards/db1550.c
> index 5740bcf..b518f02 100644
> --- a/arch/mips/alchemy/devboards/db1550.c
> +++ b/arch/mips/alchemy/devboards/db1550.c
> @@ -128,7 +128,7 @@ static struct i2c_board_info db1550_i2c_devs[] __initdata = {
>  static void au1550_nand_cmd_ctrl(struct mtd_info *mtd, int cmd,
>  				 unsigned int ctrl)
>  {
> -	struct nand_chip *this = mtd->priv;
> +	struct nand_chip *this = mtd_to_nand(mtd);
>  	unsigned long ioaddr = (unsigned long)this->IO_ADDR_W;
>  
>  	ioaddr &= 0xffffff00;
> diff --git a/arch/mips/pnx833x/common/platform.c b/arch/mips/pnx833x/common/platform.c
> index b4b774b..3cd3577 100644
> --- a/arch/mips/pnx833x/common/platform.c
> +++ b/arch/mips/pnx833x/common/platform.c
> @@ -180,7 +180,7 @@ static struct platform_device pnx833x_sata_device = {
>  static void
>  pnx833x_flash_nand_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
>  {
> -	struct nand_chip *this = mtd->priv;
> +	struct nand_chip *this = mtd_to_nand(mtd);
>  	unsigned long nandaddr = (unsigned long)this->IO_ADDR_W;
>  
>  	if (cmd == NAND_CMD_NONE)
> diff --git a/arch/mips/rb532/devices.c b/arch/mips/rb532/devices.c
> index 9bd7a2d..0966adc 100644
> --- a/arch/mips/rb532/devices.c
> +++ b/arch/mips/rb532/devices.c
> @@ -148,7 +148,7 @@ static int rb532_dev_ready(struct mtd_info *mtd)
>  
>  static void rb532_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
>  {
> -	struct nand_chip *chip = mtd->priv;
> +	struct nand_chip *chip = mtd_to_nand(mtd);
>  	unsigned char orbits, nandbits;
>  
>  	if (ctrl & NAND_CTRL_CHANGE) {

Acked-by: Brian Norris <computersforpeace@gmail.com>

Do you want me to queue a pull request with this patch + 1 dependent
change for you? I'm perfectly fine just taking this directly too.

Regards,
Brian
