Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Apr 2004 19:57:46 +0100 (BST)
Received: from mail1.fw-sj.sony.com ([IPv6:::ffff:160.33.82.68]:30411 "EHLO
	mail1.fw-sj.sony.com") by linux-mips.org with ESMTP
	id <S8225489AbUD2S5n>; Thu, 29 Apr 2004 19:57:43 +0100
Received: from mail3.sjc.in.sel.sony.com (mail3.sjc.in.sel.sony.com [43.134.1.211])
	by mail1.fw-sj.sony.com (8.12.11/8.12.11) with ESMTP id i3TIvATL021399;
	Thu, 29 Apr 2004 18:57:15 GMT
Received: from am.sony.com ([43.134.85.186])
	by mail3.sjc.in.sel.sony.com (8.12.11/8.12.11) with ESMTP id i3TIusQL020149;
	Thu, 29 Apr 2004 18:56:54 GMT
Message-ID: <40915265.2050906@am.sony.com>
Date: Thu, 29 Apr 2004 12:07:17 -0700
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>
CC: linux-arm-kernel@lists.arm.linux.org.uk, linux-mips@linux-mips.org,
	linux-sh-ctl@m17n.org,
	CE Linux Developers List <celinux-dev@tree.celinuxforum.org>
Subject: CONFIG_XIP_ROM vs. CONFIG_XIP_KERNEL
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <tim.bird@am.sony.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4925
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tim.bird@am.sony.com
Precedence: bulk
X-list: linux-mips

I'm looking at some sources for kernel Execute-in-place (XIP).

I see references to CONFIG_XIP_ROM and CONFIG_XIP_KERNEL,
in different architecture branches of the same kernel
source tree.

Is this difference merely the result of inconsistent
usage, or is there a functional difference between
these two options?

I can imagine that CONFIG_XIP_ROM is intended only to
handle XIP in ROM, and that CONFIG_XIP_KERNEL possibly
handles additional cases like XIP in flash.  However,
before jumping to that conclusion I thought I would
ask if there is some intention behind the different
config names.

Thanks,

=============================
Tim Bird
Architecture Group Co-Chair
CE Linux Forum
Senior Staff Engineer
Sony Electronics
E-mail: Tim.Bird (at) am.sony.com
=============================
