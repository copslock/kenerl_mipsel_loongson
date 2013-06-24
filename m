Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Jun 2013 00:40:08 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:26623 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827575Ab3FXWkHn0rq0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 25 Jun 2013 00:40:07 +0200
Message-ID: <51C8CA95.80008@imgtec.com>
Date:   Mon, 24 Jun 2013 17:39:17 -0500
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
MIME-Version: 1.0
To:     Huacai Chen <chenhc@lemote.com>
CC:     "Steven J. Hill" <sjhill@realitydiluted.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: Re: [PATCH V9 03/13] MIPS: Loongson: Introduce and use cpu_has_coherent_cache
 feature
References: <1359527106-22879-1-git-send-email-chenhc@lemote.com>        <1359527106-22879-4-git-send-email-chenhc@lemote.com>        <5166ED66.7020307@realitydiluted.com>        <CAAhV-H6s47NUHzbEX5UKYtkei7=s08PPXCMw39_fP_SV7Hv5Vg@mail.gmail.com> <CAAhV-H58Y_Rd8thj8MWXGCqqGtYJekDKrO-nXYjdp3214jnQ0A@mail.gmail.com>
In-Reply-To: <CAAhV-H58Y_Rd8thj8MWXGCqqGtYJekDKrO-nXYjdp3214jnQ0A@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.150.47]
X-SEF-Processed: 7_3_0_01192__2013_06_24_23_40_01
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37121
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@imgtec.com
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

On 06/22/2013 09:10 PM, Huacai Chen wrote:
>
> Is the 3rd patch of V10 is OK to be accepted now? If so, could the
> patchset of V10 be merged into 3.11?
>
The merge window for 3.11 is closed at this point. You should get it 
prepared for 3.12, so start tracking the 'mips-for-linux-next' branch 
with your patches.

Acked-by: Steven J. Hill <Steven.Hill@imgtec.com>
