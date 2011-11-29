Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Nov 2011 19:04:00 +0100 (CET)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:36891 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1905688Ab1K2SDy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Nov 2011 19:03:54 +0100
Received: by ywp18 with SMTP id 18so5471241ywp.36
        for <multiple recipients>; Tue, 29 Nov 2011 10:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=ZE2IVaCuqBJGT9mqBJl3NnoOo3mpVoPFLK6GvTOI4/8=;
        b=aBXQrL5wVdFMkVmbmMpnjguMCvHSr8EY2QetOmj4tB16m4kahhmkY+lw/4lgPHsgXD
         ICXK5r3rid2fiWALXawCWnYKQG79GrN8yh17aKbyGcpTGa2jRUVpzOCnGAlZSWgVq86J
         G90+U6y65swU8/RMk9KVhC8/egAWBTTLcxRsA=
Received: by 10.50.94.229 with SMTP id df5mr56926653igb.27.1322589827734;
        Tue, 29 Nov 2011 10:03:47 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id el2sm62009624ibb.10.2011.11.29.10.03.46
        (version=SSLv3 cipher=OTHER);
        Tue, 29 Nov 2011 10:03:46 -0800 (PST)
Message-ID: <4ED51E81.3040304@gmail.com>
Date:   Tue, 29 Nov 2011 10:03:45 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Rik van Riel <riel@redhat.com>
CC:     Andrea Arcangeli <aarcange@redhat.com>,
        Hillf Danton <dhillf@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 3/3] MIPS: changes in VM core for adding THP
References: <CAJd=RBB2gSCaJSsFfJXBg2zmgzNjXPAn8OakAZACNG0mv2D7nQ@mail.gmail.com> <20111126173151.GF8397@redhat.com> <4ED51B48.6020202@redhat.com>
In-Reply-To: <4ED51B48.6020202@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 32013
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 24323

On 11/29/2011 09:50 AM, Rik van Riel wrote:
> On 11/26/2011 12:31 PM, Andrea Arcangeli wrote:
>> On Sat, Nov 26, 2011 at 10:43:15PM +0800, Hillf Danton wrote:
>>> In VM core, window is opened for MIPS to use THP.
>>>
>>> And two simple helper functions are added to easy MIPS a bit.
>>>
>>> Signed-off-by: Hillf Danton<dhillf@gmail.com>
>>> ---
>>>
>>> --- a/mm/Kconfig Thu Nov 24 21:12:00 2011
>>> +++ b/mm/Kconfig Sat Nov 26 22:12:56 2011
>>> @@ -307,7 +307,7 @@ config NOMMU_INITIAL_TRIM_EXCESS
>>>
>>> config TRANSPARENT_HUGEPAGE
>>> bool "Transparent Hugepage Support"
>>> - depends on X86&& MMU
>>> + depends on MMU
>>> select COMPACTION
>>> help
>>> Transparent Hugepages allows the kernel to use huge pages and
>>
>> Then the build will break for all archs if they enable it, better to
>> limit the option to those archs that supports it.
>
> Would it be an idea to define ARCH_HAVE_HUGEPAGE in the
> arch specific Kconfig file and test against that in
> mm/Kconfig ?
>

I think so, but it would probably be spelled ARCH_HAVE_TRANSPARENT_HUGEPAGE

The practice of putting 'depends on X86' in archecture independent 
Kconfigs should really be discouraged.  It has a real feel of hackyness 
to it.

David Daney
