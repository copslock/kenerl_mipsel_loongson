Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Sep 2014 12:46:24 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:62047 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009597AbaIWKqWZ5UjQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Sep 2014 12:46:22 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 6C889CF194974;
        Tue, 23 Sep 2014 11:46:13 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 23 Sep
 2014 11:46:15 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 23 Sep 2014 11:46:15 +0100
Received: from [192.168.154.67] (192.168.154.67) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 23 Sep
 2014 11:46:14 +0100
Message-ID: <54214F76.6070808@imgtec.com>
Date:   Tue, 23 Sep 2014 11:46:14 +0100
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
MIME-Version: 1.0
To:     Steven Rostedt <rostedt@goodmis.org>,
        David Daney <ddaney.cavm@gmail.com>
CC:     <linux-mips@linux-mips.org>, Ingo Molnar <mingo@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] MIPS: ftrace.h: Fix the MCOUNT_INSN_SIZE definition
References: <1411392779-9554-1-git-send-email-markos.chandras@imgtec.com>       <1411392779-9554-2-git-send-email-markos.chandras@imgtec.com>   <5420546D.6050102@gmail.com> <20140922142534.4087a0a9@gandalf.local.home>
In-Reply-To: <20140922142534.4087a0a9@gandalf.local.home>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.67]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42738
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Markos.Chandras@imgtec.com
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

On 09/22/2014 07:25 PM, Steven Rostedt wrote:
> On Mon, 22 Sep 2014 09:55:09 -0700
> David Daney <ddaney.cavm@gmail.com> wrote:
> 
>> On 09/22/2014 06:32 AM, Markos Chandras wrote:
>>> The MCOUNT_INSN_SIZE is meant to be used to denote the overall
>>> size of the mcount() call. Since a jal instruction is used to
>>> call mcount() the delay slot should be taken into consideration
>>> as well.
>>> This also replaces the MCOUNT_INSN_SIZE usage with the real size
>>> of a single MIPS instruction since, as described above, the
>>> MCOUNT_INSN_SIZE is used to denote the total overhead of the
>>> mcount() call.
>>
>> Are you seeing errors with the existing code?  If so please state what 
>> they are.
>>
>> By changing this, we can no longer atomically replace the instruction. 
>> So I think shouldn't be changing this stuff unless there is a real bug 
>> we are fixing.
> 
> Actually, it looks like the code still works the same, as it uses the
> old size of 4 (FTRACE_MIPS_INSN_SIZE) to do the update.

Indeed I haven't seen any functional change when it comes to replacing
the instruction.

> [...]
> 
> It may also fix the stack tracer, as it searches for the ip saved in
> the return address to find where the true stack is (skipping the stack
> part that calls the strack tracer itself). If the link register holds
> the location after the delay slot, then this would require
> MCOUNT_INSN_SIZE to include the delay slot as well.

Yes, this is the only case I spotted as well. Perhaps I should put that
in the changelog.

Or I could add
> another macro called MCOUNT_DELAY_SLOT_SIZE that can be defined by an
> arch (and keep it zero for all other archs). That wouldn't be too much
> of an issue to implement.

If you want to fix that in the generic code then I am fine with it.

-- 
markos
