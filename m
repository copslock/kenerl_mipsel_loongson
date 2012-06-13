Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Jun 2012 18:30:06 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:52750 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903760Ab2FMQ37 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 Jun 2012 18:29:59 +0200
Received: by dadm1 with SMTP id m1so1174508dad.36
        for <multiple recipients>; Wed, 13 Jun 2012 09:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=uj1zW4/Xod6LsWq/3qCr+g3Jkc5IlGMtrjWr8pRya48=;
        b=Jms8gauzbsmdMNkpric0j3ow6YhCl3tWQwu+Etd7whksrbLBknQ7dKglSiTaq8xNu2
         TaCVVJFGRj9lTOw67rRQ4+vUKwJ+gvT+/iw9t3qcbCQfhBTRLz1B3mlb7+K6MIqGnTu0
         ErwxQ1iTjOnxSuSbOrE9sTpAKeqCPpaWTcUttky9b+I9zqwCpr/bs6WvzJ+UWt9nmE/l
         4VuCvP0CvYtvUUHGNTnRcXduKQUIG7dDI0GYkCWXtovila7PAm1rN84E7zO53NE+0PUo
         Rh/Oh9CHCaquWaMnx9QiaGoh2EnVfXej2Gwi13DKjOEox9iO8lOw24GpgqrGGNiR0/n/
         l6Qg==
Received: by 10.68.242.162 with SMTP id wr2mr53030670pbc.125.1339604993019;
        Wed, 13 Jun 2012 09:29:53 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id ph1sm6232759pbb.45.2012.06.13.09.29.51
        (version=SSLv3 cipher=OTHER);
        Wed, 13 Jun 2012 09:29:51 -0700 (PDT)
Message-ID: <4FD8BFFE.3040400@gmail.com>
Date:   Wed, 13 Jun 2012 09:29:50 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Shane McDonald <mcdonald.shane@gmail.com>, ralf@linux-mips.org
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH v2 5/5] MIPS: Move cache setup to setup_arch().
References: <1337040290-16015-1-git-send-email-ddaney.cavm@gmail.com>   <1337040290-16015-6-git-send-email-ddaney.cavm@gmail.com>       <CACoURw4+N8Nk-N81kryXHOg9O_=ntvqv9prOLAZW6KKEYQ9v+A@mail.gmail.com>    <4FD61B22.3040407@gmail.com>    <4FD61F35.1080103@gmail.com>    <CACoURw6oCNKHh7o9N_kE6uryfpu57sQqA-p2fq6hKnsikO5KgA@mail.gmail.com> <CACoURw6S+Z9urgYQzqkTZ0WR4kcaxMnSLm=D6m_6pWJnvDtUpA@mail.gmail.com>
In-Reply-To: <CACoURw6S+Z9urgYQzqkTZ0WR4kcaxMnSLm=D6m_6pWJnvDtUpA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 33629
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

On 06/13/2012 08:44 AM, Shane McDonald wrote:
> On Mon, Jun 11, 2012 at 12:32 PM, Shane McDonald
> <mcdonald.shane@gmail.com>  wrote:
>> There is a line:
>>
>> __setup("cca=", cca_setup);
>>
>> that seems to be used to call cca_setup().  I don't know how
>> the __setup() works, so I'm a little lost on the solution myself.
>>
>> Note that, besides the cca_setup(), there is also a routine
>> setcoherentio() that is defined the same way as cca_setup().
>> I suspect that suffers from the same problem as cca_setup().
>
> I've been doing a little learning on how the __setup() macro works.
> A proposed solution I have is to change from using the __setup()
> macro to using early_param() to mark the call to cca_setup().

This is the exact change I was going to suggest.

> Functions marked with __setup() are executed late in the boot
> process, whereas those marked with early_param() occur
> very early in the process.  I have tried this out,
> and it solves my problem, but I'm looking for feedback on
> whether this is the correct solution.
>
> Unless I get any different feedback, I'll send out a patch with
> my change later today.

Assuming that such a patch passes checkpatch.pl and is otherwise clean, 
you could add:

Acked-by: David Daney <david.daney@cavium.com>
