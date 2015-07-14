Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jul 2015 19:12:50 +0200 (CEST)
Received: from out02.mta.xmission.com ([166.70.13.232]:47222 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010570AbbGNRMtWarAn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Jul 2015 19:12:49 +0200
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.82)
        (envelope-from <ebiederm@xmission.com>)
        id 1ZF3l1-0005pO-7S; Tue, 14 Jul 2015 11:12:39 -0600
Received: from 67-3-205-90.omah.qwest.net ([67.3.205.90] helo=x220.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.82)
        (envelope-from <ebiederm@xmission.com>)
        id 1ZF3l0-0000nQ-8t; Tue, 14 Jul 2015 11:12:38 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     dwalker@fifo99.com, Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@linux-mips.org, Baoquan He <bhe@redhat.com>,
        linux-sh@vger.kernel.org, linux-s390@vger.kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>,
        Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
        linuxppc-dev@lists.ozlabs.org, linux-metag@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20150710113331.4368.10495.stgit@softrs>
        <20150710113331.4368.63745.stgit@softrs>
        <87wpy82kqf.fsf@x220.int.ebiederm.org>
        <20150713202611.GA16525@fifo99.com>
        <87h9p7r0we.fsf@x220.int.ebiederm.org>
        <20150714135919.GA18333@fifo99.com>
        <20150714150208.GD10792@redhat.com>
        <20150714153430.GA18766@fifo99.com> <20150714154040.GA3912@redhat.com>
        <20150714154833.GA18883@fifo99.com>
        <20150714161612.GH10792@redhat.com>
Date:   Tue, 14 Jul 2015 12:06:15 -0500
In-Reply-To: <20150714161612.GH10792@redhat.com> (Vivek Goyal's message of
        "Tue, 14 Jul 2015 12:16:12 -0400")
Message-ID: <87a8uyoeig.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-AID: U2FsdGVkX19T4t1UIQWdOp69jV3E/lWhRdk0v7cFLF4=
X-SA-Exim-Connect-IP: 67.3.205.90
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 1/3] panic: Disable crash_kexec_post_notifiers if kdump is not available
X-SA-Exim-Version: 4.2.1 (built Wed, 24 Sep 2014 11:00:52 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Return-Path: <ebiederm@xmission.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48292
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ebiederm@xmission.com
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

Vivek Goyal <vgoyal@redhat.com> writes:

> On Tue, Jul 14, 2015 at 03:48:33PM +0000, dwalker@fifo99.com wrote:
>> On Tue, Jul 14, 2015 at 11:40:40AM -0400, Vivek Goyal wrote:
>> > On Tue, Jul 14, 2015 at 03:34:30PM +0000, dwalker@fifo99.com wrote:
>> > > On Tue, Jul 14, 2015 at 11:02:08AM -0400, Vivek Goyal wrote:
>> > > > On Tue, Jul 14, 2015 at 01:59:19PM +0000, dwalker@fifo99.com wrote:
>> > > > > On Mon, Jul 13, 2015 at 08:19:45PM -0500, Eric W. Biederman wrote:
>> > > > > > dwalker@fifo99.com writes:
>> > > > > > 
>> > > > > > > On Fri, Jul 10, 2015 at 08:41:28AM -0500, Eric W. Biederman wrote:
>> > > > > > >> Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com> writes:
>> > > > > > >> 
>> > > > > > >> > You can call panic notifiers and kmsg dumpers before kdump by
>> > > > > > >> > specifying "crash_kexec_post_notifiers" as a boot parameter.
>> > > > > > >> > However, it doesn't make sense if kdump is not available.  In that
>> > > > > > >> > case, disable "crash_kexec_post_notifiers" boot parameter so that
>> > > > > > >> > you can't change the value of the parameter.
>> > > > > > >> 
>> > > > > > >> Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>
>> > > > > > >
>> > > > > > > I think it would make sense if he just replaced "kdump" with "kexec".
>> > > > > > 
>> > > > > > It would be less insane, however it still makes no sense as without
>> > > > > > kexec on panic support crash_kexec is a noop.  So the value of the
>> > > > > > seeting makes no difference.
>> > > > > 
>> > > > > Can you explain more, I don't really understand what you mean. Are you suggesting
>> > > > > the whole "crash_kexec_post_notifiers" feature has no value ?
>> > > > 
>> > > > Daniel,
>> > > > 
>> > > > BTW, why are you using crash_kexec_post_notifiers commandline? Why not
>> > > > without it?
>> > > 
>> > > It was explained in the prior thread but to rehash, the notifiers are used to do a switch
>> > > over from the crashed machine to another redundant machine.
>> > 
>> > So why not detect failure using polling or issue notifications from second
>> > kernel.
>> > 
>> > IOW, expecting that a crashed machine will be able to deliver notification
>> > reliably is falwed to begin with, IMHO.
>> 
>> It's flawed to think you can kexec, but you still do it right ? I've not gotten into
>> the deep details of this switching process, but that's how this interface is used.
>
> Sure. But the deal here is that users of interface know that sometimes it
> can be unreliable. And in the absence of more reliable mechanism, somewhat
> less reliable mechanism is fine. 
>
>>  
>> > If a machine is failing, there are high chance it can't deliver you the
>> > notification. Detecting that failure suing some kind of polling mechanism
>> > might be more reliable. And it will make even kdump mechanism more
>> > reliable so that it does not have to run panic notifiers after the crash.
>> 
>> I think what your suggesting is that my company should change how it's hardware works
>> and that's not really an option for me. This isn't a simple thing like checking over the
>> network if the machine is down or not, this is way more complex hardware design.
>
> That means you are ready to live with an unreliable design. There might be
> cases where notifier does not get run properly and you will not do switch
> despite the fact that OS has failed. I was just trying to nudge you in
> a direction which could be more reliable mechanism.

Sigh I see some deep confusion going on here.

The panic notifiers are just that panic notifiers.  They have not been
nor should they be tied to kexec.   If those notifiers force a switch
over of between machines I fail to see why you would care if it was
kexec or another panic situation that is forcing that switchover.

Now if you want a reliable design, I strongly recommend as I have been
recommending for the 15 years that magic failover code be placed in
either the new kernel or a stub that preceedes the new kernel.

That gives the greatest reliabilty we know how to engineer, and it lets
you do whatever you need to do.

Especially if it is not desirable for the panic notifiers to run without
the presence of kexec, I very strongly recommend not using them at all
and just writing a stub of code that can run before a new kernel starts.

Eric
