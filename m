Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Mar 2012 19:01:18 +0100 (CET)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:65449 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903694Ab2CISBL convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 9 Mar 2012 19:01:11 +0100
Received: by yhjj52 with SMTP id j52so1147529yhj.36
        for <linux-mips@linux-mips.org>; Fri, 09 Mar 2012 10:01:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=qjXetQX6KOfYkEmilxKxnED4S9C7sPVgRJexXz8hjg4=;
        b=KkwfKHjLK3YNsP+oObuo6qMfEX5KnmP5daEpKR+khdz0UgbRxZh/w1LvbaD4SM9Ik+
         rL62tX7+e0p+V2ND05PvLrWO9mJwz8jangBSd7NR2cIC4k6imDCrYpQjnQMcrnF9z/6c
         ioEkRbak6zvL/8DDNE97Ei48ZtAKN01Sgpk7POFru8yUwOxRzpe0cRQeP3ikQLJ7Q7wk
         r46j0TWFP0YID417lOG8AvSzmk/DW/fvv9LohQth6zZhtLhqSFQ/AXECLsbcOxAckZQx
         NRtcivCBa4GBPvWQ/cp2VjReieygfr7E4Al80rfelBsYiswNeV+hOA7s8EccSSaEkcqa
         NlIw==
Received: by 10.60.19.33 with SMTP id b1mr1267013oee.35.1331316065475; Fri, 09
 Mar 2012 10:01:05 -0800 (PST)
MIME-Version: 1.0
Received: by 10.60.18.233 with HTTP; Fri, 9 Mar 2012 10:00:44 -0800 (PST)
In-Reply-To: <4F5A44E5.6090300@cavium.com>
References: <1330543264-18103-1-git-send-email-ddaney.cavm@gmail.com>
 <1330543264-18103-3-git-send-email-ddaney.cavm@gmail.com> <20120309013324.64DF53E0901@localhost>
 <4F5A44E5.6090300@cavium.com>
From:   Grant Likely <grant.likely@secretlab.ca>
Date:   Fri, 9 Mar 2012 11:00:44 -0700
X-Google-Sender-Auth: jg2eqENf0lkFyUH8GIpARVebLUg
Message-ID: <CACxGe6v3wnRdyaWeuBZ1RMQf8KD3dV2btQKrrmPAUgQtym_e_g@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] of: Make of_find_node_by_path() traverse /aliases
 for relative paths.
To:     David Daney <david.daney@cavium.com>
Cc:     David Daney <ddaney.cavm@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "devicetree-discuss@lists.ozlabs.org" 
        <devicetree-discuss@lists.ozlabs.org>,
        Rob Herring <rob.herring@calxeda.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Gm-Message-State: ALoCoQkzyaFTIp+5Q8SMexZP568ijNlD6DtaYXIjPKELKcwEfYXfQfS8+YYYzsx0ww7Xci49HlCO
X-archive-position: 32628
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Fri, Mar 9, 2012 at 10:59 AM, David Daney <david.daney@cavium.com> wrote:
> On 03/08/2012 05:33 PM, Grant Likely wrote:
>>
>> On Wed, 29 Feb 2012 11:21:04 -0800, David Daney<ddaney.cavm@gmail.com>
>>  wrote:
>>>
>>> From: David Daney<david.daney@cavium.com>
>>>
>>> Currently all paths passed to of_find_node_by_path() must begin with a
>>> '/', indicating a full path to the desired node.
>>>
>>> Augment the look-up code so that if a path does *not* begin with '/',
>>> the path is used as the name of an /aliases property.  The value of
>>> this alias is then used as the full node path to be found.
>>>
>>> Signed-off-by: David Daney<david.daney@cavium.com>
>
> [...]
>
>>
>> All the aliases are already decoded at boot time now.  See
>> of_alias_scan().  Instead of open-coding this, you can add an
>> of_alias_lookup() function something like this (untested):
>>
>
> After objections from davem, and a bit of thought, I already indicated on a
> different branch of this thread that we should drop this patch.
>
> I have improved my code so that it is no longer needed.

Okay.
