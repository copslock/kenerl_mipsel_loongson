Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Nov 2016 10:20:46 +0100 (CET)
Received: from mail-bn3nam01on0056.outbound.protection.outlook.com ([104.47.33.56]:24448
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990552AbcKHJUiFrSsM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 Nov 2016 10:20:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ZJtLIytnoT6n2AJGSgpVAjADsGMS6gHQBAnvqXx/T6o=;
 b=dhElit2Hnp/sI7jwH6exuGzC5BawMwPdLQz6gy9x4cNpyP/VBZph1l2QRwR3u0G4ynFotZwLeNN4TChYC6fGuccdOhgEbUrQySA05XoIwBnfGgpd4Dnoh9VEBdWekDtISDRYRkIWRAOehXkR7Hox4c34+/KHG4F/issVc550hKI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jan.Glauber@cavium.com; 
Received: from hardcore (46.223.65.110) by
 CY1PR07MB2588.namprd07.prod.outlook.com (10.167.16.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.649.16; Tue, 8 Nov 2016 09:20:28 +0000
Date:   Tue, 8 Nov 2016 10:20:17 +0100
From:   Jan Glauber <jan.glauber@caviumnetworks.com>
To:     Paul Burton <paul.burton@imgtec.com>
CC:     <linux-i2c@vger.kernel.org>, <linux-mips@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Peter Swain <pswain@cavium.com>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/2] i2c: octeon: Fix waiting for operation completion
Message-ID: <20161108092017.GC5675@hardcore>
References: <20161107200921.30284-1-paul.burton@imgtec.com>
 <20161107200921.30284-2-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20161107200921.30284-2-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [46.223.65.110]
X-ClientProxiedBy: DB6PR0601CA0022.eurprd06.prod.outlook.com (10.168.88.160)
 To CY1PR07MB2588.namprd07.prod.outlook.com (10.167.16.138)
X-MS-Office365-Filtering-Correlation-Id: 1ab8454e-81b4-4c35-5a05-08d407b87c0d
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2588;2:oXvaI3WP30E9u6usUn7P45ybpnCxukx67LOjRUegMur1zbOzuVC0GFpM0yv2g5TUf2Bm9bJVHjOd7IDU5rqIs0JjcQnQbiRybAntafN1se19v7RW2/aw7GNtz4J5T16hTBac2N2yu2CszT7WndJZmsOZno5RkUjZEhg8pbUSdqstQNLkOwUW5Uzd05ZvqiK3UgwFfqWvD14GGfbBHJO+rw==;3:uVjm++DlmASybWF6pnzb5OvKW3yAg0y+IvhD0D3onjtUffGoxOSqKx6xIVW07I8qvSWMwczmZcOWArky/5XrDGkw51HmMS/zncrHysMBMlKiUoaTsWSjsma7xJfSsUVL0a1rhxckTF3UuSDioiGZww==;25:L6CvWJqE1r0sTDnyg40YJOqUXYL5pGsYxEeQSUFGQgvgSyp28entbUOvNm97Z/uk5AXd85sCcLhF1lOLyeMlxc97f8yTyWWlGdGZsu2GyQiER7+F2QxSy42ENchPFmCn7E2zNlD9ffCRl64vrV33Re3A6Y/30ED2fKLPt+EmNQaMJ1wnRxnbOfN/5d1M6sBvYGimVYo/XmF5J/ahLGT03vQtZfMWOqZCZa84LtNwnl8iLYy70ZVUAGk/fnL1dZCo2qXAfs59BF6LTHSUSI4apl6OR0BK9oTTcAv7p2yZD8aE5ZCbDjRTOiGMkKxYFaMQe04rkeMydtStL0iDEpUX6P9uWOIs/labt16AGsDyDjqpACPk3DWLQCDRIfk85UheqOdasLWDUsa3tL0hnmta/AjvId5MFubX1MYf8a1E+7ym4SCJu8qDRFcJohI8ZZ1V
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:CY1PR07MB2588;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2588;31:Sf37C8jfMck8UpGhlqofJyWIU+3gr4pWZZjlnN2Q9KyUI7kIojMNBP/L1w30bs6S7grPNcs5VPH34mUPKcRqvR1MtOSeGWlCUUcjo+JbbY+i+T+ADg7p7FoSn9qcBBWSkBLlyyBIt/OVUj0vzMl9wbK2SDqEFKW4DI4r7PIkI9NR8sG/eIUqU+zUCN1XrjglelBrgBI2umTIFFoGE5fD8Om1o57D9rlOn4wDtfSwMEV98rMtYxZMfHBuXl2R2MJx;20:sTGP/G8CR5RTByNSREQi5bUCW118HAhpu6ywGdF5jXu8TvLgTmVd+xom8ZCvtGX2MiSqcyP9SXQLDJzKNre/6NRp125uR6P5HyFX5v4vnVg6MWKzySN0H+vSqx2wtmBe+Csyw3EtE5Mx1QID52l1q7+I05ew5TZbrcWahAJhT/U9NI6A7MQr/AWEi1d5XOcsfhftJaxrdmbc9ZT/CssrKKhZVM72byM98F0JYrsWyKlON1V5nh2Hn7rkvajk8yOYaLafpN9iHDsJcA8jXyq7SZsPabpv7zAdaNfDW/AGnXO7fH8bStpy4kUdfgOs96RtEcn3AP4j8itdkSogeCLDtxTNEXSyLVa7z0LSWtkZ9HYWlZRi0DQS5NKDh6E+QKpmR5nMoDOfh2q2U15ATABej/hf8yTvPize9oLfQ1CLCz/2PUJTqgqN9brFcNMURuRLgyLpLZL/6jTuYTvlIV+uVsS1VV7/m97p+7c5kTMMttHNAGN1TK/I4plvcnnC1xWSwi3EuDtf+rMc8Pz2/9PhFKqn2+BgmbhRYsZHNr+ULcKNn6oqLcyjw6LFYj5AHvEIIXbgrLqZsdV+nU9ZHOBpow0/4tb7NXGEcVnY5OpOuU0=
X-Microsoft-Antispam-PRVS: <CY1PR07MB258818182C279372D50C211C91A60@CY1PR07MB2588.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040176)(601004)(2401047)(8121501046)(5005006)(10201501046)(3002001);SRVR:CY1PR07MB2588;BCL:0;PCL:0;RULEID:;SRVR:CY1PR07MB2588;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2588;4:X5TD4eCORu57r7hATl7LDBujv4nXjii7Mrc6/+K+QFgKrzSa8eFsKpxOI8zEQP/SKCwtzAs1DCPkPkGdw+TmQUkuzpIZT65+lGdAia6xaLIyxeIfpZvsLczBkc8yVW4QHvssiRaXynAR4WiXH++gIITy6LP43l81s2E3ac6Smmhwahmgx5J7rJCx1CnKw0ZwVvXTFPIvrPqXKUR5Dt0ORYkv42ra0KsflznHCPswNm56H92a6x+pjv9Ul8Yyo7z0nVg9oHUh6lv15P7KjBnYRW/pjmH5IP4WL/7TC5CkoxKUmqAyDUCIGDwOhOsx/0qzP110C78xTxMmpqKaepgmJ8OiKWp8/s3y/dhi9SLECfroua47kqBXrc5+iswdw48ZJzByENrdx9ekfUbWNxo2XmagIcNlsPZlzxExTEBbEgp0rKg4CiCy5rlPtcfWtkuh
X-Forefront-PRVS: 01208B1E18
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(7916002)(24454002)(189002)(199003)(68736007)(1076002)(81166006)(4326007)(101416001)(46406003)(110136003)(9686002)(105586002)(42186005)(47776003)(50466002)(6666003)(92566002)(189998001)(7846002)(66066001)(586003)(97736004)(83506001)(3846002)(4001350100001)(106356001)(33656002)(76176999)(97756001)(2906002)(77096005)(54356999)(50986999)(6116002)(42882006)(33716001)(7736002)(305945005)(2950100002)(5660300001)(6916009)(81156014)(8676002)(23726003)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR07MB2588;H:hardcore;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR07MB2588;23:xB2+G8iRP48UNeu6QkUR+dEW3RFoAgYrlHZ9cXOff?=
 =?us-ascii?Q?hhuXyopN8/WrY7B7OZCyKAc/ovziGmxkl9DGCPtdPrdXUz2m3/7tfJWehjs+?=
 =?us-ascii?Q?2oo/nQNpZYg2z+uZDJPMbfG5Su1lHwGCBX32wgr2h3SRt+YxDEyVqepU8anV?=
 =?us-ascii?Q?zIJyaVZuqodY68DXYfAwqdJuMEkB8/Cn5HJPCQukrqLflWMUShOeOgorWt7M?=
 =?us-ascii?Q?h9v+zDSE9yOkOiBkKjggltmhVVOJaj1Z2MmhwUy1cAuiBtMUycVPK2IMd5oR?=
 =?us-ascii?Q?nMdUmlprc6JSXOTWpTeE0zvGFlhsLqvtU/gR+2reAgWFHzmN3+99lJgJ8CIM?=
 =?us-ascii?Q?Nw8Jf/ZXc7Via7wMBg770P4/MFWPuaVL9viIeB7mt4LLVMYQz+IyQnU3EMAl?=
 =?us-ascii?Q?tFUX712wB8LB7+k6hDakYeTZSEt0MCdzza+peE6x7mbLINRfCFrvULYm4/e6?=
 =?us-ascii?Q?xf6QI4AV0tJIfoziP0upyyI8ZmaDOQmgKWUDaT3bWp+z0iq/xPQRSRiKNd0r?=
 =?us-ascii?Q?eHIS3rgRZLAPQbaiCjPcikp/8xJxKmovyUIAARYhCpG+P4JBngWyGgcVxsfq?=
 =?us-ascii?Q?fsmqcFhKz9+V6zyx6q4V2KC4WQWAPrLHNMsdpe32ISJ1VpBt4aVCi352m1PD?=
 =?us-ascii?Q?UZLgZ6Hwnx5XVSMkqIds7Nwj4z8xxVYBJvTDGlxXEYO7ZB8zTDj0KTbUBf2R?=
 =?us-ascii?Q?DM7SLLIgj5VD/Pw3wiaRlyQtPYB5Jg8Srrs8Rxgbha5Frbgd+geEBCdF3Gpn?=
 =?us-ascii?Q?1K3b6kBu9BODp56FetpX+PkeC6f7nRyG9cEFwvlnMjLavAX72X4D5HyK3aUI?=
 =?us-ascii?Q?BoDxaENANjxVJ+ZTyUOmFKGkf98mWDYzVoD2FSDL46484kW3twMRi69gr/jS?=
 =?us-ascii?Q?yOLYq6EosAitLt5elYxw0cs5YSHLXDvlhXntwJupnuf4cvlC6jHJ/18x3S/3?=
 =?us-ascii?Q?KBuhSyVWyR9x28IDINroGmEhM8iYT0vqVCD3Pb4AFIh5ErN1HUMbzxM1AfVH?=
 =?us-ascii?Q?x7u00U+CNRWoGCifRJHuIT4Wavmd2Qed2Oyl56YR+Cr7P0pwDSic/0GSXy/4?=
 =?us-ascii?Q?tDvcHn1I/HGkhR7ThcMuOurZS/VpR9dGt5fw0h3B/SYXbg+BSImdS5sOY5i7?=
 =?us-ascii?Q?nXlNpc/BMPD6ZjjSqbnxJMnKvER4hTER7ZStPUvpJHzyuxVPBzI4zURU1ihE?=
 =?us-ascii?Q?OZ7kC7A2fWW0jg=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2588;6:ydOpvSwHVbaZ9ZplFR3Sx2nE57uDBEG4QoJ/w2Z53LqpRP28ByCRvntQvYmpkabgIebQELqzINWtCnQvzhI5rZZ/D5qu22pivx84AzKzTwDcGTnp6OPhdPw+H36A59HTYNfLc9DWrWNCiU4TCLmKIHgCnYV04v6iNkObcPV2g5e9vFl4upqubKoiDgz4QsixRv0wUIjQDFHWK1dioXbRlC1i06h2eUgpi1SQc2lvYbiOm2xl2XxIIpdyzoolfKLelLnAlTvzuzB5mEcjSBLBKTc05yazR7J0snC+3QqzkW0TDrfr1930edaKnlbAVnJk;5:eoDMMPmIJpudvis/1RKrbGsjO2dzyb8FlIbJ0tRrc/eOBLOvyiO3EtkE2vXwoUjda7W4ShDAJLyHdb1vRrQ+qFSyOCygat2S3lTOWifrMi+JbGHAc/1zxtz6xkLDOGaslVdwggq9SFohgirCmjQ3Am9+eKRTRv7N+ZzCt+xA9Y4=;24:RjdTZn4ltQmoPxpRv7aTehujBfOpx35Pm3o8r0VpZYP5oN86FSD76ExrtbXFtvoyEAyeO8D5YqQS+9LJFDYeOp9gNDhvA27KRElhZAjwUyM=;7:q9eneL2u9m+ick7FCw4qHXsh0D5VJ9vxZqysIbffQmWFNkoIdrcdKNMYKIXV2GVG3zBh2XAVET7a7NXE0QJX/YADMe5pIupEAPq3ciBo6aeNR4TqtKYCoDZi84IYiwb30rPchMuRaoatfgIuO/z9elsMqkWBZCMkVb8SwZs2GxWzl8jgI9lrPRERtBsfsEfiDvsuPoyFFAkrMPb1e+X0Zwx4MJQMSzjU5m5/XOhkd/ktvv6LbEJswf0FFtEwuOLx49cVRdaK8kmGHLhQMGsu+86Q9Nc5JoDMjl2SmjniEX3WynxIH/tdhwNYE1ZrSLQhZdfcsyw1A4IYThR0x8F6zkQhFj36qZodxnJigFcs1dg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2016 09:20:28.6816 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR07MB2588
