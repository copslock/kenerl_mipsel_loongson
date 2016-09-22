Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Sep 2016 03:54:22 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:55200 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992096AbcIVByOGTL5O (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 22 Sep 2016 03:54:14 +0200
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 34545C05A2B9;
        Thu, 22 Sep 2016 01:54:07 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com ([10.66.131.142])
        by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u8M1rtAh002226
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 21 Sep 2016 21:53:58 -0400
Date:   Thu, 22 Sep 2016 09:53:54 +0800
From:   "'Dave Young'" <dyoung@redhat.com>
To:     =?utf-8?B?5rKz5ZCI6Iux5a6PIC8gS0FXQUnvvIxISURFSElSTw==?= 
        <hidehiro.kawai.ez@hitachi.com>
Cc:     "xlpang@redhat.com" <xlpang@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Walker <dwalker@fifo99.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Baoquan He <bhe@redhat.com>, Toshi Kani <toshi.kani@hpe.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, Vivek Goyal <vgoyal@redhat.com>,
        David Vrabel <david.vrabel@citrix.com>
Subject: Re: [V4 PATCH 1/2] x86/panic: Replace smp_send_stop() with kdump
 friendly version in panic path
Message-ID: <20160922015354.GA12860@dhcp-128-65.nay.redhat.com>
References: <20160810080946.11028.97686.stgit@sysi4-13.yrl.intra.hitachi.co.jp>
 <20160810080948.11028.15344.stgit@sysi4-13.yrl.intra.hitachi.co.jp>
 <20160812031633.GA2983@dhcp-128-65.nay.redhat.com>
 <04EAB7311EE43145B2D3536183D1A84454CBBABC@GSjpTKYDCembx31.service.hitachi.net>
 <57E0E7EC.2010704@redhat.com>
 <04EAB7311EE43145B2D3536183D1A84454D0FECC@GSjpTKYDCembx31.service.hitachi.net>
 <04EAB7311EE43145B2D3536183D1A84454D101A4@GSjpTKYDCembx31.service.hitachi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <04EAB7311EE43145B2D3536183D1A84454D101A4@GSjpTKYDCembx31.service.hitachi.net>
User-Agent: Mutt/1.7.0 (2016-08-17)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.26
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 22 Sep 2016 01:54:07 +0000 (UTC)
Return-Path: <dyoung@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55226
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dyoung@redhat.com
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

Hi, 河合英宏

Thanks for the patch log update, it looks good to me.

Acked-by: Dave Young <dyoung@redhat.com>

On 09/20/16 at 11:22am, 河合英宏 / KAWAI，HIDEHIRO wrote:
> Here is the revised commit description reflecting Dave's
> comment.  Cc list was copied from -mm version.
> 
> From: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
> Subject: x86/panic: replace smp_send_stop() with kdump friendly version in panic path
> 
> This patch fixes a problem reported by Daniel Walker
> (https://lkml.org/lkml/2015/6/24/44).
> 
> When kernel panics with crash_kexec_post_notifiers kernel parameter
> enabled, other CPUs are stopped by smp_send_stop() instead of
> machine_crash_shutdown() in __crash_kexec() path.
> 
>   panic()
>     if crash_kexec_post_notifiers == 1
>       smp_send_stop()
>       atomic_notifier_call_chain()
>       kmsg_dump()
>     __crash_kexec()
>       machine_crash_shutdown()
> 
> Different from smp_send_stop(), machine_crash_shutdown() stops other
> CPUs with extra works for kdump.  So, if smp_send_stop() stops other
> CPUs in advance, these extra works won't be done.  For x86, kdump
> routines miss to save other CPUs' registers and disable virtualization
> extensions.
> 
> To fix this problem, call a new kdump friendly function,
> crash_smp_send_stop(), instead of the smp_send_stop() when
> crash_kexec_post_notifiers is enabled.  crash_smp_send_stop() is a
> weak function, and it just call smp_send_stop().  Architecture
> codes should override it so that kdump can work appropriately.
> This patch only provides x86-specific version.
> 
> For Xen's PV kernel, just keep the current behavior.
> As for Dom0, it doesn't use crash_kexec routines, and it relies on
> panic notifier chain.  At the end of the chain, a hypercall is
> issued which requests the hypervisor to execute kdump.  This means
> regardless of crash_kexec_post_notifiers setting, smp_send_stop().
> For PV HVM, it would work similarly to baremetal kernels with extra
> cleanups for hypervisor.  It doesn't need additional care.
> 
> Changes in V4:
> - Keep to use smp_send_stop if crash_kexec_post_notifiers is not set
> - Rename panic_smp_send_stop to crash_smp_send_stop
> - Don't change the behavior for Xen's PV kernel
> 
> Changes in V3:
> - Revise comments, description, and symbol names
> 
> Changes in V2:
> - Replace smp_send_stop() call with crash_kexec version which
>   saves cpu states and cleans up VMX/SVM
> - Drop a fix for Problem 1 at this moment
> 
> Fixes: f06e5153f4ae (kernel/panic.c: add "crash_kexec_post_notifiers" option)
> Link: http://lkml.kernel.org/r/20160810080948.11028.15344.stgit@sysi4-13.yrl.intra.hitachi.co.jp
> Signed-off-by: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
> Reported-by: Daniel Walker <dwalker@fifo99.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Daniel Walker <dwalker@fifo99.com>
> Cc: Xunlei Pang <xpang@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: David Vrabel <david.vrabel@citrix.com>
> Cc: Toshi Kani <toshi.kani@hpe.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: David Daney <david.daney@cavium.com>
> Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
> Cc: "Steven J. Hill" <steven.hill@cavium.com>
> Cc: Corey Minyard <cminyard@mvista.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> 

[snip]

Thanks
Dave
