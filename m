Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2014 11:06:49 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:49070 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6842444AbaGWJGqLNqmi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Jul 2014 11:06:46 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 6E02D7D8E358E;
        Wed, 23 Jul 2014 10:06:37 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 23 Jul
 2014 10:06:39 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 23 Jul 2014 10:06:39 +0100
Received: from [192.168.154.158] (192.168.154.158) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 23 Jul
 2014 10:06:38 +0100
Message-ID: <53CF7B1E.9040903@imgtec.com>
Date:   Wed, 23 Jul 2014 10:06:38 +0100
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     Rob Kendrick <rob.kendrick@codethink.co.uk>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: EdgeRouter Pro supported?  Strange FP problems
References: <20140722130616.GJ30723@humdrum> <53CE736E.1060009@imgtec.com> <20140722143311.GK30723@humdrum> <53CE8570.8020404@imgtec.com> <20140723090357.GN30723@humdrum>
In-Reply-To: <20140723090357.GN30723@humdrum>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.158]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41513
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

On 07/23/2014 10:03 AM, Rob Kendrick wrote:
> On Tue, Jul 22, 2014 at 04:38:24PM +0100, Markos Chandras wrote:
>> a quick bisect between v3.15 and v3.16-rc1, which is the first tag with
>> all the new FPU changes, leads to the following bad commit:
>>
>> 08a07904e182895e1205f399465a3d622c0115b8
>> MIPS: math-emu: Remove most ifdefery.
> 
> This appears to fix the problem:
> 
> diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
> index 736c17a..bf0fc6b 100644
> --- a/arch/mips/math-emu/cp1emu.c
> +++ b/arch/mips/math-emu/cp1emu.c
> @@ -1827,7 +1827,7 @@ dcopuop:
>         case -1:
>  
>                 if (cpu_has_mips_4_5_r)
> -                       cbit = fpucondbit[MIPSInst_RT(ir) >> 2];
> +                       cbit = fpucondbit[MIPSInst_FD(ir) >> 2];
>                 else
>                         cbit = FPU_CSR_COND;
>                 if (rv.w)
> 
> Sadly I am totally ignorant of kernel patch processes.  What would be
> approach to having this properly submitted?
> 
Hi Rob,

The patch looks correct. See this document for the process

https://www.kernel.org/doc/Documentation/SubmittingPatches

So in general, you need to create a patch using git-format-patch
and use git-send-email to send it to this mailing list.

-- 
markos
