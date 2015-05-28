Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 May 2015 01:47:10 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27007351AbbE1XrHh3Xig (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 May 2015 01:47:07 +0200
Date:   Fri, 29 May 2015 00:47:07 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     James Hogan <james.hogan@imgtec.com>
cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH v2 03/10] MIPS: mipsregs.h: Add EntryLo bit definitions
In-Reply-To: <1432025438-26431-4-git-send-email-james.hogan@imgtec.com>
Message-ID: <alpine.LFD.2.11.1505290009160.26459@eddie.linux-mips.org>
References: <1432025438-26431-1-git-send-email-james.hogan@imgtec.com> <1432025438-26431-4-git-send-email-james.hogan@imgtec.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47719
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

On Tue, 19 May 2015, James Hogan wrote:

> Add definitions for EntryLo register bits in mipsregs.h. The R4000
> compatible ones are prefixed MIPS_ENTRYLO_ and the R3000 compatible ones
> are prefixed R3K_ENTRYLO_.

 I think the convention for macros in <asm/mipsregs.h> has been to omit 
the MIPS_ prefix for generic definitions.  The prefix is meant for MIPS32 
and MIPS64 architecture processor properties.  The bits in EntryLo0/1 have 
been like this since forever, with the exception of the R3k/R6k/R8k 
oddballs.  So I think they can be treated as generic.  Of course the R3K_ 
prefix is right with R3k-specific definitions.

 OTOH, the EntryHi.EHINV bit has only been added with (non-legacy) MIPS 
architecture processors, so MIPS_ENTRYHI_EHINV is the right choice 
(although its placement is unfortunate, buried within the "Bits in the 
MIPS32/64 PRA coprocessor 0 config registers 1 and above." section).

> diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
> index 764e2756b54d..3b5a145af659 100644
> --- a/arch/mips/include/asm/mipsregs.h
> +++ b/arch/mips/include/asm/mipsregs.h
> @@ -589,6 +589,28 @@
>  /*  EntryHI bit definition */
>  #define MIPS_ENTRYHI_EHINV	(_ULCAST_(1) << 10)
>  
> +/* R3000 EntryLo bit definitions */
> +#define R3K_ENTRYLO_G		(_ULCAST_(1) << 8)
> +#define R3K_ENTRYLO_V		(_ULCAST_(1) << 9)
> +#define R3K_ENTRYLO_D		(_ULCAST_(1) << 10)
> +#define R3K_ENTRYLO_N		(_ULCAST_(1) << 11)
> +
> +/* R4000 compatible EntryLo bit definitions */
> +#define MIPS_ENTRYLO_G		(_ULCAST_(1) << 0)
> +#define MIPS_ENTRYLO_V		(_ULCAST_(1) << 1)
> +#define MIPS_ENTRYLO_D		(_ULCAST_(1) << 2)
> +#define MIPS_ENTRYLO_C_SHIFT	3
> +#define MIPS_ENTRYLO_C		(_ULCAST_(7) << MIPS_ENTRYLO_C_SHIFT)

 Please drop the MIPS_ prefix here then, e.g.:

#define ENTRYLO_G		(_ULCAST_(1) << 0)

> +#ifdef CONFIG_64BIT
> +/* as read by dmfc0 */
> +#define MIPS_ENTRYLO_XI		(_ULCAST_(1) << 62)
> +#define MIPS_ENTRYLO_RI		(_ULCAST_(1) << 63)
> +#else
> +/* as read by mfc0 */
> +#define MIPS_ENTRYLO_XI		(_ULCAST_(1) << 30)
> +#define MIPS_ENTRYLO_RI		(_ULCAST_(1) << 31)
> +#endif
> +

 These do need to keep the prefix however, because these have only been 
added with MIPS32/MIPS64 processors.  This also means they need its own 
explanatory heading.

 And then put the generic (or R4k) bits first, followed by the R3k bits, 
followed by the MIPS32/64 bits.  See how it's been done for the Status 
register (disregard the odd ST0_ prefix, it's another legacy) and the 
Config register.

 Like with MIPS_ENTRYHI_EHINV I think the placement of these new additions 
is also unfortunate.  No need for you to fix the former, unless you're 
keen to, but with this new stuff I suggest that you put it right at the 
top, to keep the definitions grouped by the function (MMU in this case) 
and roughly in the numeric order by register ID.  So that'll be 
immediately before stuff for PageMask.

 Thanks for your patience and sorry to be a pain, but this file has had a 
tendency to become a mess.  Maybe we need to put a note explaining the 
rules at the top.

  Maciej
