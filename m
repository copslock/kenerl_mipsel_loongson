Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jan 2015 00:09:19 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:36926 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011190AbbA1XJRP1FSk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Jan 2015 00:09:17 +0100
Date:   Wed, 28 Jan 2015 23:09:17 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     James Hogan <james.hogan@imgtec.com>
cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] MIPS: Add arch CDMM definitions and probing
In-Reply-To: <1422393401-13543-2-git-send-email-james.hogan@imgtec.com>
Message-ID: <alpine.LFD.2.11.1501280253280.28301@eddie.linux-mips.org>
References: <1422393401-13543-1-git-send-email-james.hogan@imgtec.com> <1422393401-13543-2-git-send-email-james.hogan@imgtec.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45515
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Tue, 27 Jan 2015, James Hogan wrote:

> diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
> index 33866fce4d63..2086372fa72a 100644
> --- a/arch/mips/include/asm/cpu.h
> +++ b/arch/mips/include/asm/cpu.h
> @@ -370,6 +370,7 @@ enum cpu_type_enum {
>  #define MIPS_CPU_RIXIEX		0x200000000ull /* CPU has unique exception codes for {Read, Execute}-Inhibit exceptions */
>  #define MIPS_CPU_MAAR		0x400000000ull /* MAAR(I) registers are present */
>  #define MIPS_CPU_FRE		0x800000000ull /* FRE & UFE bits implemented */
> +#define MIPS_CPU_CDMM		0x10000000000ll /* CPU has Common Device Memory Map */

 Is it a typo here: 0x10000000000ll vs 0x1000000000ull?

  Maciej
