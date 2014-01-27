Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2014 21:57:09 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:51674 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825311AbaA0U5H1x4lv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Jan 2014 21:57:07 +0100
Message-ID: <52E6C7D4.4060708@imgtec.com>
Date:   Mon, 27 Jan 2014 20:55:48 +0000
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.1
MIME-Version: 1.0
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH 20/58] MIPS: lib: memset: Whitespace fixes
References: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com> <1390853985-14246-21-git-send-email-markos.chandras@imgtec.com> <52E6D30B.1010101@cogentembedded.com>
In-Reply-To: <52E6D30B.1010101@cogentembedded.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.47]
X-SEF-Processed: 7_3_0_01192__2014_01_27_20_57_02
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39179
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Markos.Chandras@imgtec.com
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

On 01/27/2014 09:43 PM, Sergei Shtylyov wrote:
> ....
> Hello.
>
> On 01/27/2014 11:19 PM, Markos Chandras wrote:
>
>> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
>
>     You're spoiling intentionally marked delay slots, not fixing
> anything here. This is a convention.
>
> WBR, Sergei
>
>
Hi Sergei,

Apologies. I was not aware of this convention. I will drop this patch 
and fix the next one. I will also double check if I have made the same 
mistake in any of the other patches.

-- 
markos
