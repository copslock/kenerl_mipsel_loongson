Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jan 2016 18:52:32 +0100 (CET)
Received: from youngberry.canonical.com ([91.189.89.112]:41288 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009981AbcAORwa0IRMJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Jan 2016 18:52:30 +0100
Received: from av-217-129-142-138.netvisao.pt ([217.129.142.138] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <luis.henriques@canonical.com>)
        id 1aK8Xz-0007TV-OW; Fri, 15 Jan 2016 17:52:27 +0000
Date:   Fri, 15 Jan 2016 17:52:26 +0000
From:   Luis Henriques <luis.henriques@canonical.com>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     stable@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Leonid Yegoshin <leonid.yegoshin@imgtec.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH backport v3.15..v4.1 0/2] MIPS: uaccess: EVA fixes
Message-ID: <20160115175226.GA1980@charon.olymp>
References: <1451939344-21557-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1451939344-21557-1-git-send-email-james.hogan@imgtec.com>
Return-Path: <luis.henriques@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51153
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: luis.henriques@canonical.com
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

On Mon, Jan 04, 2016 at 08:29:02PM +0000, James Hogan wrote:
> These two backports fix bugs in the MIPS uaccess functions for MIPS
> Enhanced Virtual Addressing (EVA), which were added in v3.15.
> 
> The upstream commits don't work directly when applied to kernels older
> than v4.2 where the eva_kernel_access() function was introduced, so we
> instead use segment_eq() directly, along with config_enabled(CONFIG_EVA)
> where necessary to avoid module symbol errors.
>

Thanks James, I'll queue both for the next 3.16 kernel.

Cheers,
--
Luís


> James Hogan (2):
>   MIPS: uaccess: Take EVA into account in __copy_from_user()
>   MIPS: uaccess: Take EVA into account in [__]clear_user
> 
>  arch/mips/include/asm/uaccess.h | 44 +++++++++++++++++++++++++++++------------
>  arch/mips/kernel/mips_ksyms.c   |  2 ++
>  arch/mips/lib/memset.S          |  2 ++
>  3 files changed, 35 insertions(+), 13 deletions(-)
> 
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Markos Chandras <markos.chandras@imgtec.com>
> Cc: Paul Burton <paul.burton@imgtec.com>
> Cc: Leonid Yegoshin <leonid.yegoshin@imgtec.com>
> Cc: linux-mips@linux-mips.org
> -- 
> 2.4.10
> 
> --
> To unsubscribe from this list: send the line "unsubscribe stable" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
