Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Jun 2015 22:18:17 +0200 (CEST)
Received: from ec2-54-201-57-178.us-west-2.compute.amazonaws.com ([54.201.57.178]:53427
        "EHLO ip-172-31-12-36.us-west-2.compute.internal"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27009456AbbFYUSPpfjV0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 25 Jun 2015 22:18:15 +0200
Received: by ip-172-31-12-36.us-west-2.compute.internal (Postfix, from userid 1001)
        id A7803407AE; Thu, 25 Jun 2015 20:16:26 +0000 (UTC)
Date:   Thu, 25 Jun 2015 20:16:26 +0000
From:   dwalker@fifo99.com
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        david.daney@cavium.com, d.hatayama@jp.fujitsu.com,
        vgoyal@redhat.com, hidehiro.kawai.ez@hitachi.com,
        linux-kernel@vger.kernel.org
Subject: Re: kexec crash kernel running with watchdog enabled
Message-ID: <20150625201626.GA24392@fifo99.com>
References: <20150623140548.GA15591@fifo99.com>
 <558A53C0.5030700@hitachi.com>
 <20150624163141.GA20456@fifo99.com>
 <87fv5hc9z8.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fv5hc9z8.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <dwalker@fifo99.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48032
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

On Wed, Jun 24, 2015 at 12:06:03PM -0500, Eric W. Biederman wrote:
> dwalker@fifo99.com writes:
> 
> > On Wed, Jun 24, 2015 at 03:52:48PM +0900, Masami Hiramatsu wrote:
> >> Hi,
> >> 
> >> On 2015/06/23 23:05, dwalker@fifo99.com wrote:
> >> > 
> >> > Hi,
> >> > 
> >> > There was a commit in kernel/panic.c which altered when the kexec crash kernel is executed,
> >> > 
> >> > commit f06e5153f4ae2e2f3b0300f0e260e40cb7fefd45
> >> > Author: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
> >> > Date:   Fri Jun 6 14:37:07 2014 -0700
> >> > 
> >> >     kernel/panic.c: add "crash_kexec_post_notifiers" option for kdump after panic_notifers
> >> > 
> >> > 
> >> > This made it possible for smp_send_stop() to be executed prior to calling the kexec crash
> >> > kernel.
> >> > 
> >> > The issue is that smp_send_stop() offlines the cores, and other code depend on the cores being online.
> >> > 
> >> > In my case on Octeon here's an example,
> >> > 
> >> > panic()
> >> >  crash_kexec()
> >> >   machine_crash_shutdown()
> >> >    octeon_generic_shutdown()
> >> > 
> >> > Inside octeon_generic_shutdown() the Octeon watchdog is shutdown for_each_online_cpu(), but since
> >> > most of the cpu's already got offlined in smp_send_stop() it means the watchdog is still alive on
> >> > those cores. This results in a reboot during the crash kernel execution.
> >> 
> >> Ah, I see.
> >> 
> >> > Another example seem to be in default_machine_crash_shutdown() where crash_kexec_prepare_cpus() depends
> >> > on an IPI for saving the registers on different cores. However, the cpu's are all offlined with
> >> > interrupts disabled so they won't be running those IPI's in this case.
> >> > 
> >> > I'm looking for any advice on how this should be fixed, or if it's already fixed. I'm not going to be
> >> > submitting a patch so if anyone wants to submit one feel free to do so.
> >> 
> >> Hmm, IMHO, when the cpu goes to offline in appropriate way(smp_send_stop), it should stop
> >> watchdog timer on the offlined cpu too.
> >> Or, you can also register crash handler which stops all watchdogs, but it's a bit tricky.
> >> 
> >
> > That doesn't really fix all the issue tho. As I was explaining generic MIPS code depends on the cpu's
> > effectively being online for crash data collection (with an IPI). This issue may effect other architectures also,
> > because smp_send_stop() offlines the cpu on other architectures also. I haven't surveyed the other architectures
> > enough to know what issue could happen from this tho.
> >
> > Is it possible to move the smp_send_stop() below the notifiers ? I'm
> > just throwing out ideas.
> 
> In general if you want reliability don't pass the kernel command line to
> run the panic notifiers.


We use the panic notifiers to "fail over" , or switch to a working machine. We could do
that in the crash kernel, but we would have to wait several seconds which is too long. Do
you know of a more stable way to accomplish that ?

Daniel
