Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jul 2015 20:07:45 +0200 (CEST)
Received: from out02.mta.xmission.com ([166.70.13.232]:32898 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010546AbbGNSHoD2Wfc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Jul 2015 20:07:44 +0200
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.82)
        (envelope-from <ebiederm@xmission.com>)
        id 1ZF4cB-0008KX-DI; Tue, 14 Jul 2015 12:07:35 -0600
Received: from 67-3-205-90.omah.qwest.net ([67.3.205.90] helo=x220.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.82)
        (envelope-from <ebiederm@xmission.com>)
        id 1ZF4cA-0000HF-Jk; Tue, 14 Jul 2015 12:07:35 -0600
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
References: <20150713202611.GA16525@fifo99.com>
        <87h9p7r0we.fsf@x220.int.ebiederm.org>
        <20150714135919.GA18333@fifo99.com>
        <20150714150208.GD10792@redhat.com>
        <20150714153430.GA18766@fifo99.com> <20150714154040.GA3912@redhat.com>
        <20150714154833.GA18883@fifo99.com>
        <20150714161612.GH10792@redhat.com>
        <87a8uyoeig.fsf@x220.int.ebiederm.org>
        <20150714172953.GA19135@fifo99.com>
        <20150714175527.GI10792@redhat.com>
Date:   Tue, 14 Jul 2015 13:01:12 -0500
In-Reply-To: <20150714175527.GI10792@redhat.com> (Vivek Goyal's message of
        "Tue, 14 Jul 2015 13:55:27 -0400")
Message-ID: <87si8qmxef.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-AID: U2FsdGVkX1/O22/RKhEvkpEBGvhwo+e9R2lPzBkhfjs=
X-SA-Exim-Connect-IP: 67.3.205.90
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 1/3] panic: Disable crash_kexec_post_notifiers if kdump is not available
X-SA-Exim-Version: 4.2.1 (built Wed, 24 Sep 2014 11:00:52 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Return-Path: <ebiederm@xmission.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48297
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

> On Tue, Jul 14, 2015 at 05:29:53PM +0000, dwalker@fifo99.com wrote:
>
> [..]
>> > >> > If a machine is failing, there are high chance it can't deliver you the
>> > >> > notification. Detecting that failure suing some kind of polling mechanism
>> > >> > might be more reliable. And it will make even kdump mechanism more
>> > >> > reliable so that it does not have to run panic notifiers after the crash.
>> > >> 
>> > >> I think what your suggesting is that my company should change how it's hardware works
>> > >> and that's not really an option for me. This isn't a simple thing like checking over the
>> > >> network if the machine is down or not, this is way more complex hardware design.
>> > >
>> > > That means you are ready to live with an unreliable design. There might be
>> > > cases where notifier does not get run properly and you will not do switch
>> > > despite the fact that OS has failed. I was just trying to nudge you in
>> > > a direction which could be more reliable mechanism.
>> > 
>> > Sigh I see some deep confusion going on here.
>> > 
>> > The panic notifiers are just that panic notifiers.  They have not been
>> > nor should they be tied to kexec.   If those notifiers force a switch
>> > over of between machines I fail to see why you would care if it was
>> > kexec or another panic situation that is forcing that switchover.
>> 
>> Hidehiro isn't fixing the failover situation on my side, he's fixing register
>> information collection when crash_kexec_post_notifiers is used.
>
> Sure. Given that we have created this new parameter, let us fix it so that
> we can capture the other cpu register state in crash dump.
>
> I am little disappointed that it was not tested well when this parameter was
> introuced. We should have atleast tested it to the extent to see if there
> is proper cpu state present for all cpus in the crash dump.
>
> At that point of time it looked like a simple modification
> to allow panic notifiers before crash_kexec().

Either that or we say no one cares enough, and it known broken so let's
just revert the fool thing.

I honestly can't see how to support panic notifiers, before kexec.
There is no way to tell what is being done and all of the pieces
including smp_send_stop are known to be buggy.

It isn't like this latest set of patches was reviewed/tested much
better, as the first patch was wrong.

Eric
