Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jun 2015 19:11:37 +0200 (CEST)
Received: from out03.mta.xmission.com ([166.70.13.233]:35875 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008941AbbFXRLfqHi3u (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Jun 2015 19:11:35 +0200
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.82)
        (envelope-from <ebiederm@xmission.com>)
        id 1Z7oCt-0000Bz-1W; Wed, 24 Jun 2015 11:11:27 -0600
Received: from 67-3-205-90.omah.qwest.net ([67.3.205.90] helo=x220.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.82)
        (envelope-from <ebiederm@xmission.com>)
        id 1Z7oCs-000144-2S; Wed, 24 Jun 2015 11:11:26 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     dwalker@fifo99.com
Cc:     Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        david.daney@cavium.com, d.hatayama@jp.fujitsu.com,
        vgoyal@redhat.com, hidehiro.kawai.ez@hitachi.com,
        linux-kernel@vger.kernel.org
References: <20150623140548.GA15591@fifo99.com> <558A53C0.5030700@hitachi.com>
        <20150624163141.GA20456@fifo99.com>
Date:   Wed, 24 Jun 2015 12:06:03 -0500
In-Reply-To: <20150624163141.GA20456@fifo99.com> (dwalker@fifo99.com's message
        of "Wed, 24 Jun 2015 16:31:41 +0000")
Message-ID: <87fv5hc9z8.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-AID: U2FsdGVkX18oDGIRuGGE7iEewrO5YMKKA2SAkx8NsLU=
X-SA-Exim-Connect-IP: 67.3.205.90
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: kexec crash kernel running with watchdog enabled
X-SA-Exim-Version: 4.2.1 (built Wed, 24 Sep 2014 11:00:52 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Return-Path: <ebiederm@xmission.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48024
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

dwalker@fifo99.com writes:

> On Wed, Jun 24, 2015 at 03:52:48PM +0900, Masami Hiramatsu wrote:
>> Hi,
>> 
>> On 2015/06/23 23:05, dwalker@fifo99.com wrote:
>> > 
>> > Hi,
>> > 
>> > There was a commit in kernel/panic.c which altered when the kexec crash kernel is executed,
>> > 
>> > commit f06e5153f4ae2e2f3b0300f0e260e40cb7fefd45
>> > Author: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
>> > Date:   Fri Jun 6 14:37:07 2014 -0700
>> > 
>> >     kernel/panic.c: add "crash_kexec_post_notifiers" option for kdump after panic_notifers
>> > 
>> > 
>> > This made it possible for smp_send_stop() to be executed prior to calling the kexec crash
>> > kernel.
>> > 
>> > The issue is that smp_send_stop() offlines the cores, and other code depend on the cores being online.
>> > 
>> > In my case on Octeon here's an example,
>> > 
>> > panic()
>> >  crash_kexec()
>> >   machine_crash_shutdown()
>> >    octeon_generic_shutdown()
>> > 
>> > Inside octeon_generic_shutdown() the Octeon watchdog is shutdown for_each_online_cpu(), but since
>> > most of the cpu's already got offlined in smp_send_stop() it means the watchdog is still alive on
>> > those cores. This results in a reboot during the crash kernel execution.
>> 
>> Ah, I see.
>> 
>> > Another example seem to be in default_machine_crash_shutdown() where crash_kexec_prepare_cpus() depends
>> > on an IPI for saving the registers on different cores. However, the cpu's are all offlined with
>> > interrupts disabled so they won't be running those IPI's in this case.
>> > 
>> > I'm looking for any advice on how this should be fixed, or if it's already fixed. I'm not going to be
>> > submitting a patch so if anyone wants to submit one feel free to do so.
>> 
>> Hmm, IMHO, when the cpu goes to offline in appropriate way(smp_send_stop), it should stop
>> watchdog timer on the offlined cpu too.
>> Or, you can also register crash handler which stops all watchdogs, but it's a bit tricky.
>> 
>
> That doesn't really fix all the issue tho. As I was explaining generic MIPS code depends on the cpu's
> effectively being online for crash data collection (with an IPI). This issue may effect other architectures also,
> because smp_send_stop() offlines the cpu on other architectures also. I haven't surveyed the other architectures
> enough to know what issue could happen from this tho.
>
> Is it possible to move the smp_send_stop() below the notifiers ? I'm
> just throwing out ideas.

In general if you want reliability don't pass the kernel command line to
run the panic notifiers.

Eric
