Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Jun 2015 16:07:34 +0200 (CEST)
Received: from ec2-54-201-57-178.us-west-2.compute.amazonaws.com ([54.201.57.178]:53289
        "EHLO ip-172-31-12-36.us-west-2.compute.internal"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27008947AbbFWOHbzojeh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 23 Jun 2015 16:07:31 +0200
Received: by ip-172-31-12-36.us-west-2.compute.internal (Postfix, from userid 1001)
        id 2491B40215; Tue, 23 Jun 2015 14:05:48 +0000 (UTC)
Date:   Tue, 23 Jun 2015 14:05:48 +0000
From:   dwalker@fifo99.com
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        masami.hiramatsu.pt@hitachi.com, david.daney@cavium.com
Subject: kexec crash kernel running with watchdog enabled
Message-ID: <20150623140548.GA15591@fifo99.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <dwalker@fifo99.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48010
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


Hi,

There was a commit in kernel/panic.c which altered when the kexec crash kernel is executed,

commit f06e5153f4ae2e2f3b0300f0e260e40cb7fefd45
Author: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Date:   Fri Jun 6 14:37:07 2014 -0700

    kernel/panic.c: add "crash_kexec_post_notifiers" option for kdump after panic_notifers


This made it possible for smp_send_stop() to be executed prior to calling the kexec crash
kernel.

The issue is that smp_send_stop() offlines the cores, and other code depend on the cores being online.

In my case on Octeon here's an example,

panic()
 crash_kexec()
  machine_crash_shutdown()
   octeon_generic_shutdown()

Inside octeon_generic_shutdown() the Octeon watchdog is shutdown for_each_online_cpu(), but since
most of the cpu's already got offlined in smp_send_stop() it means the watchdog is still alive on
those cores. This results in a reboot during the crash kernel execution.

Another example seem to be in default_machine_crash_shutdown() where crash_kexec_prepare_cpus() depends
on an IPI for saving the registers on different cores. However, the cpu's are all offlined with
interrupts disabled so they won't be running those IPI's in this case.

I'm looking for any advice on how this should be fixed, or if it's already fixed. I'm not going to be
submitting a patch so if anyone wants to submit one feel free to do so.

Daniel
