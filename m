Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Jan 2018 15:06:50 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:48916 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994626AbeAPOGoK7K4V convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Jan 2018 15:06:44 +0100
Date:   Tue, 16 Jan 2018 15:06:27 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v6 10/15] MIPS: ingenic: Detect machtype from SoC
 compatible string
To:     James Hogan <james.hogan@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Paul Burton <paul.burton@mips.com>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Message-Id: <1516111587.1648.0@smtp.crapouillou.net>
In-Reply-To: <20180110222712.GU27409@jhogan-linux.mipstec.com>
References: <20180102150848.11314-1-paul@crapouillou.net>
        <20180105182513.16248-1-paul@crapouillou.net>
        <20180105182513.16248-11-paul@crapouillou.net>
        <20180110222712.GU27409@jhogan-linux.mipstec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1516111597; bh=ShS4aCcKbezKhZQJpy+98RbwGTW3DGmN7lvgOsftRpo=; h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding; b=tmNZ5it44UVSNZV/5vYaQ+8UDWJrberO3F7BMSGzYB10mthBxiYRLsPBV8V10H7qgSxlEfkBmQjEqNsI2CHGDOogBCotqxq1WXpLi2STdMmgtw8U/p6jbQL5T3YqH2W92F5Foa9dRYjzwLTzs+BIRuPMXHrQg4oBxioRf3brLHQ=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62171
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul@crapouillou.net
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

Hi James,

Le mer. 10 janv. 2018 à 23:27, James Hogan <james.hogan@mips.com> a 
écrit :
> On Fri, Jan 05, 2018 at 07:25:08PM +0100, Paul Cercueil wrote:
>>  Previously, the mips_machtype variable was always initialized
>>  to MACH_INGENIC_JZ4740 even if running on different SoCs.
>> 
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>   arch/mips/jz4740/prom.c  |  1 -
>>   arch/mips/jz4740/setup.c | 26 ++++++++++++++++++++++----
>>   2 files changed, 22 insertions(+), 5 deletions(-)
>> 
>>   v2: No change
>>   v3: No change
>>   v4: No change
>>   v5: Use SPDX license identifier
>>   v6: Init mips_machtype from DT compatible string instead of using
>>       MIPS_MACHINE
>> 
>>  diff --git a/arch/mips/jz4740/prom.c b/arch/mips/jz4740/prom.c
>>  index a62dd8e6ecf9..eb9f2f97bedb 100644
>>  --- a/arch/mips/jz4740/prom.c
>>  +++ b/arch/mips/jz4740/prom.c
>>  @@ -25,7 +25,6 @@
>> 
>>   void __init prom_init(void)
>>   {
>>  -	mips_machtype = MACH_INGENIC_JZ4740;
>>   	fw_init_cmdline();
>>   }
>> 
>>  diff --git a/arch/mips/jz4740/setup.c b/arch/mips/jz4740/setup.c
>>  index 6d0152321819..cd89536fbba1 100644
>>  --- a/arch/mips/jz4740/setup.c
>>  +++ b/arch/mips/jz4740/setup.c
>>  @@ -53,16 +53,30 @@ static void __init jz4740_detect_mem(void)
>>   	add_memory_region(0, size, BOOT_MEM_RAM);
>>   }
>> 
>>  +static unsigned long __init get_board_mach_type(const void *fdt)
>>  +{
>>  +	if (!fdt_node_check_compatible(fdt, 0, "ingenic,jz4780"))
>>  +		return MACH_INGENIC_JZ4780;
>>  +	if (!fdt_node_check_compatible(fdt, 0, "ingenic,jz4770"))
>>  +		return MACH_INGENIC_JZ4770;
>>  +
>>  +	return MACH_INGENIC_JZ4740;
>>  +}
>>  +
>>   void __init plat_mem_setup(void)
>>   {
>>   	int offset;
>> 
>>  +	if (!early_init_dt_scan(__dtb_start))
>>  +		return;
>>  +
>>   	jz4740_reset_init();
>>  -	__dt_setup_arch(__dtb_start);
> 
> Is it intentional that by removing this we no longer set the machine
> name, so it'll default to "unknown"? The commit message doesn't 
> mention
> that change.
> 
> Cheers
> James

You're right, thank you for spotting that. I'll send a revised version 
ASAP.

-Paul
