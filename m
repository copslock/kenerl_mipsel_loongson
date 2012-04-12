Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Apr 2012 17:18:58 +0200 (CEST)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:56377 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903647Ab2DLPSp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 Apr 2012 17:18:45 +0200
Received: by bkcjk13 with SMTP id jk13so2213829bkc.36
        for <linux-mips@linux-mips.org>; Thu, 12 Apr 2012 08:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:organization:user-agent:mime-version:to
         :subject:content-type:content-transfer-encoding;
        bh=laRpwj7q/9xXe9VXfvAjei0AQwwyBm9UVw1rFHujWNM=;
        b=EKax53O5y1FqrQD+B1KVug3lt+ZxujgtQnpMcvLyHOS6u6p9pELJ/bWj8mzWMyZhRW
         mWQWinbeF0FJdB4IpYLG7uRIL2K7WLWadpiw/Seoi60tzOxth8gvEIH0VkEFPIOztRam
         ZQXaeUu7WJVMir3zGwLOTWzVMMpw97iIY0af0p5mnKCGHpL1ezdSorOl0ZMgfa6ErpDp
         z3nc4f3b3+ngLekdgbGD7DpGUqdh2SlnVXjakiaNh//7Fe+08a898IIxqN7eZABMZQR1
         HdQZMaeSY6ismwDL0SOTyQIHItOuBm2LSzOIb1t+c86QIwwFq9uUyJ+qaWwQtLeKJaWg
         jRNA==
Received: by 10.204.152.92 with SMTP id f28mr857226bkw.113.1334243919544;
        Thu, 12 Apr 2012 08:18:39 -0700 (PDT)
Received: from [192.168.108.37] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by mx.google.com with ESMTPS id z17sm11573863bkw.12.2012.04.12.08.18.36
        (version=SSLv3 cipher=OTHER);
        Thu, 12 Apr 2012 08:18:37 -0700 (PDT)
Message-ID: <4F86F1FC.3080401@openwrt.org>
Date:   Thu, 12 Apr 2012 17:17:16 +0200
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120329 Thunderbird/11.0.1
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Linux-MIPS project (re)organization proposal
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 32936
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hi all,

The Linux-MIPS project has not been very active during the last couple 
merge windows, this made me think that maybe our project model is not so 
well suited for handling all the patches coming through linux-mips, so 
here is a proposal of how I see things might be changed, highly inspired 
from the ARM community.

To help with the number of patches, we should create two groups of people:

1) people in charge of reviewing all the MIPS-related infrastructure, 
shared code, CPU-specific code etc. For this specific task, I was 
thinking about Ralf, David D. (CAVM), SJ Hill (MTI), Kevin Cernekee for 
instance. The idea is to have both enough reviewers and committers to 
push changes, and have some level of redundancy in case Ralf cannot 
submit the pull request.

2) people in charge of maintaining a SoC, who deal with more subsystems 
than just MIPS, and usually need general review, both from the "core" 
MIPS developers, and also other subsystem maintainers, but, in the end, 
can manage themselves a patch queue in a separate tree and just send 
pull requests.

Device Tree is now the standard for accepting new architectures/SoCs in 
Linux, and this usually demands more reviewers as well as good 
reactivity from the various maintainers, but in the end, there are just 
more patches being or about to be posted to linux-mips.

What do you guys think about this?
--
Florian
