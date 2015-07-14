Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jul 2015 19:55:31 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:51899 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010546AbbGNRzaHbsHc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Jul 2015 19:55:30 +0200
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        by mx1.redhat.com (Postfix) with ESMTPS id 089912CD82B;
        Tue, 14 Jul 2015 17:55:28 +0000 (UTC)
Received: from horse.redhat.com (dhcp-25-235.bos.redhat.com [10.18.25.235])
        by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t6EHtR9r014519;
        Tue, 14 Jul 2015 13:55:27 -0400
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 210EF202DF2; Tue, 14 Jul 2015 13:55:27 -0400 (EDT)
Date:   Tue, 14 Jul 2015 13:55:27 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     dwalker@fifo99.com
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>,
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
Message-ID: <20150714175527.GI10792@redhat.com>
References: <20150713202611.GA16525@fifo99.com>
 <87h9p7r0we.fsf@x220.int.ebiederm.org>
 <20150714135919.GA18333@fifo99.com>
 <20150714150208.GD10792@redhat.com>
 <20150714153430.GA18766@fifo99.com>
 <20150714154040.GA3912@redhat.com>
 <20150714154833.GA18883@fifo99.com>
 <20150714161612.GH10792@redhat.com>
 <87a8uyoeig.fsf@x220.int.ebiederm.org>
 <20150714172953.GA19135@fifo99.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150714172953.GA19135@fifo99.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.26
Return-Path: <vgoyal@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48295
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vgoyal@redhat.com
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

On Tue, Jul 14, 2015 at 05:29:53PM +0000, dwalker@fifo99.com wrote:

[..]
> > >> > If a machine is failing, there are high chance it can't deliver you the
> > >> > notification. Detecting that failure suing some kind of polling mechanism
> > >> > might be more reliable. And it will make even kdump mechanism more
> > >> > reliable so that it does not have to run panic notifiers after the crash.
> > >> 
> > >> I think what your suggesting is that my company should change how it's hardware works
> > >> and that's not really an option for me. This isn't a simple thing like checking over the
> > >> network if the machine is down or not, this is way more complex hardware design.
> > >
> > > That means you are ready to live with an unreliable design. There might be
> > > cases where notifier does not get run properly and you will not do switch
> > > despite the fact that OS has failed. I was just trying to nudge you in
> > > a direction which could be more reliable mechanism.
> > 
> > Sigh I see some deep confusion going on here.
> > 
> > The panic notifiers are just that panic notifiers.  They have not been
> > nor should they be tied to kexec.   If those notifiers force a switch
> > over of between machines I fail to see why you would care if it was
> > kexec or another panic situation that is forcing that switchover.
> 
> Hidehiro isn't fixing the failover situation on my side, he's fixing register
> information collection when crash_kexec_post_notifiers is used.

Sure. Given that we have created this new parameter, let us fix it so that
we can capture the other cpu register state in crash dump.

I am little disappointed that it was not tested well when this parameter was
introuced. We should have atleast tested it to the extent to see if there
is proper cpu state present for all cpus in the crash dump.

At that point of time it looked like a simple modification
to allow panic notifiers before crash_kexec().

Thanks
Vivek
