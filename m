Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Jan 2015 18:08:14 +0100 (CET)
Received: from mail-lb0-f173.google.com ([209.85.217.173]:51670 "EHLO
        mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010714AbbAGRII3k0M0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Jan 2015 18:08:08 +0100
Received: by mail-lb0-f173.google.com with SMTP id z12so1450201lbi.18
        for <linux-mips@linux-mips.org>; Wed, 07 Jan 2015 09:08:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=GjnzX2+ifi4/Xq11fIXHSK1pUIdz6N3cOMx5QcYpCSI=;
        b=HNOglJu6RDsKFhdsMMUpd/1Ns/Eui5mpYzQw7R4z3yMyoNUsBqQUdSEzI5ezt6kIKv
         oTKmEr6r4jk7g11kuy6gkVZKh72sYV8ba1E73kYXUKqCQ8ZpVcvNQKoLk/BbMn64Q0Np
         WlT7kTtFjYvCSdim7Way/pRJjmME2Sc+0eTQBW+BlE1xjUCuQ76YhViSDaKH7VgdAk3p
         kP+biZECRK5EvWvCQ8yzXaL4CE612k61w8wAdGLjcLzzTDJFMykvBOvbSn1oPDGKFdPG
         dZijQ2Ohrf9jnX8u5CViAZLnP6HtcXrjSBAihAKp677op78Qmv/HTuyoWr0pdYngDzql
         s11w==
X-Gm-Message-State: ALoCoQliNMSNZMTFjERvfYb+rfDKXPT0HYT82WHjUGvAwWYUZ6HX8KNi3+1TNWrxsRANC6ytZv8j
X-Received: by 10.152.205.104 with SMTP id lf8mr895278lac.94.1420650482906;
        Wed, 07 Jan 2015 09:08:02 -0800 (PST)
Received: from wasted.cogentembedded.com (ppp83-237-253-86.pppoe.mtu-net.ru. [83.237.253.86])
        by mx.google.com with ESMTPSA id az15sm564283lab.30.2015.01.07.09.08.00
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Jan 2015 09:08:01 -0800 (PST)
Message-ID: <54AD67EF.2080406@cogentembedded.com>
Date:   Wed, 07 Jan 2015 20:07:59 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
MIME-Version: 1.0
To:     Jayachandran C <jchandra@broadcom.com>, linux-mips@linux-mips.org
CC:     ralf@linux-mips.org
Subject: Re: [PATCH 04/17] MIPS: Netlogic: Disable writing IRT for disabled
 blocks
References: <1420630118-17198-1-git-send-email-jchandra@broadcom.com> <1420630118-17198-5-git-send-email-jchandra@broadcom.com>
In-Reply-To: <1420630118-17198-5-git-send-email-jchandra@broadcom.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45006
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

Hello.

On 01/07/2015 02:28 PM, Jayachandran C wrote:

> If the device header of a block is not present, return invalid IRT
> value so that we do not program an incorrect offset.

> Signed-off-by: Jayachandran C <jchandra@broadcom.com>
> ---
>   arch/mips/netlogic/xlp/nlm_hal.c | 25 ++++++++++++++++---------
>   1 file changed, 16 insertions(+), 9 deletions(-)

> diff --git a/arch/mips/netlogic/xlp/nlm_hal.c b/arch/mips/netlogic/xlp/nlm_hal.c
> index 7e0d224..de41fb5 100644
> --- a/arch/mips/netlogic/xlp/nlm_hal.c
> +++ b/arch/mips/netlogic/xlp/nlm_hal.c
> @@ -170,16 +170,23 @@ static int xlp_irq_to_irt(int irq)
>   	}
>
>   	if (devoff != 0) {
> +		uint32_t val;
> +
>   		pcibase = nlm_pcicfg_base(devoff);
> -		irt = nlm_read_reg(pcibase, XLP_PCI_IRTINFO_REG) & 0xffff;
> -		/* HW weirdness, I2C IRT entry has to be fixed up */
> -		switch (irq) {
> -		case PIC_I2C_1_IRQ:
> -			irt = irt + 1; break;
> -		case PIC_I2C_2_IRQ:
> -			irt = irt + 2; break;
> -		case PIC_I2C_3_IRQ:
> -			irt = irt + 3; break;
> +		val = nlm_read_reg(pcibase, XLP_PCI_IRTINFO_REG);
> +		if (val == 0xffffffff) {
> +			irt = -1;
> +		} else {
> +			irt = val & 0xffff;
> +			/* HW weirdness, I2C IRT entry has to be fixed up */
> +			switch (irq) {
> +			case PIC_I2C_1_IRQ:
> +				irt = irt + 1; break;
> +			case PIC_I2C_2_IRQ:
> +				irt = irt + 2; break;
> +			case PIC_I2C_3_IRQ:
> +				irt = irt + 3; break;

    Why not 'irt += n' in all 3 cases?
    And don't place *break* on the same line -- this upsets checkpatch.pl IIRC.

WBR, Sergei
