Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Dec 2002 13:58:22 +0000 (GMT)
Received: from [IPv6:::ffff:209.226.172.94] ([IPv6:::ffff:209.226.172.94]:33974
	"EHLO semigate.zarlink.com") by linux-mips.org with ESMTP
	id <S8225220AbSLPN6V>; Mon, 16 Dec 2002 13:58:21 +0000
Received: from ottmta01.zarlink.com (ottmta01 [134.199.14.110])
	by semigate.zarlink.com (8.10.2+Sun/8.10.2) with ESMTP id gBGDwEL29829
	for <linux-mips@linux-mips.org>; Mon, 16 Dec 2002 08:58:14 -0500 (EST)
Subject: Problems with CONFIG_PREEMPT
To: linux-mips@linux-mips.org
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OF9DA9DC55.9D9F4E46-ON80256C91.002C0064@zarlink.com>
From: Colin.Helliwell@Zarlink.Com
Date: Mon, 16 Dec 2002 13:58:11 +0000
X-MIMETrack: Serialize by Router on ottmta01/Semi(Release 5.0.11  |July 24, 2002) at 12/16/2002
 08:58:13 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Return-Path: <Colin.Helliwell@Zarlink.Com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 896
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Colin.Helliwell@Zarlink.Com
Precedence: bulk
X-list: linux-mips

I've been porting the MIPS kernel to our system-on-chip hardware
(4KEc-based) and have encountered a problem with a pre-emptible patch. The
original kernel was the 2.4.19 from the CVS server, onto which I applied
Robert Love's preemptible patch (preempt-kernel-rml-2.4.19-2.patch), plus
the addition of a #include to softirq.h, and a missing definition for
release_irqlock() in hardirq.h.
I've found that when CONFIG_PREEMPT is set, it no longer loads the
(non-compressed) initrd correctly - about 1.8MB through loading (2MB total)
I get a Data Bus Error. A typical call trace shown by the oops is shown
below, and looks a little 'confused' to me, so I'm thinking there may be
some stack corruption going on?

Address         Function

801174fc        tasklet_hi_action
801af0a4        printChipInfo
801af0a4        printChipInfo
8013bf50        sys_write
801089c4        stack_done
80108b28        reschedule
801133d0        _call_console_drivers
80113ad8        release_console_sem
80113848        printk
801506b8        sys_ioctl
801af0f8        printChipInfo
8014ccd4        sys_mkdir
801af0a4        printChipInfo
80100470        init
80100470        init
80100840        prepare_namespace
80100470        init
8010049c        init
8010352c        kernel_thread
80100420        _stext
8010351c        kernel_thread


I wondered if anyone had any thoughts about what might be causing this, or
had seen this occuring before - were there perhaps some changes made just
after this point in time (now in the 2.5.x kernel)?



Thanks.
