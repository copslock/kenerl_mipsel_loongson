Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Nov 2011 11:32:13 +0100 (CET)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:46643 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903711Ab1KUKcF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 Nov 2011 11:32:05 +0100
Received: by bkat2 with SMTP id t2so8409414bka.36
        for <multiple recipients>; Mon, 21 Nov 2011 02:32:00 -0800 (PST)
Received: by 10.204.128.199 with SMTP id l7mr2960022bks.27.1321871520202;
        Mon, 21 Nov 2011 02:32:00 -0800 (PST)
Received: from [192.168.2.2] (ppp85-141-190-27.pppoe.mtu-net.ru. [85.141.190.27])
        by mx.google.com with ESMTPS id x14sm6890428bkf.10.2011.11.21.02.31.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 21 Nov 2011 02:31:59 -0800 (PST)
Message-ID: <4ECA2869.2000404@mvista.com>
Date:   Mon, 21 Nov 2011 14:31:05 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:8.0) Gecko/20111105 Thunderbird/8.0
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH] MIPS: Get rid of some #ifdefery in arch/mips/mm/tlb-r4k.c
References: <1321651809-23395-1-git-send-email-ddaney.cavm@gmail.com>
In-Reply-To: <1321651809-23395-1-git-send-email-ddaney.cavm@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 31853
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17102

Hello.

On 19-11-2011 1:30, David Daney wrote:

> From: David Daney<david.daney@cavium.com>

> In the case of !CONFIG_HUGETLB_PAGE, in linux/hugetlb.h we have this
> definition:

    Missed it?

> The other huge page constants in the if(pmd_huge()) block are likewise
> defined, so we can get rid of the #ifdef CONFIG_HUGETLB_PAGE an let
> the compiler optimize this block away instead.  Doing this the code
> has a much cleaner appearance.

> Signed-off-by: David Daney <david.daney@cavium.com>

WBR, Sergei
