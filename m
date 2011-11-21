Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Nov 2011 19:26:00 +0100 (CET)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:61814 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903805Ab1KUSZ5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 Nov 2011 19:25:57 +0100
Received: by ghbg15 with SMTP id g15so3594966ghb.36
        for <multiple recipients>; Mon, 21 Nov 2011 10:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=tNTbazuYwIVS2dOw7ZwZwBJL51hHr1pg7RKOXQP4uk0=;
        b=a2A0OmIkh+eQ+lnbYzHP5r8WOUGKEzDPMrfHn4hHOpMNZ5lUZCJ3bsEITLxPX1Is3Y
         lwN2IWhsvibvglnuN2c3kKFDiK9Y76MdQMJIWKFJYH4GWXeeeG7Gq0C7uTWChuMJVDet
         4+HZXM9mHV14pcVjTl749XGJu4Ltv5LKePAxs=
Received: by 10.236.176.162 with SMTP id b22mr21314775yhm.78.1321899950850;
        Mon, 21 Nov 2011 10:25:50 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id l19sm31464255anc.14.2011.11.21.10.25.47
        (version=SSLv3 cipher=OTHER);
        Mon, 21 Nov 2011 10:25:48 -0800 (PST)
Message-ID: <4ECA97A0.3090005@gmail.com>
Date:   Mon, 21 Nov 2011 10:25:36 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Mike Frysinger <vapier@gentoo.org>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-embedded@vger.kernel.org, x86@kernel.org,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH RFC 1/5] scripts: Add sortextable to sort the kernel's
 exception table.
References: <1321645068-20475-1-git-send-email-ddaney.cavm@gmail.com> <1321645068-20475-2-git-send-email-ddaney.cavm@gmail.com> <201111201822.13614.vapier@gentoo.org>
In-Reply-To: <201111201822.13614.vapier@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 31892
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17611

On 11/20/2011 03:22 PM, Mike Frysinger wrote:
> On Friday 18 November 2011 14:37:44 David Daney wrote:
>> --- /dev/null
>> +++ b/scripts/sortextable.c
>>
>> +/*
>> + * sortextable.c: Sort the kernel's exception table
>> + *
>> + * Copyright 2011 Cavium, Inc.
>> + *
>> + * Based on code taken from recortmcount.c which is:
>
> seems like it'd be nice if the duplicate helper funcs were placed in a common
> header file rather than copying&  pasting between them.
>

Yes, I may try to factor out some common code if we decide to move 
forward with the patch set.


>> +	switch (w2(ehdr->e_machine)) {
>> +	default:
>> +		fprintf(stderr, "unrecognized e_machine %d %s\n",
>> +			w2(ehdr->e_machine), fname);
>> +		fail_file();
>> +		break;
>> +	case EM_386:
>> +	case EM_MIPS:
>> +	case EM_X86_64:
>> +		break;
>> +	}  /* end switch */
>
> unlike recordmcount, this file doesn't do anything arch specific.  so let's just
> delete this and be done.

Not really true at this point.  We don't know the size or layout of the 
architecture specific exception table entries, likewise for 
CONFIG_ARCH_HAS_SORT_EXTABLE, we don't even know how to do the comparison.

I was trying to be a little conservative and only apply the build time 
sort to configurations that I could test.

David Daney
