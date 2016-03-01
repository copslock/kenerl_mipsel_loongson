Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Mar 2016 18:13:39 +0100 (CET)
Received: from mail-bn1on0088.outbound.protection.outlook.com ([157.56.110.88]:19088
        "EHLO na01-bn1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27011743AbcCARNhZcIn2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 1 Mar 2016 18:13:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-caviumnetworks-com;
 h=From:To:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=edqmgMo2NolaPBEZoS7cRIiCg+RoZpXs3Rxen0sVN2M=;
 b=AeTXKntj7h476HxZJA0szWY5HnjgIBewX9Q6byJz7gNkgSXvJpIXOzxJm8zCkPKaAikWTcLizy48fdCTWHZPmr+98+AaRSOKpC1EPQBkQk7gB2cEdH2ipch2ygj6qelj+hgV8OgJhIAxA3AhdBRXpjYLCJwkBG70dLYwO5PUNtA=
Authentication-Results: imgtec.com; dkim=none (message not signed)
 header.d=none;imgtec.com; dmarc=none action=none
 header.from=caviumnetworks.com;
Received: from dl.caveonetworks.com (64.2.3.194) by
 SN1PR07MB2144.namprd07.prod.outlook.com (10.164.47.14) with Microsoft SMTP
 Server (TLS) id 15.1.415.20; Tue, 1 Mar 2016 17:13:27 +0000
Message-ID: <56D5CDB3.80407@caviumnetworks.com>
Date:   Tue, 1 Mar 2016 09:13:23 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>, Lars Persson <lars.persson@axis.com>, "stable
 # v4 . 1+" <stable@vger.kernel.org>, "Steven J. Hill"
        <Steven.Hill@imgtec.com>, David Daney <david.daney@cavium.com>, Huacai Chen
        <chenhc@lemote.com>, Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>,
        <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
        Jerome Marchand <jmarchan@redhat.com>, "Kirill A. Shutemov"
        <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 4/4] MIPS: Sync icache & dcache in set_pte_at
