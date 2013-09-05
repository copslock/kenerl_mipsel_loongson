Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Sep 2013 20:56:41 +0200 (CEST)
Received: from mail-bn1lp0154.outbound.protection.outlook.com ([207.46.163.154]:58616
        "EHLO na01-bn1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6837145Ab3IES4iJCF3q (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 5 Sep 2013 20:56:38 +0200
Received: from BN1PRD0712HT003.namprd07.prod.outlook.com (10.255.196.36) by
 BN1PR07MB022.namprd07.prod.outlook.com (10.255.225.40) with Microsoft SMTP
 Server (TLS) id 15.0.745.25; Thu, 5 Sep 2013 18:56:29 +0000
Received: from dl.caveonetworks.com (64.2.3.195) by pod51018.outlook.com
 (10.255.196.36) with Microsoft SMTP Server (TLS) id 14.16.353.4; Thu, 5 Sep
 2013 18:55:53 +0000
Message-ID: <5228D3B7.505@caviumnetworks.com>
Date:   Thu, 5 Sep 2013 11:55:51 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>, <linux-mips@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, <richard@nod.at>
Subject: Re: [PATCH 1/3] staging: octeon-ethernet: make dropped packets to
 consume NAPI budget
References: <1378406641-16530-1-git-send-email-aaro.koskinen@iki.fi> <1378406641-16530-2-git-send-email-aaro.koskinen@iki.fi>
In-Reply-To: <1378406641-16530-2-git-send-email-aaro.koskinen@iki.fi>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.195]
X-Forefront-PRVS: 096029FF66
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(199002)(189002)(24454002)(51704005)(377454003)(479174003)(77982001)(54316002)(74876001)(4396001)(59766001)(74366001)(56776001)(76482001)(33656001)(76786001)(76796001)(81542001)(80976001)(81686001)(47736001)(47976001)(64126003)(49866001)(50986001)(74662001)(50466002)(53806001)(74502001)(47446002)(77096001)(56816003)(54356001)(83072001)(53416003)(31966008)(83506001)(79102001)(19580405001)(83322001)(74706001)(19580395003)(46102001)(36756003)(69226001)(66066001)(65956001)(80022001)(23756003)(65806001)(51856001)(63696002)(47776003)(81342001)(81816001);DIR:OUT;SFP:;SCL:1;SRVR:BN1PR07MB022;H:BN1PRD0712HT003.namprd07.prod.outlook.com;CLIP:64.2.3.195;RD:InfoNoRecords;A:1;MX:1;LANG:en;
X-OriginatorOrg: DuplicateDomain-a3ec847f-e37f-4d9a-9900-9d9d96f75f58.caviumnetworks.com
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37769
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
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

On 09/05/2013 11:43 AM, Aaro Koskinen wrote:
> We should count also dropped packets, otherwise the NAPI handler may
> end up running too long.

Is this actually a problem?

If so ... the patch looks sane and you and add Acked-by me.

>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---
>   drivers/staging/octeon/ethernet-rx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/octeon/ethernet-rx.c b/drivers/staging/octeon/ethernet-rx.c
> index 34afc16..10e5416 100644
> --- a/drivers/staging/octeon/ethernet-rx.c
> +++ b/drivers/staging/octeon/ethernet-rx.c
> @@ -303,6 +303,7 @@ static int cvm_oct_napi_poll(struct napi_struct *napi, int budget)
>   			if (backlog > budget * cores_in_use && napi != NULL)
>   				cvm_oct_enable_one_cpu();
>   		}
> +		rx_count++;
>
>   		skb_in_hw = USE_SKBUFFS_IN_HW && work->word2.s.bufs == 1;
>   		if (likely(skb_in_hw)) {
> @@ -429,7 +430,6 @@ static int cvm_oct_napi_poll(struct napi_struct *napi, int budget)
>   #endif
>   				}
>   				netif_receive_skb(skb);
> -				rx_count++;
>   			} else {
>   				/* Drop any packet received for a device that isn't up */
>   				/*
>
