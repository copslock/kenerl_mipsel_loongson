Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Dec 2017 16:12:37 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:50312 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990408AbdLZPM2yobAj convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 26 Dec 2017 16:12:28 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx2.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 26 Dec 2017 15:12:17 +0000
Received: from MIPSMAIL01.mipstec.com ([fe80::5c93:1f20:524d:a563]) by
 MIPSMAIL01.mipstec.com ([fe80::5c93:1f20:524d:a563%13]) with mapi id
 14.03.0361.001; Tue, 26 Dec 2017 07:12:06 -0800
From:   Aleksandar Markovic <Aleksandar.Markovic@mips.com>
To:     Mathieu Malaterre <malat@debian.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Miodrag Dinic <Miodrag.Dinic@mips.com>,
        Goran Ferenc <goran.ferenc@imgtec.com>,
        James Hogan <jhogan@kernel.org>,
        Douglas Leung <douglas.leung@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] MIPS: math-emu: Declare ys variable as possibly
 unused
Thread-Topic: [PATCH 2/2] MIPS: math-emu: Declare ys variable as possibly
 unused
Thread-Index: AQHTfjbGgrIJsUzVl0WqDMFsHhAiLKNVuzmK
Date:   Tue, 26 Dec 2017 15:12:06 +0000
Message-ID: <BD3A5F1946F2E540A31AF2CE969BAEEEC28256@MIPSMAIL01.mipstec.com>
References: <20171226104554.19612-1-malat@debian.org>,<20171226104554.19612-2-malat@debian.org>
In-Reply-To: <20171226104554.19612-2-malat@debian.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [82.117.201.26]
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-BESS-ID: 1514301136-298553-22495-124251-7
X-BESS-VER: 2017.16-r1712230000
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.188370
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Aleksandar.Markovic@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61606
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Aleksandar.Markovic@mips.com
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

> Fix non-fatal warning:
>
> arch/mips/math-emu/sp_fdp.c: In function ‘ieee754sp_fdp’:
> arch/mips/math-emu/ieee754int.h:60:31: warning: variable ‘ys’ set but not used [-Wunused-but-set-variable]
>   unsigned int ym; int ye; int ys; int yc
>                                ^
> arch/mips/math-emu/sp_fdp.c:37:2: note: in expansion of macro ‘COMPYSP’
>   COMPYSP;
>   ^~~~~~~
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>  arch/mips/math-emu/ieee754int.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/math-emu/ieee754int.h b/arch/mips/math-emu/ieee754int.h
> index 06ac0e2ac7ac..cb8f04cd24bf 100644
> --- a/arch/mips/math-emu/ieee754int.h
> +++ b/arch/mips/math-emu/ieee754int.h
> @@ -57,7 +57,7 @@ static inline int ieee754_class_nan(int xc)
>          unsigned int xm; int xe; int xs __maybe_unused; int xc
>  
>  #define COMPYSP \
> -       unsigned int ym; int ye; int ys; int yc
> +       unsigned int ym; int ye; int ys __maybe_unused; int yc
>  
>  #define COMPZSP \
>          unsigned int zm; int ze; int zs; int zc

This will silence the warning, but will do it for all future cases of unused
ys too - in other words, it may well silence even useful, valid warnings.
Also, this introduces an inconsistency among COMPXSP, COMPYSP, and COMPZSP
macros.

A better solution would be to reduce the scope of ys, so that it is always
used, if declared. Instead of this code segment (in arch/mips/math-emu/sp_fdp.c):

union ieee754sp ieee754sp_fdp(union ieee754dp x)
{
	union ieee754sp y;
	u32 rm;

	COMPXDP;
	COMPYSP;

	EXPLODEXDP;

	ieee754_clearcx();

	FLUSHXDP;

