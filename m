Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Oct 2018 14:36:46 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:49364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990824AbeJ2Ngnx18ZR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 29 Oct 2018 14:36:43 +0100
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6A5B2082D;
        Mon, 29 Oct 2018 13:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540820197;
        bh=4dqWG0GBWPMUzwKsPqk0scqM9PAuN8RviIX3A3Xpc9U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PFObk1JasxcS2XK6LP1W8urpabcKEDkyXRuikvv7jMIv26BGgxVMeVWZofwdJQLJa
         ox1iW3dezevmjuu8DU8b0qciPW6yRryvBFbleVNQ46oEjJwexFKq79k1AjB29t6ECs
         T9btBMNTuBWauVTk8plP6nlsMwk50c8a04tvKe1I=
Date:   Mon, 29 Oct 2018 09:36:35 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Paul Burton <paul.burton@mips.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH AUTOSEL 4.14 33/46] MIPS: Workaround GCC
 __builtin_unreachable reordering bug
Message-ID: <20181029133635.GM2015@sasha-vm>
References: <20181025141053.213330-1-sashal@kernel.org>
 <20181025141053.213330-33-sashal@kernel.org>
 <20181025195254.q55noj2rdh5vyw5s@pburton-laptop>
 <CAK8P3a2eOo=9Pv4XmyX30_PYoRpp_f6rXQn+pk9z21wMvE84Ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAK8P3a2eOo=9Pv4XmyX30_PYoRpp_f6rXQn+pk9z21wMvE84Ag@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Return-Path: <sashal@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66974
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sashal@kernel.org
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

On Fri, Oct 26, 2018 at 09:36:30AM +0200, Arnd Bergmann wrote:
>On 10/25/18, Paul Burton <paul.burton@mips.com> wrote:
>> On Thu, Oct 25, 2018 at 10:10:40AM -0400, Sasha Levin wrote:
>>> From: Paul Burton <paul.burton@mips.com>
>>> ---
>>>  arch/mips/Kconfig                |  1 +
>>>  arch/mips/include/asm/compiler.h | 35 ++++++++++++++++++++++++++++++++
>>>  2 files changed, 36 insertions(+)
>>
>> In principle I'm fine with backporting this - it does fix broken builds.
>>
>> It's only going to be of any use though if you also backport commit
>> 04f264d3a8b0 ("compiler.h: Allow arch-specific asm/compiler.h"). I'd
>> recommend backporting both or neither.
>>
>> In practice I think it's unlikely anyone will need a microMIPS kernel &
>> be tied to the particular versions affected by the bug this patch fixed,
>> so I don't think it's a problem to backport neither.
>
>I think the current practice of the stable kernel these days is to take
>both patches in this case: They fix an actual bug in the mainline kernel,
>and it seems unlikely enough that they cause a regression if backported,
>so putting them into 4.14 has more advantages than disadvantages.

I'll take both, thank you!

--
Thanks,
Sasha
