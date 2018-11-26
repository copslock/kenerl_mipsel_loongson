Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Nov 2018 19:22:59 +0100 (CET)
Received: from foss.arm.com ([217.140.101.70]:33456 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993840AbeKZSWynSBOw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 26 Nov 2018 19:22:54 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A55731A25;
        Mon, 26 Nov 2018 10:22:52 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA3FD3F5AF;
        Mon, 26 Nov 2018 10:22:48 -0800 (PST)
Subject: Re: [PATCH v2 01/20] perf/doc: update design.txt for
 exclude_{host|guest} flags
To:     Andrew Murray <andrew.murray@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-s390@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
References: <1543230756-15319-1-git-send-email-andrew.murray@arm.com>
 <1543230756-15319-2-git-send-email-andrew.murray@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <b5ba3edb-bc2a-225b-5a87-dd144104cabb@arm.com>
Date:   Mon, 26 Nov 2018 18:22:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1543230756-15319-2-git-send-email-andrew.murray@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <suzuki.poulose@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67513
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: suzuki.poulose@arm.com
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

Hi Andrew,

On 26/11/2018 11:12, Andrew Murray wrote:
> Update design.txt to reflect the presence of the exclude_host
> and exclude_guest perf flags.
> 
> Signed-off-by: Andrew Murray <andrew.murray@arm.com>

Thanks a lot for adding this !

> ---
>   tools/perf/design.txt | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/tools/perf/design.txt b/tools/perf/design.txt
> index a28dca2..5b2b23b 100644
> --- a/tools/perf/design.txt
> +++ b/tools/perf/design.txt
> @@ -222,6 +222,10 @@ The 'exclude_user', 'exclude_kernel' and 'exclude_hv' bits provide a
>   way to request that counting of events be restricted to times when the
>   CPU is in user, kernel and/or hypervisor mode.
>   
> +Furthermore the 'exclude_host' and 'exclude_guest' bits provide a way
> +to request counting of events restricted to guest and host contexts when
> +using KVM virtualisation.

minor nit: could we generalise this to :

"using Linux as the hypervisor".

Otherwise, looks good to me.

Cheers
Suzuki
