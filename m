Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Jun 2013 10:36:01 +0200 (CEST)
Received: from mail-ie0-f182.google.com ([209.85.223.182]:40179 "EHLO
        mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822998Ab3FNIf5CiNcu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Jun 2013 10:35:57 +0200
Received: by mail-ie0-f182.google.com with SMTP id s9so747465iec.27
        for <linux-mips@linux-mips.org>; Fri, 14 Jun 2013 01:35:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :x-gm-message-state;
        bh=nkj2dHsIXDvQdcDxcAHRtVQT8Lf9axTATKl89LXxKm4=;
        b=ZRLBiqIYEh3Qa/BXni3j/bKBo8ILe9bvwLDfCxBpNSDua27FfVNAIgN9R7Rmrj29id
         wUIWFlh4NxGyYUfGfeXpougM8kc8FqLddGfsSHIyXCZiQHt6Rzi63K0cbFXsUO0qVLO3
         5E17T3qx0FK7yvziX+aTZ8S6j/kl7c81Lk3liVqE5qa3NEji9G5yvscR2kwx/Q6RspNv
         GUREPRmLus/A9RmXfCi1fXnuL0xEu/gRwKMXELG9jlRXZrZipJ/ANKKTbovGxUrTxOd/
         siyJ1XWSR3KNNaUI0HeOMGngjWJoNc6rmxaeTbxJPCOX3Ilh5tsfyPxDVu2NSPDeY56R
         kRtg==
X-Received: by 10.42.102.211 with SMTP id j19mr474891ico.0.1371198950699; Fri,
 14 Jun 2013 01:35:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.133.16 with HTTP; Fri, 14 Jun 2013 01:35:30 -0700 (PDT)
In-Reply-To: <20130614082220.GC22589@linux-mips.org>
References: <1371165583-21907-1-git-send-email-grant.likely@linaro.org> <20130614082220.GC22589@linux-mips.org>
From:   Grant Likely <grant.likely@linaro.org>
Date:   Fri, 14 Jun 2013 09:35:30 +0100
X-Google-Sender-Auth: mDY_rcVxrCnNYutWmuF4b_-VGbo
Message-ID: <CACxGe6snY7zjhx=UfO3Z_zUp1m25H69Fev7uvswoTbE1hRP7CA@mail.gmail.com>
Subject: Re: [PATCH] irqdomain: Remove temporary MIPS workaround code
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mips <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
X-Gm-Message-State: ALoCoQmxcWfuvdFxmNG9vQ/xbQ8P/9nO3i0u9yIZNpf6i+gIvkSOvmsvwlUWjAKWXBa2pddmpIq6
Return-Path: <glikely@secretlab.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36874
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@linaro.org
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

On Fri, Jun 14, 2013 at 9:22 AM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Fri, Jun 14, 2013 at 12:19:43AM +0100, Grant Likely wrote:
>
>> The MIPS interrupt controllers are all registering their own irq_domains
>> now. Drop the MIPS specific code because it is no longer needed.
>>
>> Signed-off-by: Grant Likely <grant.likely@linaro.org>
>> Cc: Ralf Baechle <ralf@linux-mips.org>
>> Cc: linux-mips@linux-mips.org
>> ---
>>
>> Ralf, this should be okay to pull out now. I'll be submitting it for
>> v3.11 unless someone yells. Even if so, all the irqdomain infrastructure
>> is in place to make it trivial to add an irqdomain where missing.
>
> I would like to merge this through the MIPS tree so it'll receive
> maximum testing, just in case, ok?

okay. I'll keep it out of my -next branch.

g.
