Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jul 2015 18:16:19 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:39055 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009269AbbGNQQSFwckY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Jul 2015 18:16:18 +0200
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        by mx1.redhat.com (Postfix) with ESMTPS id 68A1F3672AE;
        Tue, 14 Jul 2015 16:16:13 +0000 (UTC)
Received: from horse.redhat.com (dhcp-25-235.bos.redhat.com [10.18.25.235])
        by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t6EGGCRs004145;
        Tue, 14 Jul 2015 12:16:12 -0400
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 2A2602022D5; Tue, 14 Jul 2015 12:16:12 -0400 (EDT)
Date:   Tue, 14 Jul 2015 12:16:12 -0400
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
Message-ID: <20150714161612.GH10792@redhat.com>
References: <20150710113331.4368.10495.stgit@softrs>
 <20150710113331.4368.63745.stgit@softrs>
 <87wpy82kqf.fsf@x220.int.ebiederm.org>
 <20150713202611.GA16525@fifo99.com>
 <87h9p7r0we.fsf@x220.int.ebiederm.org>
 <20150714135919.GA18333@fifo99.com>
 <20150714150208.GD10792@redhat.com>
 <20150714153430.GA18766@fifo99.com>
 <20150714154040.GA3912@redhat.com>
 <20150714154833.GA18883@fifo99.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150714154833.GA18883@fifo99.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Return-Path: <vgoyal@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48282
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

On Tue, Jul 14, 2015 at 03:48:33PM +0000, dwalker@fifo99.com wrote:
> On Tue, Jul 14, 2015 at 11:40:40AM -0400, Vivek Goyal wrote:
> > On Tue, Jul 14, 2015 at 03:34:30PM +0000, dwalker@fifo99.com wrote:
> > > On Tue, Jul 14, 2015 at 11:02:08AM -0400, Vivek Goyal wrote:
> > > > On Tue, Jul 14, 2015 at 01:59:19PM +0000, dwalker@fifo99.com wrote:
> > > > > On Mon, Jul 13, 2015 at 08:19:45PM -0500, Eric W. Biederman wrote:
> > > > > > dwalker@fifo99.com writes:
> > > > > > 
> > > > > > > On Fri, Jul 10, 2015 at 08:41:28AM -0500, Eric W. Biederman wrote:
> > > > > > >> Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com> writes:
> > > > > > >> 
> > > > > > >> > You can call panic notifiers and kmsg dumpers before kdump by
> > > > > > >> > specifying "crash_kexec_post_notifiers" as a boot parameter.
> > > > > > >> > However, it doesn't make sense if kdump is not available.  In that
> > > > > > >> > case, disable "crash_kexec_post_notifiers" boot parameter so that
> > > > > > >> > you can't change the value of the parameter.
> > > > > > >> 
> > > > > > >> Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>
> > > > > > >
> > > > > > > I think it would make sense if he just replaced "kdump" with "kexec".
> > > > > > 
> > > > > > It would be less insane, however it still makes no sense as without
> > > > > > kexec on panic support crash_kexec is a noop.  So the value of the
> > > > > > seeting makes no difference.
> > > > > 
> > > > > Can you explain more, I don't really understand what you mean. Are you suggesting
> > > > > the whole "crash_kexec_post_notifiers" feature has no value ?
> > > > 
> > > > Daniel,
> > > > 
> > > > BTW, why are you using crash_kexec_post_notifiers commandline? Why not
> > > > without it?
> > > 
> > > It was explained in the prior thread but to rehash, the notifiers are used to do a switch
> > > over from the crashed machine to another redundant machine.
> > 
> > So why not detect failure using polling or issue notifications from second
> > kernel.
> > 
> > IOW, expecting that a crashed machine will be able to deliver notification
> > reliably is falwed to begin with, IMHO.
> 
> It's flawed to think you can kexec, but you still do it right ? I've not gotten into
> the deep details of this switching process, but that's how this interface is used.

Sure. But the deal here is that users of interface know that sometimes it
can be unreliable. And in the absence of more reliable mechanism, somewhat
less reliable mechanism is fine. 

>  
> > If a machine is failing, there are high chance it can't deliver you the
> > notification. Detecting that failure suing some kind of polling mechanism
> > might be more reliable. And it will make even kdump mechanism more
> > reliable so that it does not have to run panic notifiers after the crash.
> 
> I think what your suggesting is that my company should change how it's hardware works
> and that's not really an option for me. This isn't a simple thing like checking over the
> network if the machine is down or not, this is way more complex hardware design.

That means you are ready to live with an unreliable design. There might be
cases where notifier does not get run properly and you will not do switch
despite the fact that OS has failed. I was just trying to nudge you in
a direction which could be more reliable mechanism.

Thanks
Vivek
