Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Mar 2016 16:09:10 +0100 (CET)
Received: from bes.se.axis.com ([195.60.68.10]:53777 "EHLO bes.se.axis.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008251AbcCDPJH6ZPyU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Mar 2016 16:09:07 +0100
Received: from localhost (localhost [127.0.0.1])
        by bes.se.axis.com (Postfix) with ESMTP id 9EEFE2E23B;
        Fri,  4 Mar 2016 16:09:02 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id ql+jvCFtsAwB; Fri,  4 Mar 2016 16:09:00 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
        by bes.se.axis.com (Postfix) with ESMTP id D27412E240;
        Fri,  4 Mar 2016 16:09:00 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
        by postfix.imss71 (Postfix) with ESMTP id BBBBA1538;
        Fri,  4 Mar 2016 16:09:00 +0100 (CET)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
        by boulder.se.axis.com (Postfix) with ESMTP id B0987833;
        Fri,  4 Mar 2016 16:09:00 +0100 (CET)
Received: from XBOX02.axis.com (xbox02.axis.com [10.0.5.16])
        by seth.se.axis.com (Postfix) with ESMTP id AE35C1046;
        Fri,  4 Mar 2016 16:09:00 +0100 (CET)
Received: from XBOX02.axis.com (10.0.5.16) by XBOX02.axis.com (10.0.5.16) with
 Microsoft SMTP Server (TLS) id 15.0.1156.6; Fri, 4 Mar 2016 16:09:00 +0100
Received: from XBOX02.axis.com ([fe80::50c3:4d2f:4507:7776]) by
 XBOX02.axis.com ([fe80::50c3:4d2f:4507:7776%22]) with mapi id 15.00.1156.000;
 Fri, 4 Mar 2016 16:09:00 +0100
From:   Lars Persson <lars.persson@axis.com>
To:     Paul Burton <paul.burton@imgtec.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] MIPS: Flush dcache for flush_kernel_dcache_page
Thread-Topic: [PATCH 1/4] MIPS: Flush dcache for flush_kernel_dcache_page
Thread-Index: AQHRc2N2P9HTweD4gUC06+JPi1vOcJ9JaMnV
Date:   Fri, 4 Mar 2016 15:09:00 +0000
Message-ID: <B1BD883F-CC3D-4C02-9C5C-350DB487329B@axis.com>
References: <1456799879-14711-1-git-send-email-paul.burton@imgtec.com>,<1456799879-14711-2-git-send-email-paul.burton@imgtec.com>
In-Reply-To: <1456799879-14711-2-git-send-email-paul.burton@imgtec.com>
Accept-Language: en-US
Content-Language: sv-SE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <lars.persson@axis.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52448
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars.persson@axis.com
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



> 1 mars 2016 kl. 03:38 Paul Burton <paul.burton@imgtec.com>:
> 
> The flush_kernel_dcache_page function was previously essentially a nop.
> This is incorrect for MIPS, where if a page has been modified & either
> it aliases or it's executable & the icache doesn't fill from dcache then
> the content needs to be written back from dcache to the next level of
> the cache hierarchy (which is shared with the icache).
> 
> Implement this by simply calling flush_dcache_page, treating this
> kmapped cache flush function (flush_kernel_dcache_page) exactly the same
> as its non-kmapped counterpart (flush_dcache_page).
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> ---
> 
> arch/mips/include/asm/cacheflush.h | 1 +
> 1 file changed, 1 insertion(+)
> 
> diff --git a/arch/mips/include/asm/cacheflush.h b/arch/mips/include/asm/cacheflush.h
> index 723229f..7e9f468 100644
> --- a/arch/mips/include/asm/cacheflush.h
> +++ b/arch/mips/include/asm/cacheflush.h
> @@ -132,6 +132,7 @@ static inline void kunmap_noncoherent(void)
> static inline void flush_kernel_dcache_page(struct page *page)
> {
>    BUG_ON(cpu_has_dc_aliases && PageHighMem(page));
> +    flush_dcache_page(page);

Should we use instead __flush_dcache_page() that flushes immediately for mapped pages ? Steven J Hill's old patch set for highmem had done it like this.

> }
> 
> /*
> -- 
> 2.7.1
> 
