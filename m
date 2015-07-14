Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jul 2015 03:56:24 +0200 (CEST)
Received: from mail9.hitachi.co.jp ([133.145.228.44]:44025 "EHLO
        mail9.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008655AbbGNB4Uc0N1G (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Jul 2015 03:56:20 +0200
Received: from mlsv8.hitachi.co.jp (unknown [133.144.234.166])
        by mail9.hitachi.co.jp (Postfix) with ESMTP id 8C556109BD86;
        Tue, 14 Jul 2015 10:56:16 +0900 (JST)
Received: from mfilter05.hitachi.co.jp by mlsv8.hitachi.co.jp (8.13.1/8.13.1) id t6E1uGps029225; Tue, 14 Jul 2015 10:56:16 +0900
Received: from vshuts02.hitachi.co.jp (vshuts02.hitachi.co.jp [10.201.6.84])
        by mfilter05.hitachi.co.jp (Switch-3.3.4/Switch-3.3.4) with ESMTP id t6E1uEbS029082;
        Tue, 14 Jul 2015 10:56:15 +0900
Received: from hsdlmain.sdl.hitachi.co.jp (unknown [133.144.14.194])
        by vshuts02.hitachi.co.jp (Postfix) with ESMTP id 792DF49004D;
        Tue, 14 Jul 2015 10:56:14 +0900 (JST)
Received: from hsdlvgate2.sdl.hitachi.co.jp by hsdlmain.sdl.hitachi.co.jp (8.13.8/3.7W11021512) id t6E1uEQg023001; Tue, 14 Jul 2015 10:56:14 +0900
X-AuditID: 85900ec0-9c3c7b9000001a57-e4-55a46c27a017
Received: from sdl99w.sdl.hitachi.co.jp (sdl99w.yrl.intra.hitachi.co.jp [133.144.14.250])
        by hsdlvgate2.sdl.hitachi.co.jp (Symantec Mail Security) with ESMTP id 7BBFE236561;
        Tue, 14 Jul 2015 10:55:51 +0900 (JST)
Received: from mailb.sdl.hitachi.co.jp (sdl99b.yrl.intra.hitachi.co.jp [133.144.14.197])
        by sdl99w.sdl.hitachi.co.jp (Postfix) with ESMTP id EE0DB53C21A;
        Tue, 14 Jul 2015 10:56:13 +0900 (JST)
Received: from [10.198.220.34] (unknown [10.198.220.34])
        by mailb.sdl.hitachi.co.jp (Postfix) with ESMTP id A835B495B87;
        Tue, 14 Jul 2015 10:56:13 +0900 (JST)
Message-ID: <55A46C3D.7000208@hitachi.com>
Date:   Tue, 14 Jul 2015 10:56:13 +0900
From:   Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:13.0) Gecko/20120604 Thunderbird/13.0
MIME-Version: 1.0
To:     dwalker@fifo99.com, "Eric W. Biederman" <ebiederm@xmission.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
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
References: <20150710113331.4368.10495.stgit@softrs> <20150710113331.4368.63745.stgit@softrs> <87wpy82kqf.fsf@x220.int.ebiederm.org> <20150713202611.GA16525@fifo99.com>
In-Reply-To: <20150713202611.GA16525@fifo99.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAA==
Return-Path: <hidehiro.kawai.ez@hitachi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48251
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

Hello Eric and Daniel,

(2015/07/14 5:26), dwalker@fifo99.com wrote:
> On Fri, Jul 10, 2015 at 08:41:28AM -0500, Eric W. Biederman wrote:
>> Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com> writes:
>>
>>> You can call panic notifiers and kmsg dumpers before kdump by
>>> specifying "crash_kexec_post_notifiers" as a boot parameter.
>>> However, it doesn't make sense if kdump is not available.  In that
>>> case, disable "crash_kexec_post_notifiers" boot parameter so that
>>> you can't change the value of the parameter.
>>
>> Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>
>>
>> You are confusing kexec on panic and CONFIG_CRASH_DUMP
>> which is about the tools for reading the state of the previous kernel.

You are right.  I mistook the meaning of CONFIG_CRASH_DUMP.

> I think it would make sense if he just replaced "kdump" with "kexec".

If a user specified crash_kexec_post_notifiers option with kexec
being totally disabled, it just disables notifier and kmsg dumper calls
(please see PATCH 3/3). So as Daniel said, I also think it makes sense
to hide crash_kexec_post_notifiers option if kexec is disabled.

Regards,

-- 
Hidehiro Kawai
Hitachi, Ltd. Research & Development Group
