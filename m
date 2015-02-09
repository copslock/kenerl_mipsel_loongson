Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Feb 2015 15:12:30 +0100 (CET)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27013034AbbBIOM2hKG2C (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Feb 2015 15:12:28 +0100
Date:   Mon, 9 Feb 2015 14:12:28 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Daniel Sanders <daniel.sanders@imgtec.com>
cc:     Toma Tabacu <toma.tabacu@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] MIPS: LLVMLinux: Fix an 'inline asm input/output
 type mismatch' error.
In-Reply-To: <1423481632-27903-1-git-send-email-daniel.sanders@imgtec.com>
Message-ID: <alpine.LFD.2.11.1502091410250.22715@eddie.linux-mips.org>
References: <1422970639-7922-4-git-send-email-daniel.sanders@imgtec.com> <1423481632-27903-1-git-send-email-daniel.sanders@imgtec.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45780
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

On Mon, 9 Feb 2015, Daniel Sanders wrote:

> --- a/arch/mips/include/asm/checksum.h
> +++ b/arch/mips/include/asm/checksum.h
> @@ -228,6 +228,8 @@ static __inline__ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
>  					  __u32 len, unsigned short proto,
>  					  __wsum sum)
>  {
> +        __wsum tmp;

 Formatting issue here, use a tab.

  Maciej
