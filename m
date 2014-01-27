Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2014 20:50:41 +0100 (CET)
Received: from mail-ie0-f172.google.com ([209.85.223.172]:58039 "EHLO
        mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825732AbaA0TujbvVjQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Jan 2014 20:50:39 +0100
Received: by mail-ie0-f172.google.com with SMTP id e14so6494876iej.31
        for <linux-mips@linux-mips.org>; Mon, 27 Jan 2014 11:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=gcGLduVWO1v8BE9KSP+08zC5rSqEStLmf7RwNOE1Xaw=;
        b=V518OztJq3cyGnjnFEvYVzv70gFrxXZa0W6SFaUKg8m5nuh5Ei3gln9UgM9iuzTpag
         e6jlasuzYdiNxa9OJCe/zXh0gKGEOg5sispKT46yYBrhb0C1zqIe2cUoA+hK208y2v9k
         W4c9SMAnZT++WI65V0Q/bf/uQaE7YVJXgqB8mR9Q5Nt6PllEx3DwynnUSYUosYL/Q9Qb
         9J0OpqjhnTVZr3stdWV2Bra6ysDAzDBfL/ombrO6zHWqbbll7iWPzSXtwPp/I3VSB0w/
         UetlgxX8yYZ9lI92bTtZq8839Qpp/XCn+k+UrnVi92IE0stcSkPbRPEz7R55Q4E93YqC
         OJOw==
X-Received: by 10.43.150.18 with SMTP id km18mr6098065icc.43.1390852232774;
        Mon, 27 Jan 2014 11:50:32 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id kt2sm56386270igb.1.2014.01.27.11.50.31
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 27 Jan 2014 11:50:32 -0800 (PST)
Message-ID: <52E6B887.2070605@gmail.com>
Date:   Mon, 27 Jan 2014 11:50:31 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Paul Burton <paul.burton@imgtec.com>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH 15/15] mips: save/restore MSA context around signals
References: <1390836194-26286-1-git-send-email-paul.burton@imgtec.com> <1390836194-26286-16-git-send-email-paul.burton@imgtec.com>
In-Reply-To: <1390836194-26286-16-git-send-email-paul.burton@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39115
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 01/27/2014 07:23 AM, Paul Burton wrote:
> This patch extends sigcontext in order to hold the most significant 64
> bits of each vector register in addition to the MSA control & status
> register. The least significant 64 bits are already saved as the scalar
> FP context. This makes things a little awkward since the least & most
> significant 64 bits of each vector register are not contiguous in
> memory. Thus the copy_u & insert instructions are used to transfer the
> values of the most significant 64 bits via GP registers.
>

Interesting.

This very much touches the userspace ABI of the kernel, so it merits 
very careful consideration.


> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> ---
>   arch/mips/include/asm/sigcontext.h      |   2 +
>   arch/mips/include/uapi/asm/sigcontext.h |   8 ++
>   arch/mips/kernel/asm-offsets.c          |   3 +
>   arch/mips/kernel/r4k_fpu.S              | 213 ++++++++++++++++++++++++++++++++
>   arch/mips/kernel/signal.c               |  71 +++++++++--
>   arch/mips/kernel/signal32.c             |  71 +++++++++--
>   6 files changed, 352 insertions(+), 16 deletions(-)
>
[...]
> diff --git a/arch/mips/include/uapi/asm/sigcontext.h b/arch/mips/include/uapi/asm/sigcontext.h
> index 6c9906f..681c176 100644
> --- a/arch/mips/include/uapi/asm/sigcontext.h
> +++ b/arch/mips/include/uapi/asm/sigcontext.h
> @@ -12,6 +12,10 @@
>   #include <linux/types.h>
>   #include <asm/sgidefs.h>
>
> +/* Bits which may be set in sc_used_math */
> +#define USEDMATH_FP	(1 << 0)
> +#define USEDMATH_MSA	(1 << 1)
> +

How is this going to interact with existing userspace applications?

Is the current behavior to use / manipulate sc_used_math?

How will USEDMATH_MSA interact with existing code?
