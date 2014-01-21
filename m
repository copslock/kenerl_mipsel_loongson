Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Jan 2014 21:17:59 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:62026 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823127AbaAUUR5XgP-J (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 21 Jan 2014 21:17:57 +0100
Message-ID: <52DED597.1040607@imgtec.com>
Date:   Tue, 21 Jan 2014 14:16:23 -0600
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     LMOL <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: lib: Optimize partial checksum ops using prefetching.
References: <1390321122-25634-1-git-send-email-Steven.Hill@imgtec.com> <52DEBBA6.9070701@gmail.com>
In-Reply-To: <52DEBBA6.9070701@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.159.69]
X-SEF-Processed: 7_3_0_01192__2014_01_21_20_17_50
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39046
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

On 01/21/2014 12:25 PM, David Daney wrote:
> On 01/21/2014 08:18 AM, Steven J. Hill wrote:
>> From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
>>
>> Use the PREF instruction to optimize partial checksum operations.
>>
>> Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
>> Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
>
> NACK.  The proper latench and cacheline stride vary by CPU, you cannot
> just hard code them for 32-byte cacheline size with some random latency.
>
> This will make some CPUs slower.
>
Note that memcpy.S already uses fixed cache lines (32 bytes) so this is 
merely doing the same thing. I assume you have some empirical evidence 
concerning other CPUs being slower?