	switch (xc) {
	case IEEE754_CLASS_SNAN:
		x = ieee754dp_nanxcpt(x);
		EXPLODEXDP;
		/* Fall through.  */
	case IEEE754_CLASS_QNAN:
		y = ieee754sp_nan_fdp(xs, xm);
		if (!ieee754_csr.nan2008) {
			EXPLODEYSP;
			if (!ieee754_class_nan(yc))
				y = ieee754sp_indef();
		}
		return y;


... should be the following: (COMPYSP is moved to a smaller code block)

union ieee754sp ieee754sp_fdp(union ieee754dp x)
{
	union ieee754sp y;
	u32 rm;

	COMPXDP;	

	EXPLODEXDP;

	ieee754_clearcx();

	FLUSHXDP;

	switch (xc) {
	case IEEE754_CLASS_SNAN:
		x = ieee754dp_nanxcpt(x);
		EXPLODEXDP;
		/* Fall through.  */
	case IEEE754_CLASS_QNAN:
		{
			COMPYSP;

			y = ieee754sp_nan_fdp(xs, xm);
			if (!ieee754_csr.nan2008) {
				EXPLODEYSP;
				if (!ieee754_class_nan(yc))
					y = ieee754sp_indef();
			}
			return y;
		}

Regards,
Aleksandar
From Aleksandar.Markovic@mips.com Tue Dec 26 16:15:06 2017
Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Dec 2017 16:15:13 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:52841 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990408AbdLZPPGB8afj convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 26 Dec 2017 16:15:06 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 26 Dec 2017 15:14:57 +0000
Received: from MIPSMAIL01.mipstec.com ([fe80::5c93:1f20:524d:a563]) by
 MIPSMAIL01.mipstec.com ([fe80::5c93:1f20:524d:a563%13]) with mapi id
 14.03.0361.001; Tue, 26 Dec 2017 07:14:54 -0800
From:   Aleksandar Markovic <Aleksandar.Markovic@mips.com>
To:     Mathieu Malaterre <malat@debian.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Miodrag Dinic <Miodrag.Dinic@mips.com>,
        Goran Ferenc <goran.ferenc@imgtec.com>,
        James Hogan <jhogan@kernel.org>,
        Douglas Leung <douglas.leung@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] MIPS: math-emu: Do not export function `srl128`
Thread-Topic: [PATCH 1/2] MIPS: math-emu: Do not export function `srl128`
Thread-Index: AQHTfjbDDkW3mp2YQEe0MOnepteVLqNVu/WC
Date:   Tue, 26 Dec 2017 15:14:54 +0000
Message-ID: <BD3A5F1946F2E540A31AF2CE969BAEEEC2826A@MIPSMAIL01.mipstec.com>
References: <20171226104554.19612-1-malat@debian.org>
In-Reply-To: <20171226104554.19612-1-malat@debian.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [82.117.201.26]
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-BESS-ID: 1514301295-298552-16788-126670-10
X-BESS-VER: 2017.16-r1712230000
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.188370
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Aleksandar.Markovic@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61607
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Aleksandar.Markovic@mips.com
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
Content-Length: 820
Lines: 26

> Fix non-fatal warning:
> 
> arch/mips/math-emu/dp_maddf.c:19:6: warning: no previous prototype for ‘srl128’ [-Wmissing-prototypes]
>  void srl128(u64 *hptr, u64 *lptr, int count)
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>  arch/mips/math-emu/dp_maddf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/math-emu/dp_maddf.c b/arch/mips/math-emu/dp_maddf.c
> index 7ad79ed411f5..0e2278a47f43 100644
> --- a/arch/mips/math-emu/dp_maddf.c
> +++ b/arch/mips/math-emu/dp_maddf.c
> @@ -16,7 +16,7 @@
>  
>  
>  /* 128 bits shift right logical with rounding. */
> -void srl128(u64 *hptr, u64 *lptr, int count)
> +static void srl128(u64 *hptr, u64 *lptr, int count)
>  {
>          u64 low;
>  
> -- 
> 2.11.0

Acked-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
From rdunlap@infradead.org Tue Dec 26 17:29:24 2017
Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Dec 2017 17:29:33 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:41325 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990408AbdLZQ3YZP0Zi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Dec 2017 17:29:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=f1lm3HMyyklfEayuDgXXvu7I1nj2jPSCHx9Z/REaL6c=; b=sn7y3cxiQRqOt+g7rcv1dyvbw
        v5PP0a6XyHgaPOfkxAz5F4fwxraz7GQP4bhrVwt4i9gFmNJzg6cOtrBWEHh/g8Sj9XGTZalCKjIt5
        su2uQniutPrHl80/oxhqhg0vCXcFizcJXU1MIh2GHNT3r1lDow9bTuRFO6CWiHWtS7txaLGJ2hLHU
        uO/1sXklF1TcvSL5tUZZPOosHZ7cF9+aYPBh2NwBg9PekdB1HeG9re7EYf4twon3pWmIoI+zSExQ3
        jbnjv484jQOZetLT0npOj5jJLxA618ObLLeNCbN60UUMXQ9FvxZ6eihskIDED7RNS5Z2cZOoE/tdM
        XoSPNxOHg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlap)
        by bombadil.infradead.org with esmtpsa (Exim 4.89 #1 (Red Hat Linux))
        id 1eTs6P-0006IG-Rx; Tue, 26 Dec 2017 16:29:17 +0000
Subject: Re: [PATCH] MIPS: Use proper @return keyword
To:     Mathieu Malaterre <malat@debian.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "Maciej W. Rozycki" <macro@mips.com>,
        Paul Burton <paul.burton@mips.com>,
        Ingo Molnar <mingo@kernel.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
References: <20171226105532.23452-1-malat@debian.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9bd8b13f-e9c0-44ec-f53d-f9171973d9a8@infradead.org>
Date:   Tue, 26 Dec 2017 08:29:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20171226105532.23452-1-malat@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <rdunlap@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61608
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rdunlap@infradead.org
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
Content-Length: 964
Lines: 32

On 12/26/2017 02:55 AM, Mathieu Malaterre wrote:
> Fix non-fatal warning:
> 
> arch/mips/kernel/branch.c:418: warning: Excess function parameter 'returns' description in '__compute_return_epc_for_insn'
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>  arch/mips/kernel/branch.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/kernel/branch.c b/arch/mips/kernel/branch.c
> index b79ed9af9886..e0d3a432e1e3 100644
> --- a/arch/mips/kernel/branch.c
> +++ b/arch/mips/kernel/branch.c
> @@ -399,7 +399,7 @@ int __MIPS16e_compute_return_epc(struct pt_regs *regs)
>   *
>   * @regs:	Pointer to pt_regs
>   * @insn:	branch instruction to decode
> - * @returns:	-EFAULT on error and forces SIGILL, and on success
> + * @return:	-EFAULT on error and forces SIGILL, and on success

No @, just
	return: <text>

>   *		returns 0 or BRANCH_LIKELY_TAKEN as appropriate after
>   *		evaluating the branch.
>   *
> 


-- 
~Randy
