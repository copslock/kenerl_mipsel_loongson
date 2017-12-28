Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Dec 2017 08:14:53 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:49762 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990398AbdL1HOo1BKHK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Dec 2017 08:14:44 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx28.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Thu, 28 Dec 2017 07:14:04 +0000
Received: from [192.168.159.77] (192.168.159.77) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 27 Dec
 2017 23:13:40 -0800
Subject: Re: [PATCH 1/2] nvmem: add driver for JZ4780 efuse
To:     Mathieu Malaterre <malat@debian.org>, <Zubair.Kakakhel@mips.com>
CC:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        "Srinivas Kandagatla" <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        Harvey Hunt <harvey.hunt@imgtec.com>,
        James Hogan <jhogan@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mips@linux-mips.org>
References: <20171227122722.5219-1-malat@debian.org>
 <20171227122722.5219-2-malat@debian.org>
From:   Marcin Nowakowski <marcin.nowakowski@mips.com>
Message-ID: <bbc64846-e12e-aea8-c516-5e03f6253fed@mips.com>
Date:   Thu, 28 Dec 2017 08:13:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20171227122722.5219-2-malat@debian.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.159.77]
X-BESS-ID: 1514445242-637138-32434-176451-5
X-BESS-VER: 2017.16-r1712230000
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.20
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.188423
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.20 BSF_SC7_SA298e         META: Custom Rule SA298e 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.20 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_SC7_SA298e, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Marcin.Nowakowski@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61642
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marcin.nowakowski@mips.com
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

Hi Mathieu, PrasannaKumar,

On 27.12.2017 13:27, Mathieu Malaterre wrote:
> From: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
> 
> This patch brings support for the JZ4780 efuse. Currently it only expose
> a read only access to the entire 8K bits efuse memory.
> 
> Tested-by: Mathieu Malaterre <malat@debian.org>
> Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
> ---

> +
> +/* main entry point */
> +static int jz4780_efuse_read(void *context, unsigned int offset,
> +					void *val, size_t bytes)
> +{
> +	static const int nsegments = sizeof(segments) / sizeof(*segments);
> +	struct jz4780_efuse *efuse = context;
> +	char buf[32];
> +	char *cur = val;
> +	int i;
> +	/* PM recommends read/write each segment separately */
> +	for (i = 0; i < nsegments; ++i) {
> +		unsigned int *segment = segments[i];
> +		unsigned int lpos = segment[0];
> +		unsigned int buflen = segment[1] / 8;
> +		unsigned int ncount = buflen / 32;
> +		unsigned int remain = buflen % 32;
> +		int j;

This doesn't look right, as offset & bytes are completely ignored. This 
means it will return data from an offset other than requested and may 
also overrun the provided output buffer?

> +		/* EFUSE can read or write maximum 256bit in each time */
> +		for (j = 0; j < ncount ; ++j) {
> +			jz4780_efuse_read_32bytes(efuse, buf, lpos);
> +			memcpy(cur, buf, sizeof(buf));
> +			cur += sizeof(buf);
> +			lpos += sizeof(buf);
> +			}
> +		if (remain) {
> +			jz4780_efuse_read_32bytes(efuse, buf, lpos);
> +			memcpy(cur, buf, remain);
> +			cur += remain;
> +			}
> +		}
> +
> +	return 0;
> +}


Marcin
