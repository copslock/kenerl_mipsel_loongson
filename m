Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Aug 2015 10:25:59 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:38526 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011540AbbHMIZ4wh0qh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Aug 2015 10:25:56 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 0D9C630EC6DB4;
        Thu, 13 Aug 2015 09:25:49 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 13 Aug 2015 09:25:51 +0100
Received: from [192.168.154.136] (192.168.154.136) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Thu, 13 Aug
 2015 09:25:50 +0100
Subject: Re: VDSO
To:     David Daney <ddaney.cavm@gmail.com>
References: <55CB1E0C.4070405@imgtec.com> <55CB70EE.4080802@gmail.com>
CC:     <linux-mips@linux-mips.org>
From:   Alex Smith <alex.smith@imgtec.com>
Message-ID: <55CC548E.6090407@imgtec.com>
Date:   Thu, 13 Aug 2015 09:25:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <55CB70EE.4080802@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.136]
Return-Path: <Alex.Smith@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48842
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex.smith@imgtec.com
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

On 12/08/2015 17:14, David Daney wrote:
> On 08/12/2015 03:21 AM, Alex Smith wrote:
>> Hi,
>>
>> I'm intending to start work on a proper VDSO implementation for MIPS that can provide user implementations of gettimeofday() and such, as well as take over from the current signal return trampoline code.
>>
>> Just wondering if there's anyone else who's doing any work towards this so we can avoid duplication of effort if so?
>>
> 
> I am not working on it, but have a small laundry list of what could be done:
> 
> 1) Perhaps the VA of the vdso needs to be randomized.
> 
> 2) Provide proper .eh_frame data for the signal return trampolines.
> 
> 3) gettimeofday (as you suggest).

Yes, I intend to do all of these.

> 4) Provide optimized versions of memcpy, etc.

Is this something that belongs in a VDSO? memcpy and friends aren't syscalls, this belongs in libc IMO. ELF HWCAP flags provided by the kernel could be used by libc to decide which CPU features it can make use of to implement them.

Thanks,
Alex

> 
> David Daney
> 
> 
