Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jul 2015 07:17:05 +0200 (CEST)
Received: from mail7.hitachi.co.jp ([133.145.228.42]:59048 "EHLO
        mail7.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008419AbbGOFRCgqyAF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Jul 2015 07:17:02 +0200
Received: from mlsv2.hitachi.co.jp (unknown [133.144.234.166])
        by mail7.hitachi.co.jp (Postfix) with ESMTP id E12A8B1D385;
        Wed, 15 Jul 2015 14:16:58 +0900 (JST)
Received: from mfilter04.hitachi.co.jp by mlsv2.hitachi.co.jp (8.13.1/8.13.1) id t6F5GwkZ030960; Wed, 15 Jul 2015 14:16:58 +0900
Received: from vshuts01.hitachi.co.jp (vshuts01.hitachi.co.jp [10.201.6.83])
        by mfilter04.hitachi.co.jp (Switch-3.3.4/Switch-3.3.4) with ESMTP id t6F5GvQ9022168;
        Wed, 15 Jul 2015 14:16:57 +0900
Received: from gxml20a.ad.clb.hitachi.co.jp (unknown [158.213.157.160])
        by vshuts01.hitachi.co.jp (Postfix) with ESMTP id 641262F0038;
        Wed, 15 Jul 2015 14:16:56 +0900 (JST)
Received: from [10.198.220.34] by gxml20a.ad.clb.hitachi.co.jp (Switch-3.1.10/Switch-3.1.9) id 76F51GJF90000AD4C; Wed, 15 Jul 2015 14:16:55 +0900
Message-ID: <55A5ECC3.5060803@hitachi.com>
Date:   Wed, 15 Jul 2015 14:16:51 +0900
From:   Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Organization: Hitachi, Ltd., Japan
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     Vivek Goyal <vgoyal@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
CC:     dwalker@fifo99.com, Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@linux-mips.org, Baoquan He <bhe@redhat.com>,
        linux-sh@vger.kernel.org, linux-s390@vger.kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>,
        linuxppc-dev@lists.ozlabs.org, linux-metag@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: Re: [PATCH 1/3] panic: Disable crash_kexec_post_notifiers
 if kdump is not available
References: <20150714135919.GA18333@fifo99.com> <20150714150208.GD10792@redhat.com> <20150714153430.GA18766@fifo99.com> <20150714154040.GA3912@redhat.com> <20150714154833.GA18883@fifo99.com> <20150714161612.GH10792@redhat.com> <87a8uyoeig.fsf@x220.int.ebiederm.org> <20150714172953.GA19135@fifo99.com> <20150714175527.GI10792@redhat.com> <87si8qmxef.fsf@x220.int.ebiederm.org> <20150714182336.GB3912@redhat.com>
In-Reply-To: <20150714182336.GB3912@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <masami.hiramatsu.pt@hitachi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48301
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: masami.hiramatsu.pt@hitachi.com
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

On 2015/07/15 3:23, Vivek Goyal wrote:
> On Tue, Jul 14, 2015 at 01:01:12PM -0500, Eric W. Biederman wrote:
>> Vivek Goyal <vgoyal@redhat.com> writes:
>>
>>> On Tue, Jul 14, 2015 at 05:29:53PM +0000, dwalker@fifo99.com wrote:
>>>
>>> [..]
>>>>>>>> If a machine is failing, there are high chance it can't deliver you the
>>>>>>>> notification. Detecting that failure suing some kind of polling mechanism
>>>>>>>> might be more reliable. And it will make even kdump mechanism more
>>>>>>>> reliable so that it does not have to run panic notifiers after the crash.
>>>>>>>
>>>>>>> I think what your suggesting is that my company should change how it's hardware works
>>>>>>> and that's not really an option for me. This isn't a simple thing like checking over the
>>>>>>> network if the machine is down or not, this is way more complex hardware design.
>>>>>>
>>>>>> That means you are ready to live with an unreliable design. There might be
>>>>>> cases where notifier does not get run properly and you will not do switch
>>>>>> despite the fact that OS has failed. I was just trying to nudge you in
>>>>>> a direction which could be more reliable mechanism.
>>>>>
>>>>> Sigh I see some deep confusion going on here.
>>>>>
>>>>> The panic notifiers are just that panic notifiers.  They have not been
>>>>> nor should they be tied to kexec.   If those notifiers force a switch
>>>>> over of between machines I fail to see why you would care if it was
>>>>> kexec or another panic situation that is forcing that switchover.
>>>>
>>>> Hidehiro isn't fixing the failover situation on my side, he's fixing register
>>>> information collection when crash_kexec_post_notifiers is used.
>>>
>>> Sure. Given that we have created this new parameter, let us fix it so that
>>> we can capture the other cpu register state in crash dump.
>>>
>>> I am little disappointed that it was not tested well when this parameter was
>>> introuced. We should have atleast tested it to the extent to see if there
>>> is proper cpu state present for all cpus in the crash dump.
>>>
>>> At that point of time it looked like a simple modification
>>> to allow panic notifiers before crash_kexec().
>>
>> Either that or we say no one cares enough, and it known broken so let's
>> just revert the fool thing.
> 
> Masami, you introduced this option. Are you fine with the revert? Is it
> really being used and tested?

Actually, it is tested but under very limited situation. I think we
need a clear acceptance criteria, IOW, we need a testset for kdump
so that we can make things better.
Would you have it? maybe we can push it into kselftest.

>> I honestly can't see how to support panic notifiers, before kexec.
>> There is no way to tell what is being done and all of the pieces
>> including smp_send_stop are known to be buggy.
> 
> we should be able to replace smp_send_stop() with what crash_kexec() is
> doing to stop the machine? If yes, then it should be fine I guess. This
> parameter description clearly says that specify it at your own risk. So
> we are not issuing a big support statement for successful kdump after
> panic notifiers. If it is something fixable, otherwise user needs
> to deal with it.

Agreed (as I've sent in other replay).

Thank you,

-- 
Masami HIRAMATSU
Linux Technology Research Center, System Productivity Research Dept.
Center for Technology Innovation - Systems Engineering
Hitachi, Ltd., Research & Development Group
E-mail: masami.hiramatsu.pt@hitachi.com
