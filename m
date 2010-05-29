Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 29 May 2010 20:20:23 +0200 (CEST)
Received: from mail-pv0-f177.google.com ([74.125.83.177]:38413 "EHLO
        mail-pv0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491840Ab0E2SUS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 29 May 2010 20:20:18 +0200
Received: by pvg2 with SMTP id 2so182634pvg.36
        for <multiple recipients>; Sat, 29 May 2010 11:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=9lp72GXXX1zVQg0ZK2JdYeDyP76Che5QWL0OY0YQTec=;
        b=FCB9VTYL4jWTQ3+sZJzTrPBR5hfzPPUY2O9SsObnVWgJutINRaulxwiYl9UgHa2T4L
         bW3O3B8bi9akliKwsSCSRw4ZzK5Iwa/+qpKtOORF2qOaCzBhBLM9UxcpNSWNoQTssArO
         0IpiE6X1WRONrtQVMkb891R4cHDDlMawggpjA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=tUe3AjrTDSbmPt4wwHtuqyeVS8h6nLt5WH/7unnkSrEAlliGViES2Pmr6Bdo9/a+hW
         jWPMkUt/vPIf0NU9jB0mQ6B1jjwJ8SgNiMX5r8qdWpnpK+1KcFxbHeRVSLRk0TIp7Xlc
         Rru0iUYxJiq4ybuActZiG8N7mNMqFTaOlLx+E=
Received: by 10.115.84.4 with SMTP id m4mr1668264wal.222.1275157211045;
        Sat, 29 May 2010 11:20:11 -0700 (PDT)
Received: from dd_xps.caveonetworks.com (adsl-67-127-190-169.dsl.pltn13.pacbell.net [67.127.190.169])
        by mx.google.com with ESMTPS id d16sm31533737wam.12.2010.05.29.11.20.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 29 May 2010 11:20:10 -0700 (PDT)
Message-ID: <4C015AD8.3020408@gmail.com>
Date:   Sat, 29 May 2010 11:20:08 -0700
From:   David Daney <david.s.daney@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100430 Fedora/3.0.4-2.fc11 Thunderbird/3.0.4
MIME-Version: 1.0
To:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com, will.deacon@arm.com
Subject: Re: [PATCH v5 01/12] MIPS/Oprofile: extract PMU defines/helper functions
 for sharing
References: <1274965420-5091-1-git-send-email-dengcheng.zhu@gmail.com>  <1274965420-5091-2-git-send-email-dengcheng.zhu@gmail.com>      <4BFEE8B6.6040605@gmail.com> <AANLkTilx-yMwFE0cj3jQu1BZEx_XW2_sj-lRAfzNO88o@mail.gmail.com>
In-Reply-To: <AANLkTilx-yMwFE0cj3jQu1BZEx_XW2_sj-lRAfzNO88o@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <david.s.daney@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26916
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.s.daney@gmail.com
Precedence: bulk
X-list: linux-mips

On 05/28/2010 08:06 PM, Deng-Cheng Zhu wrote:
> Hi, David
>
>
> Thanks for your comments! I'm replying to you in the patch order. If my
> comments are wrong or are bad ideas, please point out.
>
>
> 2010/5/28 David Daney<david.s.daney@gmail.com>:
>    
>> Why predicate the entire contents of the file?
>>
>> In any event, if you keep it, it shold probably be something like:
>>
>>     #if defined(CONFIG_CPU_MIPSR1) || defined(CONFIG_CPU_MIPSR2)
>>      
> [DC]:
> 1) This line is not for the "entire" contents of the file, other CPUs
> LOONGSON2 and RM9000 are here.
>    

In any event I think you want defined(CONFIG_CPU_MIPSR1) || 
defined(CONFIG_CPU_MIPSR2) instead of what you had.

> 2) The CONFIG_CPU* came from the Makefile of oprofile. If other CPUs are
> newly supported, we can add into the #if #elif.
>    

TOO_MANY_#IF == BAD.  You are rewriting the code here, you can take the 
opportunity to improve it.

> 3) The perf counter helper functions are special to mipsxx/loongson2/rm9000
> espcially the reset_counter() will be implemented respectively. Although
> they will be moved to perf_event_$cpu.c when Oprofile uses Perf-events as
> backend, they are currently shared by Oprofile and Perf-events to reduce
> code copying.
>
>
>    
>> Some or all of that should probably go in asm/mipsregs.h
>>      
> [DC]: Now that we create pmu.h and these #define's are originally in
> op_model_$cpu.c not in mipsregs.h, how about keeping them here? BTW, after
> making Oprofile use Perf-events as backend (patches 8~12 do this), pmu.h
> will only contain register definitions (no static function definitions),
> then we can consider deleting pmu.h and moving its contents to mipsregs.h,
> is it OK?
>
>    

I don't have super strong preferences for where the bit definitions for 
cop0 registers go.  To date most are in mipsregs.h.  Perhaps Ralf has a 
preference.
>> Are 0 and 1 really the only conceivable values?
>>      
> [DC]: This is also from Oprofile. If we use:
> #define vpe_id()       (cpu_has_mipsmt_pertccounters ? \
>                         0 : cpu_data[smp_processor_id()].vpe_id)
> The possible return value is supposed to be 0 or 1.
>    

I haven't read the architecture specification for the multithread ASE.  
Is it really true that exactly two VPEs is all that is allowed?  If so 
this seems fine, otherwise it should reflect the full range of allowed 
values.

David Daney
