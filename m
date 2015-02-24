Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Feb 2015 01:53:46 +0100 (CET)
Received: from mail-ig0-f170.google.com ([209.85.213.170]:64584 "EHLO
        mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006864AbbBXAxod-aBe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Feb 2015 01:53:44 +0100
Received: by mail-ig0-f170.google.com with SMTP id l13so25116529iga.1;
        Mon, 23 Feb 2015 16:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=PGuutdCIwtPRK41BR3YzNJcatiPB2rdMvxMhpepkMKk=;
        b=FT0o5yl8tNS/w+g29V5AGt/5B9ULNU3PQxnUp9bS6SyBGWex96D6QWZyRUE/SLiGir
         7PwhDXuB9FoRV2S9zfGJEj/Z0iHRMJWTH1MXGfjwUe+QCMoamHUQikNgk36HJiozS63v
         D63+4Fez63K0K1lKl3fjMSrETTSnr1pdgYyhfg2j1UzlltcTkiF+fy0of21mM6wRHlTp
         iSpoIjhlJ1jiLIFwuxHdZi0xL1nCXoUMqzz+3t7NhCi0q3q0lBqHrAiviT9c+paCJLbN
         gKCvMJKXZzTduE5QpH2lp3Mg42O/eLaEdMxkUFlKGhBAVrm0k2D0kJFHaP+MFP2Ge9Fn
         dbuw==
X-Received: by 10.42.93.16 with SMTP id v16mr13476298icm.74.1424739218948;
        Mon, 23 Feb 2015 16:53:38 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id w3sm8810869igz.1.2015.02.23.16.53.37
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 23 Feb 2015 16:53:38 -0800 (PST)
Message-ID: <54EBCB91.8070507@gmail.com>
Date:   Mon, 23 Feb 2015 16:53:37 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Subject: Re: [PATCH RFC v2 41/70] MIPS: mm: tlbex: Use cpu_has_mips_r2_exec_hazard
 for the EHB instruction
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com> <1421405389-15512-42-git-send-email-markos.chandras@imgtec.com> <54EBA3C3.30108@gmail.com> <alpine.LFD.2.11.1502240011420.17311@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.11.1502240011420.17311@eddie.linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45900
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 02/23/2015 04:33 PM, Maciej W. Rozycki wrote:
> On Mon, 23 Feb 2015, David Daney wrote:
>
>> For the version of this patch currently in mips-for-linux-next: NACK
>>
>> There are two problems:
>>
>> 1) It breaks OCTEON, which will now crash in early boot with:
>>
>>    Kernel panic - not syncing: No TLB refill handler yet (CPU type: 80)
>>
>> 2) The logic is broken.
>>
>> The meaning of cpu_has_mips_r2_exec_hazard is that the EHB instruction is
>> required.  You change the meaning to be that EHB is part of the ISA.
>
>   Well, the macro is nowhere used I'm afraid, its last use was dropped with
> 625c0a21, so it's rather difficult to assume any meaning to the macro.
>
>   Also the intended meaning is clear from the commit message of 41f0e4d0,
> where the macro comes from, however unfortunately not from the definition
> of the macro itself.  It's a pity that along your change you did not
> include an explanatory note in arch/mips/include/asm/cpu-features.h.
>
>   Finally, I think the change made to `build_tlb_write_entry' with 625c0a21
> may need to be reconsidered, as may perhaps the name itself of
> `cpu_has_mips_r2_exec_hazard' (why is it this place only that the macro
> was used? -- would it be better called `cpu_has_tlbw_exec_hazard'
> instead?), and then we'll need `cpu_has_ehb' or suchlike across all the
> other places.
>

I agree with all the points you make.

The parts of tlbex.c dealing with EHB are an inconsistent mess.  Since 
it is one of my favorite playgrounds I am probably as guilty as anyone.

The idea behind `cpu_has_mips_r2_exec_hazard' (although a better name 
could have been chosen, as you point out) was to get rid of the case 
statements based on CPU model in tlbex.c, and move the logic into the 
individual cpu-feature files.  I thought this would make it easier to 
add new CPUs in the future, but it turns out that now we have a random 
assortment of both :-(.

David Daney
