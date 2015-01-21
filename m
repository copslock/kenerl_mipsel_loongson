Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jan 2015 10:35:11 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:12476 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011344AbbAUJfGcko4W (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Jan 2015 10:35:06 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id ADBF9A3427D8D;
        Wed, 21 Jan 2015 09:34:58 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 21 Jan 2015 09:35:00 +0000
Received: from [192.168.154.96] (192.168.154.96) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 21 Jan
 2015 09:34:59 +0000
Message-ID: <54BF72C3.60306@imgtec.com>
Date:   Wed, 21 Jan 2015 09:34:59 +0000
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>
CC:     <linux-mips@linux-mips.org>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Subject: Re: [PATCH RFC v2 27/70] MIPS: kernel: cevt-r4k: Add MIPS R6 to the
 c0_compare_interrupt handler
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com> <1421405389-15512-28-git-send-email-markos.chandras@imgtec.com> <alpine.LFD.2.11.1501200110040.28301@eddie.linux-mips.org> <20150120091414.GA23188@jhogan-linux.le.imgtec.org> <alpine.LFD.2.11.1501201427370.28301@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.11.1501201427370.28301@eddie.linux-mips.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.96]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45393
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

On 01/20/2015 02:33 PM, Maciej W. Rozycki wrote:
> On Tue, 20 Jan 2015, James Hogan wrote:
> 
>>>  While a preexisting bug, this is simply not true, there's CP0.Cause.TI to 
>>> examine for a timer interrupt pending.  Please fix your change to use 
>>> `c0_compare_int_pending' instead and synchronise with stuff posted by 
>>> James (cc-ed) at <http://patchwork.linux-mips.org/patch/8900/>.
>>
>> I'm not sure I follow what you mean. This change makes it treat r6 like
>> it treats r2 (i.e. there is still a Cause.TI bit), which sounds correct
>> to me. I'm guessing cpu_has_mips_r6 doesn't imply cpu_has_mips_r2.
> 
>  Correct, R6 is not backwards compatible with R2 so it doesn't set the R2 
> flag and consequently any compatibility that does exist has to be handled 
> explicitly; see 28/70 for the details of the flag setup.
> 
>   Maciej
> 
So i guess the original patch is fine then? otherwise, like James said,
I am not sure what's wrong with it (apart from the fact that it will
conflict with what James posted on
http://patchwork.linux-mips.org/patch/8900/). Such conflicts will be
taken care of when Ralf is ready to merge R6.

-- 
markos
