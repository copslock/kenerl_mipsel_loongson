Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Mar 2015 21:40:34 +0100 (CET)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27009701AbbCWUkcZ06-J (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Mar 2015 21:40:32 +0100
Date:   Mon, 23 Mar 2015 20:40:32 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Markos Chandras <Markos.Chandras@imgtec.com>
cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 1/4] MIPS: asm: r4kcache: Use correct base register for
 MIPS R6 cache flushes
In-Reply-To: <54FD5D34.7060201@imgtec.com>
Message-ID: <alpine.LFD.2.11.1503232033060.8758@eddie.linux-mips.org>
References: <1425408530-21613-1-git-send-email-markos.chandras@imgtec.com> <1425408530-21613-2-git-send-email-markos.chandras@imgtec.com> <alpine.LFD.2.11.1503050245540.18344@eddie.linux-mips.org> <54FD5D34.7060201@imgtec.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46501
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

On Mon, 9 Mar 2015, Markos Chandras wrote:

> >  Since this operates on addresses shouldn't PTR_ADDIU be used instead?
> > 
> >   Maciej
> > 
> 
> I don't know. I thought PTR_ADDIU should be used for pointers but the
> arguments in these macros are "unsigned long".

 Hmm, good point.  I think we should match the C data type used even 
though we have an assumption that sizeof(long) == sizeof(void *), so your 
change looks right to me as it stands.

 I think we have a convention to separate `linux' from `asm' inclusions by 
an empty line though, so I suggest that you add one here:

> diff --git a/arch/mips/include/asm/r4kcache.h b/arch/mips/include/asm/r4kcache.h
> index 1b22d2da88a1..d329f7328bd4 100644
> --- a/arch/mips/include/asm/r4kcache.h
> +++ b/arch/mips/include/asm/r4kcache.h
> @@ -12,6 +12,7 @@
>  #ifndef _ASM_R4KCACHE_H
>  #define _ASM_R4KCACHE_H
>  
> +#include <linux/stringify.h>
>  #include <asm/asm.h>
>  #include <asm/cacheops.h>
>  #include <asm/compiler.h>

as well.  I can offer you my review tag if you repost the change with this 
trivial update.

  Maciej