References: <1456799879-14711-1-git-send-email-paul.burton@imgtec.com> <1456799879-14711-5-git-send-email-paul.burton@imgtec.com>
In-Reply-To: <1456799879-14711-5-git-send-email-paul.burton@imgtec.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.194]
X-ClientProxiedBy: BLUPR07CA0049.namprd07.prod.outlook.com (10.255.223.162) To
 SN1PR07MB2144.namprd07.prod.outlook.com (25.164.47.14)
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2144;2:qnclfcCHoQL3W6sfUq+G6SjHY9590pZqsiExT9msFHyQySsGKw3Wjx07wUuldjzim5wd0D9qyt8Da615ozlR1sbxkxIEFfxknNnEtX8bAEOTS3TgKHvwopd2qpDJZeGSD7WSd7bUexJZnDsObsgaUw==;3:pjpu/vaG0Rwf+vMIuUHeI9zQj5l9c1Di5HaWYDmmouclhSaLQgfYDQqcpeIWchhS5VwjwpTqWclOpqzfxozb9zcXxnorUxViYFBjQKR25VNQw0y6zwKjTJpSZxpmz1W4;25:3Kbyp9P1iGkvIfnIowuX6rcWGw8SLbvINduRWHfpLKGJHNp8pnBnAZEDAaZuURGi+rH6RNNRNzEmW7B1LxYPQl1OJNeJ0sMX3FGGhPQbLqszC7YK5mURBDzn/suU1fqvvUH96QwsEKzm6Cg+Jlx5hRBCRv5sJhAWev+6D22cs8PyARUmN34sCKHJID2zBNNOcxlfmNHAEX+VggebTI3+dzL0J6nlvOCHDhMZXPpkDPltpVAnEozVsxtCKAeMOcrZhkOkRen7WgFWSu0yb46DS6rjBUoyuXSEHfcKkRxuH7ZetHARqlyvzEeiR1+H/w+wf26am8cxew2szSH/+chNTA==
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:SN1PR07MB2144;
X-MS-Office365-Filtering-Correlation-Id: 72872848-ad45-4cf4-bcb3-08d341f4cf43
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2144;20:QYZdtDepiarD3QOPXj+Jvd0cVVUxK/hYegIaYp/ztR85zcDCQomj4z43Cx3b8PGJqn5BEa688QNjugVqxzqXtX8kXCYXcZCsJMVyBWHkP5stGF5YenqCO7LcyIY0nIc6Al5lwk2cjKBu8QHetGvzdm4iQj5MPDuPVMQHjdRwIFduOgtd5ChX1OCJseSJx3MAcrZiMeL/JgEAZ+0QLHmEid7XRdbN7U9O9meS5LzsRowDHT0vQXFeKBA2TWflrJo6WKVrvTeFNi2PpZL5oVWvu+xHxeDNb+Yf5nBX9D7QskHg4B54PTrBM8fAv2G8NjL0A90w+QWByejoum6NNddR4QrKixS/O8/uQ63yuxHOJGtA0QczkbIvWmifAixohbZ7rUZxmCjkRU5CKLWih+I0dTUBRF91YYn5/sTYVjAurFJ+Iy9i/meYkovSc1a4faICrXl5ufFiJfcn8AwmID76kM4S5kAFG+292/ETHZ8k2SMesuzfXjSyWuBrNcHAKothvQ9uPNGGlxpAKiy8U/rWXTbR/UgFbV25rrhyKy7c2tVzjyZawPnQS8JqXR6E1tZnepqOnpOpQYvVQdeVmBHwdLgMvMqPKRSPRdxu4dst8fU=
X-Microsoft-Antispam-PRVS: <SN1PR07MB2144865F5F50EE0D2564C51E9ABB0@SN1PR07MB2144.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(2401047)(5005006)(8121501046)(3002001)(10201501046);SRVR:SN1PR07MB2144;BCL:0;PCL:0;RULEID:;SRVR:SN1PR07MB2144;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2144;4:+jS8pjkcqY+gRqGIKtXBmN9y51ZZmo8jWc9MHzw7vbbOuG5YJdJLzoBp09nMPwH8oUe3YMZau01HIiqhhmTbchcUE3vWXGZdAoVqzyzd1mMRLemhGEHEr0amUlfci0JSeyygbTR58h1vTWJbdWkQu+C7WIza8unguXqgaPggxi+Vs+tYiy1Aw3gV51NBqAP61kXNq+KWPpnVyae+h9hDEWhra3IluhMxwchZG1uOot+v2HsMYLXSycKKHp30p1/NUdVTNjb8ZvJQ5BxSbrLKzloMvvaUkE6IYi0J3oImRwelNwZgrL946xEvW/qnl1TyAhpZNZv/AI9aXb0lFUpLBxKeH2w3M4xw4p18JjdCbckOZWlK2BRg16AOHwT6Z8lD
X-Forefront-PRVS: 086831DFB4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(24454002)(377454003)(479174004)(50466002)(4001350100001)(230700001)(92566002)(66066001)(23756003)(122386002)(83506001)(65956001)(65806001)(53416004)(47776003)(5001770100001)(42186005)(5001960100004)(81156009)(40100003)(36756003)(77096005)(33656002)(4326007)(64126003)(2950100001)(5008740100001)(1096002)(586003)(2906002)(189998001)(54356999)(50986999)(6116002)(3846002)(65816999)(76176999)(87976001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR07MB2144;H:dl.caveonetworks.com;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?iso-8859-1?Q?1;SN1PR07MB2144;23:8icIsRoUSLBN3Z86WNcleDXr8+x5J4OMzJF0k97?=
 =?iso-8859-1?Q?Q6eV0em+SozHNVXLDdo8HTUdzeQbVgndwC5YRpUrj+Seq0Lf5AZ0jj4aQ8?=
 =?iso-8859-1?Q?cjbJKoY5fNGUiUR3sMJRuFMVDBRvUdmpm0/HiFdmlYI+WgueFLAEryhIXg?=
 =?iso-8859-1?Q?oNtKxYjBsCPppWTQmIPZnFFURaUFM+rPAnMVwlR0HzFSnxCB48DgGbkOTV?=
 =?iso-8859-1?Q?0JVm9OjCH2yXWNhVxt87VxFFX6FgJlL6PckN0NmsHKcY8mMM2SARVXRNhF?=
 =?iso-8859-1?Q?9BARWg+/7L4S4XsoX3N8VTEX1E8KtyQvdgpdR2sB/e/5UyFP2C88EhpuBu?=
 =?iso-8859-1?Q?Xk51G+gtjKnboWdb98Hs/t7x1G2BHsug8TPjao0eKePO2mAMAWhvFAyR+8?=
 =?iso-8859-1?Q?3yexYeyDR7lKpWnmxtgxvOa3+lMC3Z0HlOHG0h0kJ4C/tAvpA6RQVHtW21?=
 =?iso-8859-1?Q?HlEDrQgXPoBZW4zDkEWFZ4/hLe+Fk+EjySc3p8ZGa8Oj1dEQmDvO1PnrPY?=
 =?iso-8859-1?Q?YwnhuI9GyAvZkVOiB7bidykTh2Bv2z6KnIUMROx1TKZzJTDdkTQ66T/9+h?=
 =?iso-8859-1?Q?OYtWYtltv9rDXh8RCAt7RcIS2wl1syXlj5DKkkvL5Z1FVAeWEEUSr1MOd9?=
 =?iso-8859-1?Q?nSecQQg0TKqFrKOqC6/bfh8qCg53YvY6dUCqH6Dxj5uJCwwi7b1JKXxoEO?=
 =?iso-8859-1?Q?ZFG98iRjD0xsa0+/Rwo9aIPGuoTiwKxL5m5uSlmn4aXTOBRKI1T451njzy?=
 =?iso-8859-1?Q?x+puAwt3X+YAePViW6qvfowX8ZzbDLq8X7wvV2RS6xWTntydMImi5B/Lhw?=
 =?iso-8859-1?Q?Mgj6VtsHO5wa6Nh/YzLJlktyxo/Ci4db4nRrNOcLJ8Ra8sGtrUgq+fKH/9?=
 =?iso-8859-1?Q?GStl4C1VLLci9Wtt3vpuTVkGab4+LRfPh2DeNEud+MR6Mc0o73eGn8qEwh?=
 =?iso-8859-1?Q?mxjqxxDHST4USXkj3MRYeLk8VTLkI0lNkOQ7VvIDzuKLNKTgXCqgzj23xF?=
 =?iso-8859-1?Q?fq0VLaFaPZghjSFM3ICWnR1S7abjT/TGJzkmLv4z7C1BvIklpzesfUNEmf?=
 =?iso-8859-1?Q?wVhsY1FY+cy9Rvy89SP5HDc3esDxYIAJLUSyM5cgixFRtGM7OU34QtM7G2?=
 =?iso-8859-1?Q?+GQa9?=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2144;5:fqx4QhMqTXlJIzK1y9PT+Q+uYoEGZlHzBLDpZzQU/YnjVbQOMwSmwuvXy7wRO6GYbWaMzMuFiiDGOGhL8DPGat0Sr60e0BTtkrZobaYAYcHJ1x5fuMBA1XSLtszaPOy37VTf8on6xdUxBZq139zxTw==;24:I/wFyRfBdSD0A3QtIc/v1krtGlyZAGlEavADF7n+2DqjTgf2SthU9Zy+kC8Vx/LYGmYt3yv2u3cFhpl3HbqDDlYp3vpydcWsVnb40kh0EKk=
SpamDiagnosticOutput: 1:23
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2016 17:13:27.8269 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR07MB2144
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52385
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
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

On 02/29/2016 06:37 PM, Paul Burton wrote:
[...]
> @@ -234,6 +237,22 @@ static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *pt
>   }
>   #endif
>
> +static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
> +			      pte_t *ptep, pte_t pteval)
> +{
> +	extern void __update_cache(unsigned long address, pte_t pte);
> +
> +	if (!pte_present(pteval))
> +		goto cache_sync_done;
> +
> +	if (pte_present(*ptep) && (pte_pfn(*ptep) == pte_pfn(pteval)))
> +		goto cache_sync_done;
> +
> +	__update_cache(addr, pteval);
> +cache_sync_done:
> +	set_pte(ptep, pteval);
> +}
> +

