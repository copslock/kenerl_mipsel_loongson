Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Sep 2014 12:47:57 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:48737 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009597AbaIWKrvjfxgv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Sep 2014 12:47:51 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 0FAC499675202;
        Tue, 23 Sep 2014 11:47:41 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 23 Sep 2014 11:47:42 +0100
Received: from [192.168.154.67] (192.168.154.67) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 23 Sep
 2014 11:47:42 +0100
Message-ID: <54214FCE.6070501@imgtec.com>
Date:   Tue, 23 Sep 2014 11:47:42 +0100
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
MIME-Version: 1.0
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] MIPS: mcount: Fix selfpc address for static trace
References: <1411392779-9554-1-git-send-email-markos.chandras@imgtec.com>       <1411392779-9554-3-git-send-email-markos.chandras@imgtec.com> <20140922142642.7f70fb0f@gandalf.local.home>
In-Reply-To: <20140922142642.7f70fb0f@gandalf.local.home>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.67]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42739
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

On 09/22/2014 07:26 PM, Steven Rostedt wrote:
> On Mon, 22 Sep 2014 14:32:59 +0100
> Markos Chandras <markos.chandras@imgtec.com> wrote:
> 
>> According to Documentation/trace/ftrace-design.txt, the selfpc
>> should be the return address minus the mcount overhead (8 bytes).
>> This brings static trace in line with the dynamic trace regarding
>> the selfpc argument to the tracing function.
>>
>> This also removes the magic number '8' with the proper
>> MCOUNT_INSN_SIZE.
> 
> I could also update the generic code to handle delay slots.
> 
> -- Steve

As I said to the other patch, if you want to fix the delay slots in the
generic code that may be preferred indeed. On the other hand, the static
tracer still needs fixing so the correct selfpc is used. I will update
this patch based on the way you choose to handle delay slots in the
generic code. Thanks

-- 
markos
