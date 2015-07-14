Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jul 2015 15:59:44 +0200 (CEST)
Received: from ec2-54-201-57-178.us-west-2.compute.amazonaws.com ([54.201.57.178]:46824
        "EHLO ip-172-31-12-36.us-west-2.compute.internal"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27009828AbbGNN7m39QFu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Jul 2015 15:59:42 +0200
Received: by ip-172-31-12-36.us-west-2.compute.internal (Postfix, from userid 1001)
        id D927A4086C; Tue, 14 Jul 2015 13:59:19 +0000 (UTC)
Date:   Tue, 14 Jul 2015 13:59:19 +0000
From:   dwalker@fifo99.com
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vivek Goyal <vgoyal@redhat.com>, linux-mips@linux-mips.org,
        Baoquan He <bhe@redhat.com>, linux-sh@vger.kernel.org,
        linux-s390@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>,
        Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
        linuxppc-dev@lists.ozlabs.org, linux-metag@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] panic: Disable crash_kexec_post_notifiers if kdump
 is not available
Message-ID: <20150714135919.GA18333@fifo99.com>
References: <20150710113331.4368.10495.stgit@softrs>
 <20150710113331.4368.63745.stgit@softrs>
 <87wpy82kqf.fsf@x220.int.ebiederm.org>
 <20150713202611.GA16525@fifo99.com>
 <87h9p7r0we.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h9p7r0we.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <dwalker@fifo99.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48274
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dwalker@fifo99.com
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

On Mon, Jul 13, 2015 at 08:19:45PM -0500, Eric W. Biederman wrote:
> dwalker@fifo99.com writes:
> 
> > On Fri, Jul 10, 2015 at 08:41:28AM -0500, Eric W. Biederman wrote:
> >> Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com> writes:
> >> 
> >> > You can call panic notifiers and kmsg dumpers before kdump by
> >> > specifying "crash_kexec_post_notifiers" as a boot parameter.
> >> > However, it doesn't make sense if kdump is not available.  In that
> >> > case, disable "crash_kexec_post_notifiers" boot parameter so that
> >> > you can't change the value of the parameter.
> >> 
> >> Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>
> >
> > I think it would make sense if he just replaced "kdump" with "kexec".
> 
> It would be less insane, however it still makes no sense as without
> kexec on panic support crash_kexec is a noop.  So the value of the
> seeting makes no difference.

Can you explain more, I don't really understand what you mean. Are you suggesting
the whole "crash_kexec_post_notifiers" feature has no value ?

Daniel
