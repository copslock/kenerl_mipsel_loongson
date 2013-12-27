Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Dec 2013 20:13:38 +0100 (CET)
Received: from blu0-omc4-s14.blu0.hotmail.com ([65.55.111.153]:40839 "EHLO
        blu0-omc4-s14.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6819780Ab3L0TNcvTlbb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Dec 2013 20:13:32 +0100
Received: from BLU0-SMTP17 ([65.55.111.137]) by blu0-omc4-s14.blu0.hotmail.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 27 Dec 2013 11:13:26 -0800
X-TMN:  [6gVrQ6aWam5T4sMNNMLAwsGYhsw8AsS4]
X-Originating-Email: [dave.anglin@bell.net]
Message-ID: <BLU0-SMTP17D26551261DF285A7E6F497CD0@phx.gbl>
Received: from [192.168.2.10] ([69.158.171.205]) by BLU0-SMTP17.phx.gbl over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 27 Dec 2013 11:13:25 -0800
From:   John David Anglin <dave.anglin@bell.net>
To:     Matthew Wilcox <willy@linux.intel.com>
In-Reply-To: <20131227180018.GC4945@linux.intel.com>
Subject: Re: [PATCH] remap_file_pages needs to check for cache coherency
References: <20131227180018.GC4945@linux.intel.com>
Content-Type: text/plain; charset="US-ASCII"; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0 (Apple Message framework v936)
Date:   Fri, 27 Dec 2013 14:13:16 -0500
CC:     linux-mm@kvack.org, "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-mips@linux-mips.org
X-Mailer: Apple Mail (2.936)
X-OriginalArrivalTime: 27 Dec 2013 19:13:25.0093 (UTC) FILETIME=[B7552950:01CF0337]
Return-Path: <dave.anglin@bell.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38808
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dave.anglin@bell.net
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

On 27-Dec-13, at 1:00 PM, Matthew Wilcox wrote:

> +#ifdef __ARCH_FORCE_SHMLBA
> +	/* Is the mapping cache-coherent? */
> +	if ((pgoff ^ linear_page_index(vma, start)) &
> +	    ((SHMLBA-1) >> PAGE_SHIFT))
> +		goto out;
> +#endif


I think this will cause problems on PA-RISC.  The reason is we have an  
additional offset
for mappings.  See get_offset() in sys_parisc.c.

SHMLBA is 4 MB on PA-RISC.  If we limit ourselves to aligned mappings,  
we run out of
memory very quickly.  Even with our current implementation, we fail  
the perl locales test
with locales-all installed.

Dave
--
John David Anglin	dave.anglin@bell.net
