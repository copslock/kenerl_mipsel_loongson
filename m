Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Oct 2015 06:51:08 +0200 (CEST)
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35294 "EHLO
        mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006513AbbJXEvGZsytW convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 24 Oct 2015 06:51:06 +0200
Received: by pasz6 with SMTP id z6so135255635pas.2;
        Fri, 23 Oct 2015 21:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rh86IMgq9bNwiHsaVm3gwtA6/7jc+opCm/qp3ppbnqY=;
        b=x9dyC5xQIijCHsrRBDnnMZuqvg/sxndOFwu9DHxN3gESX9e+0rsUoM3ZQ1+4OZSWOl
         6BdTFnKFByIGBjPzfRzDF4u1oiDhFHwF+Wx3juiY++tn5S9Yiu87pojMOldR0BagANPB
         IuclWnQSKD2tXpJ5y5BdqpLRpiC6Ck3GTaqFrPE6jBN76D/cZUIjepaArHzZZHvfmvNX
         2dapWfNqHk2kZ6CRLch5L7lCyJZNgnKN3RqEIuln1uF0+Xt1woJcT1k7upqqDfkfuAn7
         q6Ruc59t2Y6TFw9GZ14IHG7iR/dZyxto+zLX7t9W7IilrcC1sAnUYuj0IRvku0ShEfby
         xQnQ==
X-Received: by 10.68.65.13 with SMTP id t13mr28487072pbs.43.1445662260123;
        Fri, 23 Oct 2015 21:51:00 -0700 (PDT)
Received: from [192.168.0.105] ([59.12.167.210])
        by smtp.gmail.com with ESMTPSA id im9sm21814786pbc.1.2015.10.23.21.50.57
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 23 Oct 2015 21:50:59 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: [PATCH 03/10] ata: ahci_brcmstb: add support 40nm platforms
From:   Jaedon Shin <jaedon.shin@gmail.com>
In-Reply-To: <20151023212558.GS13239@google.com>
Date:   Sat, 24 Oct 2015 13:50:54 +0900
Cc:     Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        devicetree@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <DE776F55-6D75-4AD7-B3AA-52E45C9D99C0@gmail.com>
References: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com> <1445564663-66824-4-git-send-email-jaedon.shin@gmail.com> <20151023212558.GS13239@google.com>
To:     Brian Norris <computersforpeace@gmail.com>
X-Mailer: Apple Mail (2.3096.5)
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49675
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jaedon.shin@gmail.com
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

Hi Brian,

On Oct 24, 2015, at 6:25 AM, Brian Norris <computersforpeace@gmail.com> wrote:
> 
> Hi Jadeon,
> 
> Hmm, my suspicions about the PHY driver are probably meant to be applied
> here. I don't think this change is sufficient.
> 
> On Fri, Oct 23, 2015 at 10:44:16AM +0900, Jaedon Shin wrote:
>> Add offsets for 40nm BMIPS based set-top box platforms.
>> 
>> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
>> ---
>> drivers/ata/ahci_brcmstb.c | 11 +++++++++--
>> 1 file changed, 9 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/ata/ahci_brcmstb.c b/drivers/ata/ahci_brcmstb.c
>> index 8cf6f7d4798f..59eb526cf4f6 100644
>> --- a/drivers/ata/ahci_brcmstb.c
>> +++ b/drivers/ata/ahci_brcmstb.c
>> @@ -50,7 +50,8 @@
>>   #define SATA_TOP_CTRL_2_SW_RST_RX			BIT(2)
>>   #define SATA_TOP_CTRL_2_SW_RST_TX			BIT(3)
>>   #define SATA_TOP_CTRL_2_PHY_GLOBAL_RESET		BIT(14)
>> - #define SATA_TOP_CTRL_PHY_OFFS				0x8
>> + #define SATA_TOP_CTRL_28NM_PHY_OFFS			0x8
>> + #define SATA_TOP_CTRL_40NM_PHY_OFFS			0x4
> 
> I don't remember the exact 40nm vs. 28nm map that well, but judging by
> the code-is-the-documentation, the 28nm layout is like this:
> 
> base + 0x0C = port 0, phy control 1
> base + 0x10 = port 0, phy control 2
> base + 0x14 = port 1, phy control 1
> base + 0x18 = port 1, phy control 2
> 
> but the 40nm layout is differnt, where the ports are interleaved:
> 
> base + 0x0C = port 0, phy control 1
> base + 0x10 = port 1, phy control 1
> base + 0x14 = port 0, phy control 2
> base + 0x18 = port 1, phy control 2
> 
> So, your patch gets phy control 1 correct for both ports, but it doesn't
> get phy control 2 correct. (Or at least, even if my guess at the 40nm
> layout is wrong, your patch makes "port 0, phy control 2" collide with
> "port 1, phy control 1", which is most certainly a bug.)
> 
> Are you sure you're testing this properly? Did you try using both ports
> at the same time? And please, apply the same scrutiny to the PHY driver.
> (e.g., did you test SSC? did you test both ports?)
> 
> Brian
> 

You are right. This must be changed. 

I found the 28nm chipsets have four phy interface control registers. But, 
the the 40nm chipsets have only three registers. I did not testing with 
two ports at the same time. It seems we should check more.

Thanks.

Jaedon

>>  #define SATA_TOP_MAX_PHYS				2
>> #define SATA_TOP_CTRL_SATA_TP_OUT			0x1c
>> #define SATA_TOP_CTRL_CLIENT_INIT_CTRL			0x20
>> @@ -237,7 +238,13 @@ static int brcm_ahci_resume(struct device *dev)
>> 
>> static const struct of_device_id ahci_of_match[] = {
>> 	{.compatible = "brcm,bcm7445-ahci",
>> -			.data = (void *)SATA_TOP_CTRL_PHY_OFFS},
>> +			.data = (void *)SATA_TOP_CTRL_28NM_PHY_OFFS},
>> +	{.compatible = "brcm,bcm7346-ahci",
>> +			.data = (void *)SATA_TOP_CTRL_40NM_PHY_OFFS},
>> +	{.compatible = "brcm,bcm7360-ahci",
>> +			.data = (void *)SATA_TOP_CTRL_40NM_PHY_OFFS},
>> +	{.compatible = "brcm,bcm7362-ahci",
>> +			.data = (void *)SATA_TOP_CTRL_40NM_PHY_OFFS},
>> 	{},
>> };
>> MODULE_DEVICE_TABLE(of, ahci_of_match);
>> -- 
>> 2.6.2
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
