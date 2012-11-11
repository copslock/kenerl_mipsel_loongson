Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Nov 2012 19:26:11 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:40519 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6826639Ab2KKS0K0XzEQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 11 Nov 2012 19:26:10 +0100
Message-ID: <509FED86.8020104@phrozen.org>
Date:   Sun, 11 Nov 2012 19:25:10 +0100
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.7) Gecko/20120922 Icedove/10.0.7
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: [MIPS] Pull request for 3.8
References: <1352657010-9632-1-git-send-email-blogic@openwrt.org> <CAJiQ=7DKn9hUr_Y2xn6r7ZRNQ3FTOXe+rMq=ZigxMMZdL-d0TA@mail.gmail.com>
In-Reply-To: <CAJiQ=7DKn9hUr_Y2xn6r7ZRNQ3FTOXe+rMq=ZigxMMZdL-d0TA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 34951
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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

On 11/11/12 19:19, Kevin Cernekee wrote:
> On Sun, Nov 11, 2012 at 10:03 AM, John Crispin<blogic@openwrt.org>  wrote:
>> Hi Ralf,
>>
>> here is my queue of patches i consider ready for 3.8.
> [snip]
>> Kevin Cernekee (1):
>>        MIPS: tlbex: Fix section mismatches
>
> The section mismatch in question first showed up in 3.7-rc2 with
> commit 02a5417751, so it's a recent regression with an easy fix.
>
> What do you think about rolling the fix into 3.7 instead of 3.8?


ralf,

can you send this to linus for 3.7-rc5 ? i would remove it from my tree 
if you do.

	John
