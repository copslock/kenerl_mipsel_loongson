Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Aug 2012 20:41:00 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:46920 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903611Ab2HUSky (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Aug 2012 20:40:54 +0200
Received: by dajq27 with SMTP id q27so77949daj.36
        for <multiple recipients>; Tue, 21 Aug 2012 11:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=KF1gWiQmvYTdxwnugpdl2bhaU1J/0I8Jjc96YpS5GVY=;
        b=UFlwolO4/9KmrmyTEWCfJcqMZBQnPc2vkcLCOZmJD8OHgnwGLIr9f46w7KA+pTkO7y
         JKCGm+LDe4qC+kVZN0u/XWPSHC4zt/mGFVAR/dlblVDlDSLd+GFFPQN93LP1uggg/hcB
         uKAd5KwjEEmTBFS6B6s7Zp1uWSOyiO6TRlQiHdQXn5rllFRMXoIUP5+QaGEVU3jaChiE
         X6OVdT494zUMMr0DnWg903OFmupATlSUkq+roy2oof6Bg/gdLtrvpPYYbj8nZ+d7atc+
         Q6VpbVuAOUliqwsL4ixghmMHGtLvUtKKHe8OZnAu6pZt3QmsMJ1tHiE2IDI4gTYUrw6J
         dRXw==
Received: by 10.66.76.106 with SMTP id j10mr39984189paw.51.1345574448168;
        Tue, 21 Aug 2012 11:40:48 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id tq4sm1957771pbc.11.2012.08.21.11.40.46
        (version=SSLv3 cipher=OTHER);
        Tue, 21 Aug 2012 11:40:47 -0700 (PDT)
Message-ID: <5033D62D.9070508@gmail.com>
Date:   Tue, 21 Aug 2012 11:40:45 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120717 Thunderbird/14.0
MIME-Version: 1.0
To:     John Crispin <john@phrozen.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] spi: Add SPI master controller for OCTEON SOCs.
References: <1336772086-17248-1-git-send-email-ddaney.cavm@gmail.com> <1336772086-17248-3-git-send-email-ddaney.cavm@gmail.com> <5033D22E.2050307@phrozen.org> <5033D48B.8050903@gmail.com> <5033D4DC.6050902@phrozen.org>
In-Reply-To: <5033D4DC.6050902@phrozen.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 34315
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

On 08/21/2012 11:35 AM, John Crispin wrote:
> On 21/08/12 20:33, David Daney wrote:
>> On 08/21/2012 11:23 AM, John Crispin wrote:
>>> On 11/05/12 23:34, David Daney wrote:
>>>> From: David Daney <david.daney@cavium.com>
>>>>
>>>> Add the driver, link it into the kbuild system and provide device tree
>>>> binding documentation.
>>>>
>>>> Signed-off-by: David Daney <david.daney@cavium.com>
>>>
>>> Thanks, queued for 3.7.
>>>
>>
>> This cannot go in like this.
>>
>> There were a bunch of requests by other maintainers that were never
>> done.  Also since it is in a foreign subsystem, it at a minimum needs
>> some additional Acked-bys
>
> hmmm ... you are right about the Acked-by ... i forgot to merge add it ...
>
> i did ask you about this on IRC and you said the driver was ok to be
> merged like this. inside the thread linus wllej at some point says that
> his comment was bogus if i am not mistaken ?

OK, I think I won't answer this type of question on IRC in the future. 
I really should have looked at it in more detail.  But at the end of the 
day, I need to fix it up before it can go in.

David Daney
