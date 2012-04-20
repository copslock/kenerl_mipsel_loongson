Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Apr 2012 18:50:25 +0200 (CEST)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:40251 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903716Ab2DTQuJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Apr 2012 18:50:09 +0200
Received: by yhjj52 with SMTP id j52so5919224yhj.36
        for <multiple recipients>; Fri, 20 Apr 2012 09:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=7ybbNZ9FPoSKXCcxgV3N05OVN4JQgNS1gcQgFl+hSU0=;
        b=bduHcLDlXIUYlJ1ubhv45EBffyT8Bk5z+KjVfH3uq2nm//BKPE/aH9Da57duts+2FK
         5/w6YUbXyOWAXxsSMN6umIvLV6+nv1aMWFG0oYwzr7ceCWAP6j0MpDNROF2Fwi+gWIW2
         ecd2PULSJ2Z9k8Ys7AdIcrCIiH//YPA2naKRrwBAi80wv7G8ljPonWiJMQ220/qwgNgM
         1h9LLlzG0XlV5aLe7dUXjQUN2lUoli8ZCYyFixomTgoofryPGe9I5Zxy95XOhpyOj7FC
         x1nmxoZS1/SrHshw4+iJ4K1agIgiNTQYoRp4vtnqLFZkxPKkSeZC1YgaQMDOe4FGQgGq
         DeOA==
Received: by 10.60.12.162 with SMTP id z2mr2274532oeb.47.1334940602708;
        Fri, 20 Apr 2012 09:50:02 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id qa9sm1061517obc.17.2012.04.20.09.50.00
        (version=SSLv3 cipher=OTHER);
        Fri, 20 Apr 2012 09:50:01 -0700 (PDT)
Message-ID: <4F9193B7.7060706@gmail.com>
Date:   Fri, 20 Apr 2012 09:49:59 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Sam Ravnborg <sam@ravnborg.org>
CC:     David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Marek <mmarek@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 1/5] scripts: Add sortextable to sort the kernel's
 exception table.
References: <1334872799-14589-1-git-send-email-ddaney.cavm@gmail.com> <1334872799-14589-2-git-send-email-ddaney.cavm@gmail.com> <20120420145920.GA2891@merkur.ravnborg.org>
In-Reply-To: <20120420145920.GA2891@merkur.ravnborg.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 32994
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 04/20/2012 07:59 AM, Sam Ravnborg wrote:
> On Thu, Apr 19, 2012 at 02:59:55PM -0700, David Daney wrote:
>> From: David Daney<david.daney@cavium.com>
>>
>> Using this build-time sort saves time booting as we don't have to burn
>> cycles sorting the exception table.
>>
>> Signed-off-by: David Daney<david.daney@cavium.com>
>> ---
>>   scripts/.gitignore    |    1 +
>>   scripts/Makefile      |    1 +
>>   scripts/sortextable.c |  273 +++++++++++++++++++++++++++++++++++++++++++++++++
>>   scripts/sortextable.h |  168 ++++++++++++++++++++++++++++++
>
> If there is only a single file including the .h file - then there is no gain.
> Just fold it into the .c file.
>

s/single file/single site/, and I am in complete agreement.  However 
this patch doesn't meet that criterion.  In this particular case, there 
is more to the patch than just the diffstat.

David Daney
