Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Aug 2015 13:06:19 +0200 (CEST)
Received: from mail4.hitachi.co.jp ([133.145.228.5]:55440 "EHLO
        mail4.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011126AbbHCLGOlB9v0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 3 Aug 2015 13:06:14 +0200
Received: from mlsv1.hitachi.co.jp (unknown [133.144.234.166])
        by mail4.hitachi.co.jp (Postfix) with ESMTP id 5B2532CF4C5;
        Mon,  3 Aug 2015 20:06:09 +0900 (JST)
Received: from mfilter06.hitachi.co.jp by mlsv1.hitachi.co.jp (8.13.1/8.13.1) id t73B69vl029248; Mon, 3 Aug 2015 20:06:09 +0900
Received: from vshuts01.hitachi.co.jp (vshuts01.hitachi.co.jp [10.201.6.83])
        by mfilter06.hitachi.co.jp (Switch-3.3.4/Switch-3.3.4) with ESMTP id t73B68xF022793;
        Mon, 3 Aug 2015 20:06:08 +0900
Received: from hsdlmain.sdl.hitachi.co.jp (unknown [133.144.14.194])
        by vshuts01.hitachi.co.jp (Postfix) with ESMTP id C07112F003A;
        Mon,  3 Aug 2015 20:06:07 +0900 (JST)
Received: from hsdlvgate2.sdl.hitachi.co.jp by hsdlmain.sdl.hitachi.co.jp (8.13.8/3.7W11021512) id t73B676s000897; Mon, 3 Aug 2015 20:06:07 +0900
X-AuditID: 85900ec0-9d7c9b9000001a57-bb-55bf4ae0c70c
Received: from sdl99w.sdl.hitachi.co.jp (sdl99w.yrl.intra.hitachi.co.jp [133.144.14.250])
        by hsdlvgate2.sdl.hitachi.co.jp (Symantec Mail Security) with ESMTP id 465FC236561;
        Mon,  3 Aug 2015 20:05:04 +0900 (JST)
Received: from mailb.sdl.hitachi.co.jp (sdl99b.yrl.intra.hitachi.co.jp [133.144.14.197])
        by sdl99w.sdl.hitachi.co.jp (Postfix) with ESMTP id 59B4B53C218;
        Mon,  3 Aug 2015 20:06:07 +0900 (JST)
Received: from [10.198.220.34] (unknown [10.198.220.34])
        by mailb.sdl.hitachi.co.jp (Postfix) with ESMTP id 2E9D1495B7E;
        Mon,  3 Aug 2015 20:06:07 +0900 (JST)
Message-ID: <55BF4B1F.9000602@hitachi.com>
Date:   Mon, 03 Aug 2015 20:06:07 +0900
From:   Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:13.0) Gecko/20120604 Thunderbird/13.0
MIME-Version: 1.0
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Vivek Goyal <vgoyal@redhat.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@linux-mips.org, Baoquan He <bhe@redhat.com>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>,
        Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
        Daniel Walker <dwalker@fifo99.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC V2 PATCH 0/1] kexec: crash_kexec_post_notifiers boot
 option related fixes
References: <20150724011615.6834.79628.stgit@softrs>
In-Reply-To: <20150724011615.6834.79628.stgit@softrs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAA==
Return-Path: <hidehiro.kawai.ez@hitachi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48541
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hidehiro.kawai.ez@hitachi.com
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

Hello Eric and Vivek,

Do you have any comments?

(2015/07/24 10:16), Hidehiro Kawai wrote:
> This is a bugfix patch for crash_kexec_post_notifiers boot option
> which allows users to call panic notifiers and kmsg dumpers before
> kdump.
> 
> This fixes one of the problems reported by Daniel Walker
> (https://lkml.org/lkml/2015/6/24/44). 
> 
>  Problem 1:
>  If crash_kexec_post_notifiers boot option is specified, some
>  shutting down process which assume other cpus are still alive
>  don't work properly.
> 
>  Problem 2 (addressed by this patch):
>  If crash_kexec_post_notifiers boot option is specified, register
>  information of other cpus are not saved to crash dumps.
> 
> Following Vivek's opinion, this patch replaces smp_send_stop()
> in panic() with suitable version for crash_kexec which saves
> cpu states and other things like cleaning up VMX/SVM.  Since this
> needs architecture specific implementation and it's not so trivial,
> this version only support for x86.  So the problem 1, known to
> happen on MIPS/OCTEON, is not addressed now.
> 
> To keep the modification impact low, this patch doesn't change
> the logic basically if crash_kexec_post_notifiers is not specified.
> 
> Please note that crash_kexec() can be called directly without
> entering panic().  Stopping other cpus functionality is still
> needed in crash_kexec().
> 
> Changes in V2:
> - Replace smp_send_stop() call with crash_kexec version which
>   saves cpu states and does cleanups instead of changing execution
>   flow
> - Drop a fix for Problem 1
> - Drop other patches because they aren't needed anymore
> 
> V1: https://lkml.org/lkml/2015/7/10/316
> 
> ---
> 
> Hidehiro Kawai (1):
>       panic/x86: Replace smp_send_stop() with crash_kexec version
> 
> 
>  arch/x86/kernel/crash.c |   16 +++++++++++-----
>  kernel/panic.c          |   29 +++++++++++++++++++++++------
>  2 files changed, 34 insertions(+), 11 deletions(-)
> 
> 


-- 
Hidehiro Kawai
Hitachi, Ltd. Research & Development Group
