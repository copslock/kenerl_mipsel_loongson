Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Dec 2016 00:27:21 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:19644 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993403AbcLHX1M20SjC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Dec 2016 00:27:12 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 2B46A13974C5D;
        Thu,  8 Dec 2016 23:26:58 +0000 (GMT)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (TLS) id 14.3.294.0; Thu, 8 Dec
 2016 23:27:02 +0000
Received: from [10.20.2.61] (10.20.2.61) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.266.1; Thu, 8 Dec 2016
 15:27:00 -0800
Message-ID: <5849EC43.2070802@imgtec.com>
Date:   Thu, 8 Dec 2016 15:26:59 -0800
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Justin Chen <justinpopo6@gmail.com>, <linux-mips@linux-mips.org>
CC:     <bcm-kernel-feedback-list@broadcom.com>, <f.fainelli@gmail.com>,
        "Justin Chen" <justin.chen@broadcom.com>
Subject: Re: [RFC] MIPS: Add cacheinfo support
References: <20161208011626.20885-1-justinpopo6@gmail.com>
In-Reply-To: <20161208011626.20885-1-justinpopo6@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.20.2.61]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55977
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

On 12/07/2016 05:16 PM, Justin Chen wrote:
> From: Justin Chen <justin.chen@broadcom.com>
>
> Add cacheinfo support for MIPS architectures.
>
> Use information from the cpuinfo_mips struct to populate the
> cacheinfo struct. This allows an architecture agnostic approach,
> however this also means if cache information is not properly
> populated within the cpuinfo_mips struct, there is nothing
> we can do. (I.E. c-r3k.c)
>
>

Justin, for architecture agnostic approach of work with caches the 
cpuinfo_mips lacks more information:

1.  L1I-L1D coherency status (is L1I coherent to L1D)
2.  L1D-L2 coherency status (is L1D coherent to L2)
3.  L1I-L2 coherency status (is L1I coherent to L2)
4.  L1I refill from L1D (snoops L1D) or L2 (may require L1D flush)?
5.  L1D cache aliasing disabled by HW
6.  L1I cache aliasing disabled by HW
7.  Barrier existence and it's type between various cache flushes as is 
as between cache flush and final (completed) state.
8.  Cache ownership (current: assumed that sibling CPUs share L1 - may 
be shared_cpu_map?)
9.  Is address cache flush operation global in system or pure local?
10. Is index cache flush operation global in system or pure local?

Without that the proposed cpuinfo_mips struct is basically useless.

Regards,
- Leonid
