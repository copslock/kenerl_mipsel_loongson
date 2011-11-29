Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Nov 2011 18:50:20 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:64650 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1905688Ab1K2RuL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 29 Nov 2011 18:50:11 +0100
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id pATHo5JS027998
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Tue, 29 Nov 2011 12:50:05 -0500
Received: from annuminas.surriel.com (ovpn-113-48.phx2.redhat.com [10.3.113.48])
        by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id pATHo1Xh005603
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 29 Nov 2011 12:50:02 -0500
Message-ID: <4ED51B48.6020202@redhat.com>
Date:   Tue, 29 Nov 2011 12:50:00 -0500
From:   Rik van Riel <riel@redhat.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0) Gecko/20110927 Thunderbird/7.0
MIME-Version: 1.0
To:     Andrea Arcangeli <aarcange@redhat.com>
CC:     Hillf Danton <dhillf@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 3/3] MIPS: changes in VM core for adding THP
References: <CAJd=RBB2gSCaJSsFfJXBg2zmgzNjXPAn8OakAZACNG0mv2D7nQ@mail.gmail.com> <20111126173151.GF8397@redhat.com>
In-Reply-To: <20111126173151.GF8397@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.12
X-archive-position: 32012
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: riel@redhat.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 24305

On 11/26/2011 12:31 PM, Andrea Arcangeli wrote:
> On Sat, Nov 26, 2011 at 10:43:15PM +0800, Hillf Danton wrote:
>> In VM core, window is opened for MIPS to use THP.
>>
>> And two simple helper functions are added to easy MIPS a bit.
>>
>> Signed-off-by: Hillf Danton<dhillf@gmail.com>
>> ---
>>
>> --- a/mm/Kconfig	Thu Nov 24 21:12:00 2011
>> +++ b/mm/Kconfig	Sat Nov 26 22:12:56 2011
>> @@ -307,7 +307,7 @@ config NOMMU_INITIAL_TRIM_EXCESS
>>
>>   config TRANSPARENT_HUGEPAGE
>>   	bool "Transparent Hugepage Support"
>> -	depends on X86&&  MMU
>> +	depends on MMU
>>   	select COMPACTION
>>   	help
>>   	  Transparent Hugepages allows the kernel to use huge pages and
>
> Then the build will break for all archs if they enable it, better to
> limit the option to those archs that supports it.

Would it be an idea to define ARCH_HAVE_HUGEPAGE in the
arch specific Kconfig file and test against that in
mm/Kconfig ?

-- 
All rights reversed
