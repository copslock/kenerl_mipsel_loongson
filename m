Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Aug 2014 11:07:46 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:7001 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006505AbaH2JHpAh1yB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Aug 2014 11:07:45 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id D3D558DE6AB46
        for <linux-mips@linux-mips.org>; Fri, 29 Aug 2014 10:07:35 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 29 Aug
 2014 10:07:38 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 29 Aug 2014 10:07:38 +0100
Received: from [192.168.154.67] (192.168.154.67) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 29 Aug
 2014 10:07:37 +0100
Message-ID: <540042D9.1050208@imgtec.com>
Date:   Fri, 29 Aug 2014 10:07:37 +0100
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
MIME-Version: 1.0
To:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Loongson: Fix the write-combine CCA value setting
References: <1409283416-16926-1-git-send-email-chenhc@lemote.com>
In-Reply-To: <1409283416-16926-1-git-send-email-chenhc@lemote.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.67]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42319
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

On 08/29/2014 04:36 AM, Huacai Chen wrote:
> All Loongson-2/3 processors support _CACHE_UNCACHED_ACCELERATED, not
> only Loongson-3A.
> 
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
Hi,

Thanks for the patch.

Ralf, perhaps you can merge it with

http://git.linux-mips.org/?p=ralf/upstream-sfr.git;a=commit;h=2ac2118deca510649c15b0ba6ce433c37bba345c

Thanks in advance.

-- 
markos