Return-Path: <Jan.Glauber@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55724
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jan.glauber@caviumnetworks.com
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

On Mon, Nov 07, 2016 at 08:09:21PM +0000, Paul Burton wrote:
> Commit 1bb1ff3e7c74 ("i2c: octeon: Improve performance if interrupt is
> early") modified octeon_i2c_wait() & octeon_i2c_hlc_wait() to attempt to
> check for a valid bit being clear & if not to sleep for a while then try
> again before waiting on a waitqueue which may time out. However it does
> so by sleeping within a function called as the condition provided to
> wait_event_timeout() which seems to cause strange behaviour, with the
> system hanging during boot with the condition being checked constantly &
> the timeout not seeming to have any effect.
> 
> Fix this by instead checking for the valid bit being clear in the
> octeon_i2c(_hlc)_wait() functions & sleeping there if that condition is
> not met, then calling the wait_event_timeout with a condition that does
> not sleep.
> 
> Tested on a Rhino Labs UTM-8 with Octeon CN7130.

This patch breaks ipmi on ThunderX (CN88xx). We also have not seen the
problems you mention, although I must admit that I don't like the
complicated nested waits.

--Jan

> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: David Daney <david.daney@cavium.com>
> Cc: Jan Glauber <jglauber@cavium.com>
> Cc: Peter Swain <pswain@cavium.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-i2c@vger.kernel.org
> ---
> 
>  drivers/i2c/busses/i2c-octeon-core.c | 58 ++++++++++--------------------------
>  1 file changed, 15 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-octeon-core.c b/drivers/i2c/busses/i2c-octeon-core.c
> index 419b54b..2e270a1 100644
> --- a/drivers/i2c/busses/i2c-octeon-core.c
> +++ b/drivers/i2c/busses/i2c-octeon-core.c
> @@ -36,24 +36,6 @@ static bool octeon_i2c_test_iflg(struct octeon_i2c *i2c)
>  	return (octeon_i2c_ctl_read(i2c) & TWSI_CTL_IFLG);
>  }
>  
> -static bool octeon_i2c_test_ready(struct octeon_i2c *i2c, bool *first)
> -{
> -	if (octeon_i2c_test_iflg(i2c))
> -		return true;
> -
> -	if (*first) {
> -		*first = false;
> -		return false;
> -	}
> -
> -	/*
> -	 * IRQ has signaled an event but IFLG hasn't changed.
> -	 * Sleep and retry once.
> -	 */
> -	usleep_range(I2C_OCTEON_EVENT_WAIT, 2 * I2C_OCTEON_EVENT_WAIT);
> -	return octeon_i2c_test_iflg(i2c);
> -}
> -
>  /**
>   * octeon_i2c_wait - wait for the IFLG to be set
>   * @i2c: The struct octeon_i2c
> @@ -80,8 +62,13 @@ static int octeon_i2c_wait(struct octeon_i2c *i2c)
>  	}
>  
>  	i2c->int_enable(i2c);
> -	time_left = wait_event_timeout(i2c->queue, octeon_i2c_test_ready(i2c, &first),
> -				       i2c->adap.timeout);
> +	time_left = i2c->adap.timeout;
> +	if (!octeon_i2c_test_iflg(i2c)) {
> +		usleep_range(I2C_OCTEON_EVENT_WAIT, 2 * I2C_OCTEON_EVENT_WAIT);
> +		time_left = wait_event_timeout(i2c->queue,
> +					       octeon_i2c_test_iflg(i2c),
> +					       time_left);
> +	}
>  	i2c->int_disable(i2c);
>  
>  	if (i2c->broken_irq_check && !time_left &&
> @@ -99,26 +86,8 @@ static int octeon_i2c_wait(struct octeon_i2c *i2c)
>  
>  static bool octeon_i2c_hlc_test_valid(struct octeon_i2c *i2c)
>  {
> -	return (__raw_readq(i2c->twsi_base + SW_TWSI(i2c)) & SW_TWSI_V) == 0;
> -}
> -
> -static bool octeon_i2c_hlc_test_ready(struct octeon_i2c *i2c, bool *first)
> -{
>  	/* check if valid bit is cleared */
> -	if (octeon_i2c_hlc_test_valid(i2c))
> -		return true;
> -
> -	if (*first) {
> -		*first = false;
> -		return false;
> -	}
> -
> -	/*
> -	 * IRQ has signaled an event but valid bit isn't cleared.
> -	 * Sleep and retry once.
> -	 */
> -	usleep_range(I2C_OCTEON_EVENT_WAIT, 2 * I2C_OCTEON_EVENT_WAIT);
> -	return octeon_i2c_hlc_test_valid(i2c);
> +	return (__raw_readq(i2c->twsi_base + SW_TWSI(i2c)) & SW_TWSI_V) == 0;
>  }
>  
>  static void octeon_i2c_hlc_int_clear(struct octeon_i2c *i2c)
> @@ -176,7 +145,6 @@ static void octeon_i2c_hlc_disable(struct octeon_i2c *i2c)
>   */
>  static int octeon_i2c_hlc_wait(struct octeon_i2c *i2c)
>  {
> -	bool first = true;
>  	int time_left;
>  
>  	/*
> @@ -194,9 +162,13 @@ static int octeon_i2c_hlc_wait(struct octeon_i2c *i2c)
>  	}
>  
>  	i2c->hlc_int_enable(i2c);
> -	time_left = wait_event_timeout(i2c->queue,
> -				       octeon_i2c_hlc_test_ready(i2c, &first),
> -				       i2c->adap.timeout);
> +	time_left = i2c->adap.timeout;
> +	if (!octeon_i2c_hlc_test_valid(i2c)) {
> +		usleep_range(I2C_OCTEON_EVENT_WAIT, 2 * I2C_OCTEON_EVENT_WAIT);
> +		time_left = wait_event_timeout(i2c->queue,
> +					       octeon_i2c_hlc_test_valid(i2c),
> +					       time_left);
> +	}
>  	i2c->hlc_int_disable(i2c);
>  	if (!time_left)
>  		octeon_i2c_hlc_int_clear(i2c);
> -- 
> 2.10.2
