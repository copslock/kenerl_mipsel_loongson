Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 May 2016 21:17:20 +0200 (CEST)
Received: from mail-pf0-f182.google.com ([209.85.192.182]:35915 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27029105AbcEKTRSnkhTo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 May 2016 21:17:18 +0200
Received: by mail-pf0-f182.google.com with SMTP id c189so22499933pfb.3;
        Wed, 11 May 2016 12:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=K/AQ0dq0WfpYrFACE4TxxiPQ9C8gn9loG5CNjwaCFPY=;
        b=Dx1IN72FMCD+/czPetsmzPESWiCOl2czmPuB7r963aSk8FLefolWEnR5sM+0GTz4y0
         lpM2iZ0GQyPeKoixo+iX70JNvRgzuCxSs/Kyool+Z8PrhmFT53xX/r8G8GhEd4XrYjA5
         DULkPOmJo+Q9P/anWT99GZFo6nifTOxNhuhPUodz0wWEvh5Ac4n29XeqX7ZGmvvo1IvC
         72AsdYKHP5kMFUoJRzoMqHPicjbTFodG2njlFJE0wowFU8+bXli+Uopyn9/QVoc0laWm
         rMZQ0+n0TzxK8EzUnRtFy4JDsCnuawuQEwON2fZRP4ELbf9rThUqqnadoDNxBrLRyu+c
         sbJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=K/AQ0dq0WfpYrFACE4TxxiPQ9C8gn9loG5CNjwaCFPY=;
        b=B0twTTkNzK2NK2IJPf8xvdJh//pRuxDe/WMBZH6JQaTRogLecPfYDXIVIzQmWoqY/Y
         C9iFads0iwzrmcBOW+hP7olFD5psGNyQyi8C7u9GiYmDcXeoNiXmxmZwY+6/EDeIluhQ
         y8cwAAXUbQ7o1sQ07TilseeGn2n4gbbTxxcflQmD0sMYmwK7SENYQ3ltE2IBvLHlA5bv
         Jc6fBbqPfE1MGR4ZL2LjSysXqJ9APMK4gGsaKUF/6ym59EduM/oyrowXg5xE+2imPiPx
         9ZkUjPuSLOtdt6USpez/DxI8EwFFXK3yPA8g+ToBft/jSJzOpK0a7C17CLFomOPxRCyX
         H88w==
X-Gm-Message-State: AOPr4FVvzvgDgz+6+deaFEoQo2osjNYiSCPwfzsgXGVUruMkMtuvp5UjFS/Rx11qlTFzag==
X-Received: by 10.98.4.195 with SMTP id 186mr7500681pfe.154.1462994232975;
        Wed, 11 May 2016 12:17:12 -0700 (PDT)
Received: from [10.112.156.244] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.googlemail.com with ESMTPSA id v75sm13988774pfa.94.2016.05.11.12.17.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 May 2016 12:17:12 -0700 (PDT)
Subject: Re: [PATCH 00/12] TLB/XPA fixes & cleanups
To:     Ralf Baechle <ralf@linux-mips.org>
References: <1460716620-13382-1-git-send-email-paul.burton@imgtec.com>
 <20160510124426.GG16402@linux-mips.org> <57321EC4.5030301@gmail.com>
 <20160511100335.GA14397@linux-mips.org>
Cc:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org,
        James Hogan <james.hogan@imgtec.com>,
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
Message-ID: <57338536.9040209@gmail.com>
Date:   Wed, 11 May 2016 12:17:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
MIME-Version: 1.0
In-Reply-To: <20160511100335.GA14397@linux-mips.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53384
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

On 05/11/2016 03:03 AM, Ralf Baechle wrote:
> On Tue, May 10, 2016 at 10:47:48AM -0700, Florian Fainelli wrote:
> 
>>> Applied - but "MIPS: Separate XPA CPU feature into LPA and MVH" causes
>>> a massive conflict with Florian's RIXI patches
>>>
>>>   [3/6] MIPS: Allow RIXI to be used on non-R2 or R6 core
>>>   [4/6] MIPS: Move RIXI exception enabling after vendor-specific cpu_probe
>>>   [5/6] MIPS: BMIPS: BMIPS4380 and BMIPS5000 support RIXI
>>>
>>> I figured unapplying those three, applying Paul's series then re-applying
>>> Florian's patch on top of the whole series will be the easier path as in
>>> leaving me with the smaller rejects to manage.
>>
>> Did you already push that to mips-for-linux-next? I can give it a quick
>> spin once you do so.
> 
> I just pushed a tree with everything applied.  HEAD of tree is
> 22702a86997c5aed2e479bfe0b24d10d66b09604 dated May 11 11:58:06; a version
> from earlier today was broken.

Boot tested on BMIPS5000 (BCM7425):

Tested-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks!
-- 
Florian
