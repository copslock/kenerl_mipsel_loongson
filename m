Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Mar 2016 22:21:33 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:59888 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008319AbcCDVVcKAMcG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Mar 2016 22:21:32 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 71FB2DFDA18B0;
        Fri,  4 Mar 2016 21:21:22 +0000 (GMT)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.266.1; Fri, 4 Mar
 2016 21:21:26 +0000
Received: from [10.20.3.92] (10.20.3.92) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.266.1; Fri, 4 Mar 2016
 13:21:22 -0800
Message-ID: <56D9FC52.7020803@imgtec.com>
Date:   Fri, 4 Mar 2016 13:21:22 -0800
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Paul Burton <paul.burton@imgtec.com>
CC:     <linux-mips@linux-mips.org>, Lars Persson <lars.persson@axis.com>,
        "stable # v4 . 1+" <stable@vger.kernel.org>, "Steven J. Hill"
        <Steven.Hill@imgtec.com>, David Daney <david.daney@cavium.com>, Huacai Chen
        <chenhc@lemote.com>, Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>,
        <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
        Jerome Marchand <jmarchan@redhat.com>, "Kirill A. Shutemov"
        <kirill.shutemov@linux.intel.com>, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [4/4] MIPS: Sync icache & dcache in set_pte_at
References: <1456799879-14711-5-git-send-email-paul.burton@imgtec.com> <56D7A987.5040602@imgtec.com> <20160304103714.GA5576@NP-P-BURTON> <56D9F78E.6090303@imgtec.com>
In-Reply-To: <56D9F78E.6090303@imgtec.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.20.3.92]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52456
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Leonid.Yegoshin@imgtec.com
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

Correct:

On 03/04/2016 01:01 PM, Leonid Yegoshin wrote:
>
> I suspect that your problem with UBIFS is because any DMA-ed code page 
> should be flushed from DCache during page fault in flush_icache_page.
I suspect that your problem with UBIFS is because any non-DMA-ed code...

Sorry for mistype.

- Leonid.
