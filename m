Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Jan 2011 20:46:52 +0100 (CET)
Received: from mail-vw0-f49.google.com ([209.85.212.49]:42461 "EHLO
        mail-vw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491137Ab1ASTqr convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 19 Jan 2011 20:46:47 +0100
Received: by vws5 with SMTP id 5so539441vws.36
        for <multiple recipients>; Wed, 19 Jan 2011 11:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=3tXBhO7dnchyZaEGy8j+UCcE3x5SsURpM7bkBkeX414=;
        b=GSBzoZzVAi72XBgqQYfENWFnf3a4Uvx43jy0EXJmLG8sHK+CQXzQPL5G6TyDHKFtAV
         8IIq5zncBh+dY8rO4nt/7S5nSuHoa/p0vR7KYLpzdDH7EmlXQhabi6HIhRh4sNJbOJ9c
         Dm/IcRrYo5OyjLxWrz67zyD+Uz+Wh7RTGTUSg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=XDhz6Sfc3FdLZZEuxQRNamdMMcN16Y0Ued84RCz6GkrhddF8uMRWA700y0u59KplPl
         n44cHLumhJ/KV4Qh2xu4SnoNxBUwGzcveM8BOaqvitP//oCNPo1WAdgIy/gvbGnm0JOm
         bzRVJSKvE0SwMoexFCDGg/Jl7J0dM7EaR6g6s=
Received: by 10.229.184.207 with SMTP id cl15mr956414qcb.33.1295466399751;
 Wed, 19 Jan 2011 11:46:39 -0800 (PST)
MIME-Version: 1.0
Received: by 10.229.39.9 with HTTP; Wed, 19 Jan 2011 11:46:19 -0800 (PST)
In-Reply-To: <4D373E5B.5010303@caviumnetworks.com>
References: <1293502077-9196-1-git-send-email-ddaney@caviumnetworks.com>
 <1293502077-9196-3-git-send-email-ddaney@caviumnetworks.com>
 <AANLkTinZZ2TziwkiBfhqV-3-VfXwU+EPx3OHsnTRVChT@mail.gmail.com> <4D373E5B.5010303@caviumnetworks.com>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Wed, 19 Jan 2011 20:46:19 +0100
Message-ID: <AANLkTi=aZSwQCVudjZrUoOZYGJscER8R3vOsRcgadw-_@mail.gmail.com>
Subject: Re: [PATCH 2/2] MIPS: Optimize TLB handlers for Octeon CPUs
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <jonas.gorski@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28986
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
Precedence: bulk
X-list: linux-mips

On 19 January 2011 20:41, David Daney <ddaney@caviumnetworks.com> wrote:
> On 01/19/2011 11:35 AM, Jonas Gorski wrote:
>>
>> On 28/12/2010, David Daney<ddaney@caviumnetworks.com>  wrote:
>>>
>>> +#if defined(CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE)&&  \
>>> +    CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE>  0
>>> (...)
>>> +#else
>>> +static bool scratchpad_available(void)
>>> +{
>>> +       return false;
>>> +}
>>> +static int scratchpad_offset(int i)
>>> +{
>>> +       BUG();
>>> +}
>>> +#endif
>>
>> This seems to have broken the build for any non-octeon mips build:
>>
>>   CC      arch/mips/mm/tlbex.o
>> cc1: warnings being treated as errors
>> arch/mips/mm/tlbex.c: In function 'scratchpad_offset':
>> arch/mips/mm/tlbex.c:112: error: no return statement in function
>> returning non-void
>>
>
> Can you tell me which version of GCC you are using?
>
> I tested it with gcc-4.5.x, BUG() may have problems if builtin_unreachable
> is not available.

That's probably it, It's a 4.3.3 (with code sourcery extensions, the
OpenWrt default one).

Jonas
