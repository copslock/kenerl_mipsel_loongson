Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Jan 2014 21:39:05 +0100 (CET)
Received: from mail.windriver.com ([147.11.1.11]:41923 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823124AbaAVUjCPMzk7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Jan 2014 21:39:02 +0100
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com [147.11.189.41])
        by mail.windriver.com (8.14.5/8.14.5) with ESMTP id s0MKcs9m022614
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
        Wed, 22 Jan 2014 12:38:54 -0800 (PST)
Received: from [128.224.146.65] (128.224.146.65) by ALA-HCB.corp.ad.wrs.com
 (147.11.189.41) with Microsoft SMTP Server id 14.2.347.0; Wed, 22 Jan 2014
 12:38:53 -0800
Message-ID: <52E02C72.5020809@windriver.com>
Date:   Wed, 22 Jan 2014 15:39:14 -0500
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     <fengguang.wu@intel.com>
CC:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH] mips: don't use module_init in non-modular sead3-mtd.c
 code
References: <52df8cbe.rloiJvwsOgUSEvhX%fengguang.wu@intel.com> <1390422090-24045-1-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1390422090-24045-1-git-send-email-paul.gortmaker@windriver.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [128.224.146.65]
Return-Path: <Paul.Gortmaker@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39073
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.gortmaker@windriver.com
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

On 14-01-22 03:21 PM, Paul Gortmaker wrote:
> The devicetree.o is built for obj-y -- and hence this code is always

I've updated the above to correct:

   s/devicetree/sead3-mtd/

Paul.
--

> present.  It will never be modular, so using module_init as an alias
> for __initcall can be somewhat misleading.
> 
> Fix this up now, so that we can relocate module_init from
> init.h into module.h in the future.  If we don't do this, we'd
> have to add module.h to obviously non-modular code, and that
> would be a worse thing.
> 
> Note that direct use of __initcall is discouraged, vs. one
> of the priority categorized subgroups.  As __initcall gets
> mapped onto device_initcall, our use of device_initcall
> directly in this change means that the runtime impact is
> zero -- it will remain at level 6 in initcall ordering.
> 
> We also fix a missing semicolon, which this change uncovers.
> 
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
> 
> [patch will be added to init cleanup series:
>    http://git.kernel.org/cgit/linux/kernel/git/paulg/init.git/  ]
> 
>  arch/mips/mti-sead3/sead3-mtd.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/mips/mti-sead3/sead3-mtd.c b/arch/mips/mti-sead3/sead3-mtd.c
> index ffa35f509789..f9c890d72677 100644
> --- a/arch/mips/mti-sead3/sead3-mtd.c
> +++ b/arch/mips/mti-sead3/sead3-mtd.c
> @@ -50,5 +50,4 @@ static int __init sead3_mtd_init(void)
>  
>  	return 0;
>  }
> -
> -module_init(sead3_mtd_init)
> +device_initcall(sead3_mtd_init);
> 
