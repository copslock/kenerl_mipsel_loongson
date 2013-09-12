Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Sep 2013 18:02:48 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:61688 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822585Ab3ILQCqbW8Zi (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 12 Sep 2013 18:02:46 +0200
Message-ID: <5231E587.9030403@imgtec.com>
Date:   Thu, 12 Sep 2013 11:02:15 -0500
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130804 Thunderbird/17.0.8
MIME-Version: 1.0
To:     Florian Fainelli <f.fainelli@gmail.com>
CC:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Fix errata for some 1074K cores.
References: <1378929708-7253-1-git-send-email-Steven.Hill@imgtec.com> <52318BC6.7030903@imgtec.com> <j0d17e3bxlvp3famj4e32xv9.1378997855738@email.android.com> <CAGVrzcY_OWUSK4dfZ8fnV49ELSYE6exSYQi5AwxuGoKnvx5Rtg@mail.gmail.com> <5231D9E5.2080002@imgtec.com> <5231DE0F.8080302@imgtec.com> <CAGVrzcYxyWv2F1HDkOUCo2Ezicxq+UsxouOsUtz+UZAWFew18A@mail.gmail.com>
In-Reply-To: <CAGVrzcYxyWv2F1HDkOUCo2Ezicxq+UsxouOsUtz+UZAWFew18A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.159.66]
X-SEF-Processed: 7_3_0_01192__2013_09_12_17_02_40
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37810
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

On 09/12/2013 10:50 AM, Florian Fainelli wrote:
>
> Are there any reasons why you cannot quote an internal note about this
> errata which would give a better idea of what this code is about?
> Sorry but the diff really does not help understand what is happening
> without a proper explanation of why this is required. At first glance
> it would like some revisions of the CPU are affected by some D$ bug?
>
Okaaay. How about we just stop here. I posted a poor quality patch that 
did not have enough information. I will post a second version that will 
have the details of what E16 is and what is being fixed. This will 
involve me talking to hardware engineers to get something I can put in 
the patch. My sincere apologies to everyone. I will go crawl back under 
my rock and finish my work for this week. You should see the corrected 
version the first part of next week. Cheers.

Steve
