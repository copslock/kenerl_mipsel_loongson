Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Feb 2016 17:54:54 +0100 (CET)
Received: from smtp-out6.electric.net ([192.162.217.191]:56555 "EHLO
        smtp-out6.electric.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011683AbcBCQyxG690t convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 3 Feb 2016 17:54:53 +0100
Received: from 1aR0hf-0006Ox-Tx by out6d.electric.net with emc1-ok (Exim 4.85)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1aR0hf-0006Tg-WC; Wed, 03 Feb 2016 08:54:51 -0800
Received: by emcmailer; Wed, 03 Feb 2016 08:54:51 -0800
Received: from [213.249.233.130] (helo=AcuExch.aculab.com)
        by out6d.electric.net with esmtps (TLSv1:AES128-SHA:128)
        (Exim 4.85)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1aR0hf-0006Ox-Tx; Wed, 03 Feb 2016 08:54:51 -0800
Received: from ACUEXCH.Aculab.com ([::1]) by AcuExch.aculab.com ([::1]) with
 mapi id 14.03.0123.003; Wed, 3 Feb 2016 16:51:35 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Paul Burton' <paul.burton@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 6/6] net: pch_gbe: Allow longer for resets
Thread-Topic: [PATCH v2 6/6] net: pch_gbe: Allow longer for resets
Thread-Index: AQHRXnq3fgQTopO/nkaWnymXFPZpDp8aiNpg
Date:   Wed, 3 Feb 2016 16:51:34 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1CCD57CD@AcuExch.aculab.com>
References: <1454500964-6256-1-git-send-email-paul.burton@imgtec.com>
 <1454500964-6256-7-git-send-email-paul.burton@imgtec.com>
In-Reply-To: <1454500964-6256-7-git-send-email-paul.burton@imgtec.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.99.200]
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Outbound-IP: 213.249.233.130
X-Env-From: David.Laight@ACULAB.COM
X-PolicySMART: 3396946, 3397078
X-Virus-Status: Scanned by VirusSMART (c)
X-Virus-Status: Scanned by VirusSMART (s)
Return-Path: <David.Laight@ACULAB.COM>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51704
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: David.Laight@ACULAB.COM
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

From: Paul Burton
> Sent: 03 February 2016 12:03
> Resets of the EG20T MAC on the MIPS Boston development board take longer
> than the 1000 loops that pch_gbe_wait_clr_bit was performing. Bump up
> the number of loops.
...
> diff --git a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c b/drivers/net/ethernet/oki-
> semi/pch_gbe/pch_gbe_main.c
> index 00ef83c..87994d2 100644
> --- a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
> +++ b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
> @@ -321,7 +321,7 @@ static void pch_gbe_wait_clr_bit(void *reg, u32 bit)
>  	u32 tmp;
> 
>  	/* wait busy */
> -	tmp = 1000;
> +	tmp = 10000;
>  	while ((ioread32(reg) & bit) && --tmp)
>  		cpu_relax();
>  	if (!tmp)

Why not sleep for (say) 100us ?
That'll stop the loop depending on the cpu speed.

	David
