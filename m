Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Nov 2013 17:52:43 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:32447 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816503Ab3KMQwh5EbY- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 13 Nov 2013 17:52:37 +0100
Message-ID: <5283AE49.2080503@imgtec.com>
Date:   Wed, 13 Nov 2013 10:52:25 -0600
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     LMOL <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Release of Linux MTI-3.10-LTS kernel.
References: <528246BA.10607@imgtec.com> <20131112210234.GB30010@blackmetal.musicnaut.iki.fi>
In-Reply-To: <20131112210234.GB30010@blackmetal.musicnaut.iki.fi>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.159.180]
X-SEF-Processed: 7_3_0_01192__2013_11_13_16_52_32
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38516
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

On 11/12/2013 03:02 PM, Aaro Koskinen wrote:
> Hi,
>
> On Tue, Nov 12, 2013 at 09:18:18AM -0600, Steven J. Hill wrote:
>> Imagination Technologies is pleased to announce the release of its
>> 3.10 LTS (Long-Term Support) MIPS kernel. The changelog below is
>> based off the stable Linux 3.10.14 release done by Greg
>> Kroah-Hartman in commit
>> 8c15abc94c737f9120d3d4a550abbcbb9be121f6 back on October 1st. The
>> code repository is hosted at the Linux/MIPS project GIT:
>>
>> http://git.linux-mips.org/?p=linux-mti.git;a=summary
>>
>> We look forward to any comments or feedback.
>
> Why multiple MIPS stable trees? There's already also
> http://git.linux-mips.org/?p=ralf/linux.git;a=shortlog;h=refs/heads/linux-3.10-stable?
>
We track 'linux-stable' because the ones on LMO have too much lag.

> Also 3.10.14 sounds quite old. Are you sure you are not missing any
> important fixes?
>
We ran this kernel on 20 different board/core combinations. They ran our 
stress test suite continuously for over a week at 100% load with no 
failures. We have high confidence in this particular release. There are 
always bugs, so your question is somewhat ridiculous. Regarding age, go 
ask the Android team why the latest KitKat release is running a 3.4.0 
kernel and not the latest and greatest.
