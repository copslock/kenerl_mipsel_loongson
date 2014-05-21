Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 May 2014 13:14:21 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:2448 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822271AbaEULONuvhDX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 May 2014 13:14:13 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 09CA118E9EF30;
        Wed, 21 May 2014 12:14:05 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Wed, 21 May
 2014 12:14:06 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Wed, 21 May 2014 12:14:06 +0100
Received: from [192.168.154.101] (192.168.154.101) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.174.1; Wed, 21 May
 2014 12:14:06 +0100
Message-ID: <537C89B5.2030907@imgtec.com>
Date:   Wed, 21 May 2014 12:10:45 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        <linux-mips@linux-mips.org>
CC:     David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 07/15] MIPS: Add mips_cpunum() function.
References: <1400597236-11352-1-git-send-email-andreas.herrmann@caviumnetworks.com> <1400597236-11352-8-git-send-email-andreas.herrmann@caviumnetworks.com>
In-Reply-To: <1400597236-11352-8-git-send-email-andreas.herrmann@caviumnetworks.com>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.101]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40211
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

On 20/05/14 15:47, Andreas Herrmann wrote:
> From: David Daney <david.daney@cavium.com>
> 
> This returns the CPUNum from the low order Ebase bits.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
> ---
>  arch/mips/include/asm/mipsregs.h |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
> index 3e025b5..f110d48 100644
> --- a/arch/mips/include/asm/mipsregs.h
> +++ b/arch/mips/include/asm/mipsregs.h
> @@ -1916,6 +1916,11 @@ __BUILD_SET_C0(brcm_cmt_ctrl)
>  __BUILD_SET_C0(brcm_config)
>  __BUILD_SET_C0(brcm_mode)
>  
> +static inline unsigned int mips_cpunum(void)
> +{
> +	return read_c0_ebase() & 0x3ff; /* Low 10 bits of ebase. */
> +}

If this is going to go in mips generic code I think it should be clearly
defined, especially in the presence of MT, otherwise perhaps it makes
sense for it to go in a paravirt specific header?

I.e. does it return the core number of the running VPE (if so it should
probably do something like below as in decode_configs() and go in
smp.h), or does it simply always return that field in ebase register (in
which case it should probably have ebase in the name and a comment to
clarify that it doesn't necessarily map directly to core/vpe number).

unsigned int core = read_c0_ebase() & 0x3ff;
if (cpu_has_mipsmt)
	core >>= fls(smp_num_siblings) - 1;

Cheers
James
