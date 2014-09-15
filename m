Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Sep 2014 18:32:43 +0200 (CEST)
Received: from mail-bn1bon0090.outbound.protection.outlook.com ([157.56.111.90]:36578
        "EHLO na01-bn1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27008964AbaIOQckrr5b7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 15 Sep 2014 18:32:40 +0200
Received: from dl.caveonetworks.com (64.2.3.195) by
 BY2PR07MB583.namprd07.prod.outlook.com (10.141.221.155) with Microsoft SMTP
 Server (TLS) id 15.0.1024.12; Mon, 15 Sep 2014 16:32:32 +0000
Message-ID: <5417149D.2070301@caviumnetworks.com>
Date:   Mon, 15 Sep 2014 09:32:29 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH] netdev: octeon_mgmt: Fix ISO C90 forbids mixed declarations
 and code warning.
References: <1410798223-21420-1-git-send-email-ddaney.cavm@gmail.com>
In-Reply-To: <1410798223-21420-1-git-send-email-ddaney.cavm@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.195]
X-ClientProxiedBy: BY2PR07CA049.namprd07.prod.outlook.com (10.141.251.24) To
 BY2PR07MB583.namprd07.prod.outlook.com (10.141.221.155)
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:;UriScan:;
X-Forefront-PRVS: 03355EE97E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(189002)(199003)(377454003)(51704005)(479174003)(24454002)(4396001)(23756003)(21056001)(83506001)(110136001)(95666004)(64126003)(46102001)(50466002)(42186005)(87976001)(105586002)(81156004)(106356001)(85306004)(69596002)(77096002)(53416004)(107046002)(74662001)(31966008)(76482001)(74502001)(33656002)(85852003)(83072002)(79102001)(66066001)(36756003)(65816999)(92566001)(92726001)(97736003)(19580395003)(101416001)(76176999)(87266999)(64706001)(65956001)(102836001)(65806001)(80316001)(77982001)(80022001)(19580405001)(83322001)(20776003)(47776003)(54356999)(81542001)(81342001)(50986999)(99396002)(90102001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR07MB583;H:dl.caveonetworks.com;FPR:;MLV:sfv;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-OriginatorOrg: caviumnetworks.com
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42570
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

On 09/15/2014 09:23 AM, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
>
> We were getting:
>
>    drivers/net/ethernet/octeon/octeon_mgmt.c:295:4: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
>
> The idea of the fix from Joe Perches.
>
> Signed-off-by: David Daney <david.daney@cavium.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Joe Perches <joe@perches.com>

Actually Aaro Koskinen's similar patch was just committed to the net.git 
tree (commit	208f7ca4d4a6886256763c9c073775c5fdaf47eb), so this whole 
thing seems to have been an exercise in time wasting.

I don't really care which patch goes in at this point.  So I defer to 
davem et al.

David Daney


> ---
>
> This patch should supersede previous patches from Heinrich Schuchardt,
> and may be preferable as it touches fewer lines of code.
>
>   drivers/net/ethernet/octeon/octeon_mgmt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/octeon/octeon_mgmt.c b/drivers/net/ethernet/octeon/octeon_mgmt.c
> index 979c698..5e10c1d 100644
> --- a/drivers/net/ethernet/octeon/octeon_mgmt.c
> +++ b/drivers/net/ethernet/octeon/octeon_mgmt.c
> @@ -290,12 +290,12 @@ static void octeon_mgmt_clean_tx_buffers(struct octeon_mgmt *p)
>   		/* Read the hardware TX timestamp if one was recorded */
>   		if (unlikely(re.s.tstamp)) {
>   			struct skb_shared_hwtstamps ts;
> -			memset(&ts, 0, sizeof(ts));
>   			/* Read the timestamp */
>   			u64 ns = cvmx_read_csr(CVMX_MIXX_TSTAMP(p->port));
>   			/* Remove the timestamp from the FIFO */
>   			cvmx_write_csr(CVMX_MIXX_TSCTL(p->port), 0);
>   			/* Tell the kernel about the timestamp */
> +			memset(&ts, 0, sizeof(ts));
>   			ts.hwtstamp = ns_to_ktime(ns);
>   			skb_tstamp_tx(skb, &ts);
>   		}
>
