Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 May 2015 19:57:24 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:57758 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006699AbbEVR5VbpuzO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 May 2015 19:57:21 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 46C8F6BF3A567;
        Fri, 22 May 2015 18:57:15 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 22 May
 2015 18:57:18 +0100
Received: from [10.100.200.196] (10.100.200.196) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.224.2; Fri, 22 May
 2015 18:57:17 +0100
Message-ID: <555F6D39.1050005@imgtec.com>
Date:   Fri, 22 May 2015 14:54:01 -0300
From:   Ezequiel Garcia <ezequiel.garcia@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     Andrew Bresticker <abrestic@chromium.org>
CC:     Linux-MIPS <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Turquette <mturquette@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        James Hartley <james.hartley@imgtec.com>,
        Govindraj Raja <Govindraj.Raja@imgtec.com>,
        Damien Horsley <Damien.Horsley@imgtec.com>,
        Kevin Cernekee <cernekee@chromium.org>,
        James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH 9/9] clk: pistachio: Correct critical clock list
References: <1432252663-31318-1-git-send-email-ezequiel.garcia@imgtec.com>      <1432252663-31318-10-git-send-email-ezequiel.garcia@imgtec.com> <CAL1qeaFJBtjzDGqqa-qRb=+5_36QCyssGAKAZk2A2Tos3xK5LQ@mail.gmail.com>
In-Reply-To: <CAL1qeaFJBtjzDGqqa-qRb=+5_36QCyssGAKAZk2A2Tos3xK5LQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.100.200.196]
Return-Path: <Ezequiel.Garcia@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47586
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ezequiel.garcia@imgtec.com
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



On 05/22/2015 02:56 PM, Andrew Bresticker wrote:
> On Thu, May 21, 2015 at 4:57 PM, Ezequiel Garcia
> <ezequiel.garcia@imgtec.com> wrote:
>> From: Damien Horsley <Damien.Horsley@imgtec.com>
>>
>> Correct the critical clock list. The current one is wrong, and may
>> fail under some circumstances.
>>
>> Signed-off-by: Damien Horsley <Damien.Horsley@imgtec.com>
>> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
> 
> The commit message could be more descriptive, e.g. explaining which
> additional clocks must be enabled at all times and why, especially
> since forcing on clocks form the clock driver is very much frowned
> upon unless absolutely necessary.  Otherwise,
> 
> Reviewed-by: Andrew Bresticker <abrestic@chromium.org>
> 

OK, I'll explain this in detail.

Thanks for the review,
-- 
Ezequiel
