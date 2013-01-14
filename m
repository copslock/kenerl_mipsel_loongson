Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jan 2013 23:03:49 +0100 (CET)
Received: from mail-da0-f54.google.com ([209.85.210.54]:38292 "EHLO
        mail-da0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816553Ab3ANWDsh4ltB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Jan 2013 23:03:48 +0100
Received: by mail-da0-f54.google.com with SMTP id n2so1998542dad.13
        for <linux-mips@linux-mips.org>; Mon, 14 Jan 2013 14:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=a0TlSNYfbB1r95RlGIlRUMYS4zVt3LagTgk+bXSBRpg=;
        b=yz7MMBJ/BejBph7urYy6qaJcicEjehQZHbQDeBL233vRHXXlURJ/e9xmceCtqPZJdv
         7I6ngQnfQQoLV42HMvWGN2DBUmnhHA6vBy7FK2yGFpA++ZfYmdGgwGUYeET14f4NVuyM
         Qtk1Yu16tXzgqqw+gFDZGwEtivSQcMqPe1NDk6L0ZUHg62A/2dzob/ahm46lpCV/0ySe
         ngOisDS+VoWgZx6jLRJdXFHhCBbxEdeoWB/qYAQfARBB4MZEFOPPvRzUk0PTUQtmhY5r
         pyrepqIK92O0GEFdGPzI1nVTV9Pjp/tq7QteBwuvE4spP44MrlEN57+rbYcYshUakKe3
         sSpg==
X-Received: by 10.68.238.8 with SMTP id vg8mr259956102pbc.26.1358201021634;
        Mon, 14 Jan 2013 14:03:41 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id im5sm7786845pbc.55.2013.01.14.14.03.40
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 14 Jan 2013 14:03:40 -0800 (PST)
Message-ID: <50F480BB.6070105@gmail.com>
Date:   Mon, 14 Jan 2013 14:03:39 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
MIME-Version: 1.0
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-mips@linux-mips.org, Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: 3.8-rc1 build failure with MIPS/SPARSEMEM
References: <20121222122757.GB6847@blackmetal.musicnaut.iki.fi> <20121226003434.GA27760@otc-wbsnb-06> <20121227121607.GA7097@blackmetal.musicnaut.iki.fi> <20121230103850.GA5424@otc-wbsnb-06> <20130114151641.GA17996@otc-wbsnb-06>
In-Reply-To: <20130114151641.GA17996@otc-wbsnb-06>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-archive-position: 35433
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 01/14/2013 07:16 AM, Kirill A. Shutemov wrote:
> On Sun, Dec 30, 2012 at 12:38:50PM +0200, Kirill A. Shutemov wrote:
>> On Thu, Dec 27, 2012 at 02:16:07PM +0200, Aaro Koskinen wrote:
>>> Hi,
>>>
>>> On Wed, Dec 26, 2012 at 02:34:35AM +0200, Kirill A. Shutemov wrote:
>>>> On MIPS if SPARSEMEM is enabled we've got this:
>>>>
>>>> In file included from /home/kas/git/public/linux/arch/mips/include/asm/pgtable.h:552,
>>>>                   from include/linux/mm.h:44,
>>>>                   from arch/mips/kernel/asm-offsets.c:14:
>>>> include/asm-generic/pgtable.h: In function ‘my_zero_pfn’:
>>>> include/asm-generic/pgtable.h:466: error: implicit declaration of function ‘page_to_section’
>>>> In file included from arch/mips/kernel/asm-offsets.c:14:
>>>> include/linux/mm.h: At top level:
>>>> include/linux/mm.h:738: error: conflicting types for ‘page_to_section’
>>>> include/asm-generic/pgtable.h:466: note: previous implicit declaration of ‘page_to_section’ was here
>>>>
>>>> Due header files inter-dependencies, the only way I see to fix it is
>>>> convert my_zero_pfn() for __HAVE_COLOR_ZERO_PAGE to macros.
>>>>
>>>> Signed-off-by: Kirill A. Shutemov <kirill@shutemov.name>
>>>
>>> Thanks, this works.
>>>
>>> Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
>>
>> Andrew, could you take the patch?

I found the same problem and arrived at an equivalent solution.

Acked-by: David Daney <david.daney@cavium.com>

>
> ping?
>
