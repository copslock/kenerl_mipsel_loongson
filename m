Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Jun 2012 19:06:08 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:43473 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903779Ab2F1RGC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Jun 2012 19:06:02 +0200
Received: by pbbrq13 with SMTP id rq13so3613715pbb.36
        for <linux-mips@linux-mips.org>; Thu, 28 Jun 2012 10:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=7tb9SrXXk7tubgI0bALvNmzpTdtTQrLavIz0rieCQCA=;
        b=YwYX7WnfnVQv/iPtgjzZ/lE9SjjPYfzPfqM0TlY/PbYC1iNowATSZMQaNf7XlOjvui
         vtnvu/fYI0tr40VZ325bgnmFHcyrefMPbj0jKX5He//JAU/tyhjcs5j3zk0qynZ1g8tm
         2IMRRE3ntwUdK8JIrRO4xGYXBtYWKWKmySPeYQG8Af2ipljq35Z98EV3slfrYDY99anL
         gLfxr5KtcFPJUdXFvSpMaU9cTYiafnsBao+ukUuhXEbmCTKaiRy+svYUQYWgDo/vmNWt
         L81rzcxEV2liZpKc5ELD/b1PJbqr+C2EwQe4aK8l5uO2C2EZDf/0FbfmUMvz7H92aYTu
         SXlw==
Received: by 10.68.195.102 with SMTP id id6mr8923270pbc.120.1340903155709;
        Thu, 28 Jun 2012 10:05:55 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id na10sm2636163pbc.23.2012.06.28.10.05.54
        (version=SSLv3 cipher=OTHER);
        Thu, 28 Jun 2012 10:05:54 -0700 (PDT)
Message-ID: <4FEC8EF0.6080408@gmail.com>
Date:   Thu, 28 Jun 2012 10:05:52 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     David Miller <davem@davemloft.net>
CC:     grant.likely@secretlab.ca, rob.herring@calxeda.com,
        devicetree-discuss@lists.ozlabs.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        afleming@gmail.com, david.daney@cavium.com
Subject: Re: [PATCH v2 0/4] netdev/phy: 10G PHY support.
References: <1340818418-10382-1-git-send-email-ddaney.cavm@gmail.com> <20120627.212941.485325944406335522.davem@davemloft.net>
In-Reply-To: <20120627.212941.485325944406335522.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-7; format=flowed
Content-Transfer-Encoding: 8bit
X-archive-position: 33865
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 06/27/2012 09:29 PM, David Miller wrote:
> From: David Daney<ddaney.cavm@gmail.com>
> Date: Wed, 27 Jun 2012 10:33:34 -0700
>
>> From: David Daney<david.daney@cavium.com>
>>
>> The only non-cosmetic change from v1 is to pass an additional argument
>> to get_phy_device() that indicates that the PHY uses 802.3 clause 45
>> signaling, previously I had been using a high order bit of the addr
>> parameter for this.
>>
>> There are also changes from v1 in the code and comment formatting.
>> These should now be closer to what David Miller prefers.
>
> Applied, but I had to add the following warning fixup:

Thank You.

>
> --------------------
> phy: Fix warning in get_phy_device().
>
> drivers/net/phy/phy_device.c: In function ¡get_phy_device¢:
> drivers/net/phy/phy_device.c:340:14: warning: ¡phy_id¢ may be used uninitialized in this function [-Wmaybe-uninitialized]
>
> GCC can't see that when we return zero we always initialize
> phy_id and that's the only path where we use it.
>
> Initialize phy_id to zero to shut it up.
>

FWIW: I was testing with GCC-4.6.3 and saw no such warnings.

David Daney


> Signed-off-by: David S. Miller<davem@davemloft.net>
> ---
>   drivers/net/phy/phy_device.c |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index ef4cdee..47e02e7 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -327,9 +327,9 @@ static int get_phy_id(struct mii_bus *bus, int addr, u32 *phy_id,
>    */
>   struct phy_device *get_phy_device(struct mii_bus *bus, int addr, bool is_c45)
>   {
> -	struct phy_device *dev = NULL;
> -	u32 phy_id;
>   	struct phy_c45_device_ids c45_ids = {0};
> +	struct phy_device *dev = NULL;
> +	u32 phy_id = 0;
>   	int r;
>
>   	r = get_phy_id(bus, addr,&phy_id, is_c45,&c45_ids);