This seems crazy.  I don't think any other architecture does this type 
of work in set_pte_at().

Can you look into finding a better way?

What if you ...


>   /*
>    * (pmds are folded into puds so this doesn't get actually called,
>    * but the define is needed for a generic inline function.)
> @@ -430,15 +449,12 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
>
>   extern void __update_tlb(struct vm_area_struct *vma, unsigned long address,
>   	pte_t pte);
> -extern void __update_cache(struct vm_area_struct *vma, unsigned long address,
> -	pte_t pte);
>
>   static inline void update_mmu_cache(struct vm_area_struct *vma,
>   	unsigned long address, pte_t *ptep)
>   {
>   	pte_t pte = *ptep;
>   	__update_tlb(vma, address, pte);
> -	__update_cache(vma, address, pte);

... Reversed the order of these two operations?

>   }
>
>   static inline void update_mmu_cache_pmd(struct vm_area_struct *vma,
> diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
> index 8befa55..bf04c6c 100644
> --- a/arch/mips/mm/cache.c
> +++ b/arch/mips/mm/cache.c
> @@ -125,30 +125,17 @@ void __flush_anon_page(struct page *page, unsigned long vmaddr)
>
>   EXPORT_SYMBOL(__flush_anon_page);
>
> -void __flush_icache_page(struct vm_area_struct *vma, struct page *page)
> -{
> -	unsigned long addr;
> -
> -	if (PageHighMem(page))
> -		return;
> -
> -	addr = (unsigned long) page_address(page);
> -	flush_data_cache_page(addr);
> -}
> -EXPORT_SYMBOL_GPL(__flush_icache_page);
> -
> -void __update_cache(struct vm_area_struct *vma, unsigned long address,
> -	pte_t pte)
> +void __update_cache(unsigned long address, pte_t pte)
>   {
>   	struct page *page;
>   	unsigned long pfn, addr;
> -	int exec = (vma->vm_flags & VM_EXEC) && !cpu_has_ic_fills_f_dc;
> +	int exec = !pte_no_exec(pte) && !cpu_has_ic_fills_f_dc;
>
>   	pfn = pte_pfn(pte);
>   	if (unlikely(!pfn_valid(pfn)))
>   		return;
>   	page = pfn_to_page(pfn);
> -	if (page_mapping(page) && Page_dcache_dirty(page)) {
> +	if (Page_dcache_dirty(page)) {
>   		if (PageHighMem(page))
>   			addr = (unsigned long)kmap_atomic(page);
>   		else
>
