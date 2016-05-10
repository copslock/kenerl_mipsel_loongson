Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 May 2016 19:48:00 +0200 (CEST)
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35511 "EHLO
        mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27028725AbcEJRr6andLr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 10 May 2016 19:47:58 +0200
Received: by mail-pa0-f43.google.com with SMTP id iv1so7889966pac.2;
        Tue, 10 May 2016 10:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=pbozCf7p9JAHnQJx+FSVARA2lan6lDvnj2vl0i46dXc=;
        b=OvuXhB+CLvSH+qsVVIec4cBPU1Wh01yUmB99Yuz+LHkJpy995H8xBKBfRVwuhczjtD
         y1impphPxPvn9gaEO9F0CPCLSYJE4CpGB/TNHGQUWZF/Zjr9s2N1ZLC6yjw2WrkRE8SV
         y0RxRMcTabXQ4BmCuHbZ5C4AEFzztuz4dOi8xOxW+dL9NP+wfsfYPmXp65xDysH4nK7A
         Wrmhj+x3rPi1fE/oYR07ZOOpgaw7ir3ipHMdYN/4b+6fKZO6liurMBRPT91izsFQ51ru
         qmp+xqYhvF1TmvRZC0c0eZAuMtNEex55q/37acTjhhkrODPk2vKHYSQvdHfwWyWywnY4
         Wf9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=pbozCf7p9JAHnQJx+FSVARA2lan6lDvnj2vl0i46dXc=;
        b=WBvDCd/dJq5giSDan2f2btdbUbJtFZboraf+GSl3KPIpjNdPzP8+bum7E8bIeORQZ0
         iqkbqMksGlprmYB8aoFI02GVoxJTPaeEF/iK1mFCR15bUPkOJkJoQVK+B5YriuuTr/Zk
         b22IKqlTAvELfHnhwl9Q7UY8Gpb2/U/FhC9c24pftT9/hP+PTZvtIzl4cCMqc5xYdr5z
         9lbOFPWk1ObH8bDAdWlmIfh4c94UDBYE3Fk0yi/iQqaw5ZJrQ8ErEIgOpvtvfwFBbdKP
         DglD27n7us3osEjmUzj62Mqnnid6KodILueS8IdIFJjivlg2NDe2KX7ghdhey3Hp1tI7
         7NfA==
X-Gm-Message-State: AOPr4FXSwfUpXflVLY5nhkR3dLj3rpu+x00Eu6hyl1e0t3hiQ8UZ0L+s07e7dWwjuj8WJQ==
X-Received: by 10.66.21.102 with SMTP id u6mr60395992pae.118.1462902472372;
        Tue, 10 May 2016 10:47:52 -0700 (PDT)
Received: from [10.12.156.244] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.googlemail.com with ESMTPSA id k65sm6015895pfj.31.2016.05.10.10.47.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 May 2016 10:47:51 -0700 (PDT)
Subject: Re: [PATCH 00/12] TLB/XPA fixes & cleanups
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
References: <1460716620-13382-1-git-send-email-paul.burton@imgtec.com>
 <20160510124426.GG16402@linux-mips.org>
Cc:     linux-mips@linux-mips.org, James Hogan <james.hogan@imgtec.com>,
        Adam Buchbinder <adam.buchbinder@gmail.com>,
        "Maciej W. Rozycki" <macro@imgtec.com>,
        Joshua Kinard <kumba@gentoo.org>,
        Huacai Chen <chenhc@lemote.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        David Hildenbrand <dahi@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Daney <david.daney@cavium.com>,
        Jonas Gorski <jogo@openwrt.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Ingo Molnar <mingo@kernel.org>,
        Alex Smith <alex.smith@imgtec.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <57321EC4.5030301@gmail.com>
Date:   Tue, 10 May 2016 10:47:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
MIME-Version: 1.0
In-Reply-To: <20160510124426.GG16402@linux-mips.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53348
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

On 05/10/2016 05:44 AM, Ralf Baechle wrote:
> On Fri, Apr 15, 2016 at 11:36:48AM +0100, Paul Burton wrote:
> 
>> This series fixes up a number of issues introduced by commit
>> c5b367835cfc ("MIPS: Add support for XPA."), including breakage of the
>> MIPS32 with 36 bit physical addressing case & clobbering of $1 upon TLB
>> refill exceptions. Along the way a number of cleanups are made, which
>> leaves pgtable-bits.h in particular much more readable than before.
>>
>> The series applies atop v4.6-rc3.
>>
>> James Hogan (4):
>>   MIPS: Separate XPA CPU feature into LPA and MVH
>>   MIPS: Fix HTW config on XPA kernel without LPA enabled
>>   MIPS: mm: Don't clobber $1 on XPA TLB refill
>>   MIPS: mm: Don't do MTHC0 if XPA not present
>>
>> Paul Burton (8):
>>   MIPS: Remove redundant asm/pgtable-bits.h inclusions
>>   MIPS: Use enums to make asm/pgtable-bits.h readable
>>   MIPS: mm: Standardise on _PAGE_NO_READ, drop _PAGE_READ
>>   MIPS: mm: Unify pte_page definition
>>   MIPS: mm: Fix MIPS32 36b physical addressing (alchemy, netlogic)
>>   MIPS: mm: Pass scratch register through to iPTE_SW
>>   MIPS: mm: Be more explicit about PTE mode bit handling
>>   MIPS: mm: Simplify build_update_entries
> 
> Applied - but "MIPS: Separate XPA CPU feature into LPA and MVH" causes
> a massive conflict with Florian's RIXI patches
> 
>   [3/6] MIPS: Allow RIXI to be used on non-R2 or R6 core
>   [4/6] MIPS: Move RIXI exception enabling after vendor-specific cpu_probe
>   [5/6] MIPS: BMIPS: BMIPS4380 and BMIPS5000 support RIXI
> 
> I figured unapplying those three, applying Paul's series then re-applying
> Florian's patch on top of the whole series will be the easier path as in
> leaving me with the smaller rejects to manage.

Did you already push that to mips-for-linux-next? I can give it a quick
spin once you do so.
-- 
Florian
