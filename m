Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jan 2015 01:27:27 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:42192 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011645AbbATA1ZadWsF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Jan 2015 01:27:25 +0100
Date:   Tue, 20 Jan 2015 00:27:25 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Markos Chandras <markos.chandras@imgtec.com>
cc:     linux-mips@linux-mips.org,
        Matthew Fortune <Matthew.Fortune@imgtec.com>
Subject: Re: [PATCH RFC v2 19/70] MIPS: Use the new "ZC" constraint for MIPS
 R6
In-Reply-To: <1421405389-15512-20-git-send-email-markos.chandras@imgtec.com>
Message-ID: <alpine.LFD.2.11.1501200015580.28301@eddie.linux-mips.org>
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com> <1421405389-15512-20-git-send-email-markos.chandras@imgtec.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45342
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

On Fri, 16 Jan 2015, Markos Chandras wrote:

> GCC versions supporting MIPS R6 use the ZC constraint to enforce a
> 9-bit offset for MIPS R6. We will use that for all MIPS R6 LL/SC
> instructions.
> 
> Cc: Matthew Fortune <Matthew.Fortune@imgtec.com>
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> ---
>  arch/mips/include/asm/compiler.h | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/mips/include/asm/compiler.h b/arch/mips/include/asm/compiler.h
> index c73815e0123a..8f8ed0245a09 100644
> --- a/arch/mips/include/asm/compiler.h
> +++ b/arch/mips/include/asm/compiler.h
> @@ -16,12 +16,20 @@
>  #define GCC_REG_ACCUM "accum"
>  #endif
>  
> +#ifdef CONFIG_CPU_MIPSR6
> +/*
> + * GCC uses ZC for MIPS R6 to indicate a 9-bit offset although
> + * the macro name is a bit misleading
> + */
> +#define GCC_OFF12_ASM() "ZC"
> +#else
>  #ifndef CONFIG_CPU_MICROMIPS
>  #define GCC_OFF12_ASM() "R"
>  #elif __GNUC__ > 4 || (__GNUC__ == 4 && __GNUC_MINOR__ >= 9)
>  #define GCC_OFF12_ASM() "ZC"
>  #else
>  #error "microMIPS compilation unsupported with GCC older than 4.9"
> -#endif
> +#endif /* CONFIG_CPU_MICROMIPS */
> +#endif /* CONFIG_CPU_MIPSR6 */
>  
>  #endif /* _ASM_COMPILER_H */

 I'd prefer to have a GCC version trap here just like with the microMIPS 
constraint.  What is the first upstream version to support R6?  5.0?

 Also rather than stating that the name of the macro has now become a 
misnomer I think it should actually be renamed to something more general, 
like `GCC_OFF_SMALL_ASM' (any better suggestions are welcome).  That'd 
have to be a separate patch though, to be applied first, preferably.

  Maciej
