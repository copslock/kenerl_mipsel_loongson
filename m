Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jul 2015 17:02:15 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:48979 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009345AbbGNPCLj9MmF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Jul 2015 17:02:11 +0200
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        by mx1.redhat.com (Postfix) with ESMTPS id 8D7522CD7E9;
        Tue, 14 Jul 2015 15:02:09 +0000 (UTC)
Received: from horse.redhat.com (dhcp-25-235.bos.redhat.com [10.18.25.235])
        by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t6EF28eN011297;
        Tue, 14 Jul 2015 11:02:08 -0400
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 4D3BA20220E; Tue, 14 Jul 2015 11:02:08 -0400 (EDT)
Date:   Tue, 14 Jul 2015 11:02:08 -0400
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
Message-ID: <20150714150208.GD10792@redhat.com>
References: <20150710113331.4368.10495.stgit@softrs>
 <20150710113331.4368.63745.stgit@softrs>
 <87wpy82kqf.fsf@x220.int.ebiederm.org>
 <20150713202611.GA16525@fifo99.com>
 <87h9p7r0we.fsf@x220.int.ebiederm.org>
 <20150714135919.GA18333@fifo99.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150714135919.GA18333@fifo99.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Return-Path: <vgoyal@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48277
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

On Tue, Jul 14, 2015 at 01:59:19PM +0000, dwalker@fifo99.com wrote:
> On Mon, Jul 13, 2015 at 08:19:45PM -0500, Eric W. Biederman wrote:
> > dwalker@fifo99.com writes:
> > 
> > > On Fri, Jul 10, 2015 at 08:41:28AM -0500, Eric W. Biederman wrote:
> > >> Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com> writes:
> > >> 
> > >> > You can call panic notifiers and kmsg dumpers before kdump by
> > >> > specifying "crash_kexec_post_notifiers" as a boot parameter.
> > >> > However, it doesn't make sense if kdump is not available.  In that
> > >> > case, disable "crash_kexec_post_notifiers" boot parameter so that
> > >> > you can't change the value of the parameter.
> > >> 
> > >> Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>
> > >
> > > I think it would make sense if he just replaced "kdump" with "kexec".
> > 
> > It would be less insane, however it still makes no sense as without
> > kexec on panic support crash_kexec is a noop.  So the value of the
> > seeting makes no difference.
> 
> Can you explain more, I don't really understand what you mean. Are you suggesting
> the whole "crash_kexec_post_notifiers" feature has no value ?

Daniel,

BTW, why are you using crash_kexec_post_notifiers commandline? Why not
without it?

Thanks
Vivek
