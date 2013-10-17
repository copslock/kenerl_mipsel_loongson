Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Oct 2013 20:26:46 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:45522 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827348Ab3JQS0oPQJhV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 17 Oct 2013 20:26:44 +0200
Message-ID: <52602BCE.7050407@imgtec.com>
Date:   Thu, 17 Oct 2013 13:26:22 -0500
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
Subject: Re: [PATCH 6/6] MIPS: APRP: Code formatting clean-ups.
References: <1381976070-8413-1-git-send-email-Steven.Hill@imgtec.com> <1381976070-8413-7-git-send-email-Steven.Hill@imgtec.com> <52602368.3000901@gmail.com>
In-Reply-To: <52602368.3000901@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.79.25]
X-SEF-Processed: 7_3_0_01192__2013_10_17_19_26_29
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38369
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

On 10/17/2013 12:50 PM, David Daney wrote:
> On 10/16/2013 07:14 PM, Steven J. Hill wrote:
>> From: "Steven J. Hill" <Steven.Hill@imgtec.com>
>>
>> Clean-up code according to the 'checkpatch.pl' script.
>
> This should probably be the first patch, so you don't end up making
> poorly formatted additions, and then later clean them up.
>
Noted, but I am not inclined to change the order of the patches right now.

> Also the change log text is not at all true, please make it reflect
> reality.
>
Yes, the changelog should be updated to note copyright clean-ups and 
other formatting changes. I will update that.

Steve
