Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Jun 2015 14:26:21 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:36490 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009543AbbF2M0TeT10w (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 29 Jun 2015 14:26:19 +0200
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        by mx1.redhat.com (Postfix) with ESMTPS id 23F6E3A80FA;
        Mon, 29 Jun 2015 12:26:17 +0000 (UTC)
Received: from horse.redhat.com (dhcp-25-105.bos.redhat.com [10.18.25.105])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t5TCQGC1016197;
        Mon, 29 Jun 2015 08:26:16 -0400
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 9F9E1201279; Mon, 29 Jun 2015 08:26:15 -0400 (EDT)
Date:   Mon, 29 Jun 2015 08:26:15 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Cc:     dwalker@fifo99.com,
        Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        david.daney@cavium.com, d.hatayama@jp.fujitsu.com,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org
Subject: Re: kexec crash kernel running with watchdog enabled
Message-ID: <20150629122615.GA20058@redhat.com>
References: <20150623140548.GA15591@fifo99.com>
 <558A53C0.5030700@hitachi.com>
 <20150624163141.GA20456@fifo99.com>
 <558CA488.4030400@hitachi.com>
 <20150626183302.GA26853@fifo99.com>
 <55911599.3030607@hitachi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55911599.3030607@hitachi.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
Return-Path: <vgoyal@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48044
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

On Mon, Jun 29, 2015 at 06:53:29PM +0900, Hidehiro Kawai wrote:
> Hi,
> 
> (2015/06/27 3:33), dwalker@fifo99.com wrote:> On Fri, Jun 26, 2015 at 10:02:00AM +0900, Hidehiro Kawai wrote:
> >> Hi,
> >>
> >> (2015/06/25 1:31), dwalker@fifo99.com wrote:
> >>> On Wed, Jun 24, 2015 at 03:52:48PM +0900, Masami Hiramatsu wrote:
> >>>> Hi,
> >>>>
> >>>> On 2015/06/23 23:05, dwalker@fifo99.com wrote:
> >>>>>
> >>>>> Hi,
> >>>>>
> >>>>> There was a commit in kernel/panic.c which altered when the kexec crash kernel is executed,
> >>>>>
> >>>>> commit f06e5153f4ae2e2f3b0300f0e260e40cb7fefd45
> >>>>> Author: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
> >>>>> Date:   Fri Jun 6 14:37:07 2014 -0700
> >>>>>
> >>>>>     kernel/panic.c: add "crash_kexec_post_notifiers" option for kdump after panic_notifers
> >>>>>
> >>>>>
> >>>>> This made it possible for smp_send_stop() to be executed prior to calling the kexec crash
> >>>>> kernel.
> >>>>>
> >>>>> The issue is that smp_send_stop() offlines the cores, and other code depend on the cores being online.
> >>>>>
> >>>>> In my case on Octeon here's an example,
> >>>>>
> >>>>> panic()
> >>>>>  crash_kexec()
> >>>>>   machine_crash_shutdown()
> >>>>>    octeon_generic_shutdown()
> >>>>>
> >>>>> Inside octeon_generic_shutdown() the Octeon watchdog is shutdown for_each_online_cpu(), but since
> >>>>> most of the cpu's already got offlined in smp_send_stop() it means the watchdog is still alive on
> >>>>> those cores. This results in a reboot during the crash kernel execution.
> >>>>
> >>>> Ah, I see.
> >>>>
> >>>>> Another example seem to be in default_machine_crash_shutdown() where crash_kexec_prepare_cpus() depends
> >>>>> on an IPI for saving the registers on different cores. However, the cpu's are all offlined with
> >>>>> interrupts disabled so they won't be running those IPI's in this case.
> >>>>>
> >>>>> I'm looking for any advice on how this should be fixed, or if it's already fixed. I'm not going to be
> >>>>> submitting a patch so if anyone wants to submit one feel free to do so.
> >>>>
> >>>> Hmm, IMHO, when the cpu goes to offline in appropriate way(smp_send_stop), it should stop
> >>>> watchdog timer on the offlined cpu too.
> >>>> Or, you can also register crash handler which stops all watchdogs, but it's a bit tricky.
> >>>>
> >>>
> >>> That doesn't really fix all the issue tho. As I was explaining generic MIPS code depends on the cpu's
> >>> effectively being online for crash data collection (with an IPI). This issue may effect other architectures also,
> >>> because smp_send_stop() offlines the cpu on other architectures also. I haven't surveyed the other architectures
> >>> enough to know what issue could happen from this tho.
> >>>
> >>> Is it possible to move the smp_send_stop() below the notifiers ? I'm just throwing out ideas.
> >>
> >> No, that doesn't works.  Some notifiers assume that they run in
> >> single core mode.
> >>
> >> Another possible solution is to add notifiers just after
> >> machine_crash_shutdown() like this:
> >>
> >> void panic(const char *fmt, ...)
> >> ...
> >> -	if (!crash_kexec_post_notifiers)
> >> -		crash_kexec(NULL);
> >> +	crash_kexec(NULL, buf);
> >>
> >>   and
> >>
> >> -void crash_kexec(struct pt_regs *regs)
> >> +void crash_kexec(struct pt_regs *regs, char *msg)
> >>  ...
> >>  		if (kexec_crash_image) {
> >>  			struct pt_regs fixed_regs;
> >>  
> >>  			crash_setup_regs(&fixed_regs, regs);
> >>  			crash_save_vmcoreinfo();
> >>  			machine_crash_shutdown(&fixed_regs);
> >> +			if (crash_kexec_post_notifiers) {
> >> +				kmsg_dump(KMSG_DUMP_PANIC);
> >> +				atomic_notifier_call_chain(&panic_notifier_list, 0, msg);
> >> +			}
> >>                         machine_kexec(kexec_crash_image);
> >>
> >> Most of archs stop other cores in machine_crash_shutdown(),
> >> so it will work well.  Furthermore, it simplifies the special
> >> case where crash_kexec() is called without entering panic().
> >>
> >> However, we need some tweaks for sh and s390 cases.  As for sh,
> >> it seems not to stop other cores in the crash_kexec() sequence
> >> (kdump support is incompleted?).  For s390, smp_send_stop() is
> >> called in machine_kexec() but not machine_crash_shutdown().
> > 
> > You could add an ifdef into the __setup() to filter out s390 and sh, until we figure out what
> > to do there. So the "crash_kexec_post_notifiers" wouldn't be available for those platforms.
> 
> I agree on disabling the "crash_kexec_post_notifiers" feature for
> s390 and sh at this time.  Also, we should make this feature effective
> only if CONFIG_CRASH_DUMP=y.  Otherwise, it makes no sense.
> 
> I'll prepare the bug fix patch.  Please wait a moment.

Why to add a patch for that. Just inform the user that don't need
crash_kexec_post_notifiers on s390 and sh?

Thanks
Vivek
