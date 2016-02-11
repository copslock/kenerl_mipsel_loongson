Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Feb 2016 02:59:37 +0100 (CET)
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34893 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010896AbcBKB7fZh6lb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Feb 2016 02:59:35 +0100
Received: by mail-pf0-f194.google.com with SMTP id w128so1211743pfb.2;
        Wed, 10 Feb 2016 17:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=ryEF5ONVQ2P2w2oGNAPtUDzY/I1hIF/L+wr8Epdnxl8=;
        b=tv45LA2UPWxp1JBt8FKntF6767IJDGd9OKvkyPTWzlCHz5nbm1gVoMqo+PTrCop+lB
         ULlfF2yXC80Zf38IdRAu83n1jZcB0svkGn/cdE4GpF18wSongJe+EyBKMrQc5XPTYThf
         XT9Qnb8mz63qsnWVCv9rf2U3flNyz/qmD8JHtt7OeU4MNFlTKUzu3AhoEuMxXggT0ZdS
         C6NU+1EFj9b5sTrQGFY53wMTR2mM21/A2uQW0Az1XnM//aZuLjaWHk1JRlbdl0AKYtwk
         j8mGq4aj3AVMz3kR4Z/w2PdHhd5E55Dm9qWNZxTFI1lBeubCdKgR1TV+9RTTaFq85P6V
         WdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=ryEF5ONVQ2P2w2oGNAPtUDzY/I1hIF/L+wr8Epdnxl8=;
        b=l5k/qaLpAg47udM51v3oMBY1mg+EVG26xIJgta5VwnzZSne8Z/moCLNtwTZB7vKOZ3
         JDXf2z1sXmjHDUsDHwBXptY7ZPC75H0p2r3cDc7fweB46dOpQ4TjSgd8r8r29ZziRZL/
         072vhwdGmjXAqqiKPHFGKslQ/iBzCfil7RU1CIvfr5wWO3zLD63F20waTGWU35dUoU3N
         OZBM46EGaR/2I45qRGKlXLb2/Pm9BPLNIAQ3LEhketb/DL2Wpf35OJ49W2vM4M0pB/XW
         fnC2v9W6jRCVFIc0iS9MuIzDTH+MnVxs2fNsJg5pBYJEQ4cBO8cpHmI/pSrTDtBR3sVA
         S9bA==
X-Gm-Message-State: AG10YOQAcDwaFHZLCgQnnLup/GNgLygtggzbHQF2trzQakQW1TzYys5IvF/dAMRGQMapZw==
X-Received: by 10.98.14.149 with SMTP id 21mr62948179pfo.79.1455155969171;
        Wed, 10 Feb 2016 17:59:29 -0800 (PST)
Received: from [10.12.156.244] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.googlemail.com with ESMTPSA id u64sm7928611pfa.86.2016.02.10.17.59.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Feb 2016 17:59:28 -0800 (PST)
Subject: Re: [PATCH 6/6] MIPS: Expose current_cpu_data.options through debugfs
To:     Ralf Baechle <ralf@linux-mips.org>
References: <1455051354-6225-1-git-send-email-f.fainelli@gmail.com>
 <1455051354-6225-7-git-send-email-f.fainelli@gmail.com>
 <20160210104629.GA11091@linux-mips.org>
Cc:     linux-mips@linux-mips.org, blogic@openwrt.org, cernekee@gmail.com,
        jon.fraser@broadcom.com, pgynther@google.com,
        paul.burton@imgtec.com, ddaney.cavm@gmail.com
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <56BBEABF.8030804@gmail.com>
Date:   Wed, 10 Feb 2016 17:58:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20160210104629.GA11091@linux-mips.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51986
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

On 10/02/16 02:46, Ralf Baechle wrote:
> On Tue, Feb 09, 2016 at 12:55:54PM -0800, Florian Fainelli wrote:
> 
>> Debugging a missing features in cpu-features-override.h, or a runtime feature
>> set/clear in the vendor specific cpu_probe() function can be a little tedious,
>> ease that by providing a debugfs entry representing the
>> current_cpu_data.options bitmask.
> 
> Hm..  Bits in the options bitmaps are not an ABI, they come and sometimes
> they go as well and manual decoding can be tedious to humans.  so I'm
> wondering if something in /sys/devices/system/cpu would be more suitable.

Not sure, you need this while bringing up systems and/or debugging why a
kernel does not have this or that enabled as you think it should,
outside of that, not so much probably?. More standard interfaces like
/proc/cpuinfo should be used, but that does not give you the full picture.

> It'd depend on just sysfs, not debugfs which is disabled in production
> kernels.
> 
> Thoughts?

I suppose this is fine, in that case, we would probably want to go with
a text-based approach to make the interface more stable.

NB: I also have a patch that adds cache info reporting to MIPS, since it
seems useful for people dealing with user-space cache flushes (graphics,
JIT, etc.), Russell King rejected adding that for ARM, but ARM64 and x86
have it (arch/arm64/kernel/cacheinfo.c) would you oppose to having that
for MIPS?
-- 
Florian
