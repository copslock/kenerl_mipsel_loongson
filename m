Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jul 2015 22:26:33 +0200 (CEST)
Received: from ec2-54-201-57-178.us-west-2.compute.amazonaws.com ([54.201.57.178]:46769
        "EHLO ip-172-31-12-36.us-west-2.compute.internal"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27011028AbbGMU0cQ9BFV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 13 Jul 2015 22:26:32 +0200
Received: by ip-172-31-12-36.us-west-2.compute.internal (Postfix, from userid 1001)
        id 19441407F3; Mon, 13 Jul 2015 20:26:11 +0000 (UTC)
Date:   Mon, 13 Jul 2015 20:26:11 +0000
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
Message-ID: <20150713202611.GA16525@fifo99.com>
References: <20150710113331.4368.10495.stgit@softrs>
 <20150710113331.4368.63745.stgit@softrs>
 <87wpy82kqf.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wpy82kqf.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <dwalker@fifo99.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48230
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

On Fri, Jul 10, 2015 at 08:41:28AM -0500, Eric W. Biederman wrote:
> Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com> writes:
> 
> > You can call panic notifiers and kmsg dumpers before kdump by
> > specifying "crash_kexec_post_notifiers" as a boot parameter.
> > However, it doesn't make sense if kdump is not available.  In that
> > case, disable "crash_kexec_post_notifiers" boot parameter so that
> > you can't change the value of the parameter.
> 
> Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>

I think it would make sense if he just replaced "kdump" with "kexec".

Daniel
