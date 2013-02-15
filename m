Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Feb 2013 17:04:00 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:60549 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827499Ab3BOQD71dq0H (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 Feb 2013 17:03:59 +0100
Message-ID: <511E5BB8.8060800@openwrt.org>
Date:   Fri, 15 Feb 2013 17:00:56 +0100
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.7) Gecko/20120922 Icedove/10.0.7
MIME-Version: 1.0
To:     Gabor Juhos <juhosg@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>,
        "Rodriguez, Luis" <rodrigue@qca.qualcomm.com>,
        "Giori, Kathy" <kgiori@qca.qualcomm.com>,
        QCA Linux Team <qca-linux-team@qca.qualcomm.com>
Subject: Re: [PATCH 02/11] MIPS: ath79: add SoC detection code for the QCA955X
 SoCs
References: <1360939105-23591-1-git-send-email-juhosg@openwrt.org> <1360939105-23591-3-git-send-email-juhosg@openwrt.org>
In-Reply-To: <1360939105-23591-3-git-send-email-juhosg@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 35765
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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


>
> -	sprintf(ath79_sys_type, "Atheros AR%s rev %u", chip, rev);
> +	if (soc_is_qca955x())
> +		sprintf(ath79_sys_type, "Qualcomm Atheros QCA%s rev %u",
> +			chip, rev);
> +	else
> +		sprintf(ath79_sys_type, "Atheros AR%s rev %u", chip, rev);
>   	pr_info("SoC: %s\n", ath79_sys_type);
>   }
>   
Hi,

maybe a soc_is_qca() could be used here, otherwise you will need to 
patch this line again for the next SoC and so on ....

     John
