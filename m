Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jul 2015 12:49:52 +0200 (CEST)
Received: from mail9.hitachi.co.jp ([133.145.228.44]:34101 "EHLO
        mail9.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010585AbbGOKtuN4ADm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Jul 2015 12:49:50 +0200
Received: from mlsv7.hitachi.co.jp (unknown [133.144.234.166])
        by mail9.hitachi.co.jp (Postfix) with ESMTP id C9F9F109BD87;
        Wed, 15 Jul 2015 19:49:46 +0900 (JST)
Received: from mfilter05.hitachi.co.jp by mlsv7.hitachi.co.jp (8.13.1/8.13.1) id t6FAnk6V005693; Wed, 15 Jul 2015 19:49:46 +0900
Received: from vshuts01.hitachi.co.jp (vshuts01.hitachi.co.jp [10.201.6.83])
        by mfilter05.hitachi.co.jp (Switch-3.3.4/Switch-3.3.4) with ESMTP id t6FAnjic001640;
        Wed, 15 Jul 2015 19:49:45 +0900
Received: from hsdlmain.sdl.hitachi.co.jp (unknown [133.144.14.194])
        by vshuts01.hitachi.co.jp (Postfix) with ESMTP id E32812F0038;
        Wed, 15 Jul 2015 19:49:44 +0900 (JST)
Received: from hsdlvgate2.sdl.hitachi.co.jp by hsdlmain.sdl.hitachi.co.jp (8.13.8/3.7W11021512) id t6FAni4I013428; Wed, 15 Jul 2015 19:49:44 +0900
X-AuditID: 85900ec0-9d7c9b9000001a57-8d-55a63ab1732d
Received: from sdl99w.sdl.hitachi.co.jp (sdl99w.yrl.intra.hitachi.co.jp [133.144.14.250])
        by hsdlvgate2.sdl.hitachi.co.jp (Symantec Mail Security) with ESMTP id 4DDBF236561;
        Wed, 15 Jul 2015 19:49:21 +0900 (JST)
Received: from mailb.sdl.hitachi.co.jp (sdl99b.yrl.intra.hitachi.co.jp [133.144.14.197])
        by sdl99w.sdl.hitachi.co.jp (Postfix) with ESMTP id 469C753C21A;
        Wed, 15 Jul 2015 19:49:44 +0900 (JST)
Received: from [10.198.220.34] (unknown [10.198.220.34])
        by mailb.sdl.hitachi.co.jp (Postfix) with ESMTP id 02C21495B8B;
        Wed, 15 Jul 2015 19:49:43 +0900 (JST)
Message-ID: <55A63AC6.4040806@hitachi.com>
Date:   Wed, 15 Jul 2015 19:49:42 +0900
From:   Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:13.0) Gecko/20120604 Thunderbird/13.0
MIME-Version: 1.0
To:     Vivek Goyal <vgoyal@redhat.com>
CC:     dwalker@fifo99.com, "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@linux-mips.org, Baoquan He <bhe@redhat.com>,
        linux-sh@vger.kernel.org, linux-s390@vger.kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>,
        Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
        linuxppc-dev@lists.ozlabs.org, linux-metag@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] panic: Disable crash_kexec_post_notifiers if kdump
 is not available
References: <20150710113331.4368.10495.stgit@softrs> <20150710113331.4368.63745.stgit@softrs> <87wpy82kqf.fsf@x220.int.ebiederm.org> <20150713202611.GA16525@fifo99.com> <87h9p7r0we.fsf@x220.int.ebiederm.org> <20150714135919.GA18333@fifo99.com> <20150714150208.GD10792@redhat.com> <20150714153430.GA18766@fifo99.com> <20150714154040.GA3912@redhat.com>
In-Reply-To: <20150714154040.GA3912@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAA==
Return-Path: <hidehiro.kawai.ez@hitachi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48305
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hidehiro.kawai.ez@hitachi.com
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

(2015/07/15 0:40), Vivek Goyal wrote:
> On Tue, Jul 14, 2015 at 03:34:30PM +0000, dwalker@fifo99.com wrote:
>> On Tue, Jul 14, 2015 at 11:02:08AM -0400, Vivek Goyal wrote:
>>> On Tue, Jul 14, 2015 at 01:59:19PM +0000, dwalker@fifo99.com wrote:
>>>> On Mon, Jul 13, 2015 at 08:19:45PM -0500, Eric W. Biederman wrote:
>>>>> dwalker@fifo99.com writes:
>>>>>
>>>>>> On Fri, Jul 10, 2015 at 08:41:28AM -0500, Eric W. Biederman wrote:
>>>>>>> Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com> writes:
>>>>>>>
>>>>>>>> You can call panic notifiers and kmsg dumpers before kdump by
>>>>>>>> specifying "crash_kexec_post_notifiers" as a boot parameter.
>>>>>>>> However, it doesn't make sense if kdump is not available.  In that
>>>>>>>> case, disable "crash_kexec_post_notifiers" boot parameter so that
>>>>>>>> you can't change the value of the parameter.
>>>>>>>
>>>>>>> Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>
>>>>>>
>>>>>> I think it would make sense if he just replaced "kdump" with "kexec".
>>>>>
>>>>> It would be less insane, however it still makes no sense as without
>>>>> kexec on panic support crash_kexec is a noop.  So the value of the
>>>>> seeting makes no difference.
>>>>
>>>> Can you explain more, I don't really understand what you mean. Are you suggesting
>>>> the whole "crash_kexec_post_notifiers" feature has no value ?
>>>
>>> Daniel,
>>>
>>> BTW, why are you using crash_kexec_post_notifiers commandline? Why not
>>> without it?
>>
>> It was explained in the prior thread but to rehash, the notifiers are used to do a switch
>> over from the crashed machine to another redundant machine.
> 
> So why not detect failure using polling or issue notifications from second
> kernel.

Polling is not sufficient because some kernel parts may be
alive even if the responder of the polling is dead.  We want
to notify the failure after stopping other CPUs.

Notifying from second kernel needs to wait for the kernel
booted up and device initialization if needed, and this
is not applicable if we want to do fast switchover.

Notifying just before second kernel, as Eric stated, is
one of the reliable option although we can't do complicate
things there.  For example, we can notify the failure by
writing some specific I/O registers in purgatory codes
provided by kexec command.  Since the purgatory codes are
currently embedded into kexec command, so we might need to
modify the mechanism to be pluggable because how to notify
will differ among vendors.

Anyway, this is the case of switchover use case.  If we want
to save minimal information before kdump, notifiers or
kmsg_dump() can be used.

> IOW, expecting that a crashed machine will be able to deliver notification
> reliably is falwed to begin with, IMHO.

I think it depends on what callback is used.  Most of panic
notifiers just do memory copy or I/O register access.
Of course, there are relatively complicate notifiers too,
and I'm preparing patch sets for hardening for that case.

Regards,
Hidehiro Kawai
