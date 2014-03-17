Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Mar 2014 10:27:07 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.89.28.115]:47591 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6817552AbaCQJ1FbtGnm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Mar 2014 10:27:05 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 2D474F9E1F107;
        Mon, 17 Mar 2014 09:26:58 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Mon, 17 Mar 2014 09:26:59 +0000
Received: from [192.168.154.136] (192.168.154.136) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.174.1; Mon, 17 Mar
 2014 09:26:59 +0000
Message-ID: <5326BFE1.2060400@imgtec.com>
Date:   Mon, 17 Mar 2014 09:26:57 +0000
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
MIME-Version: 1.0
To:     Lars Persson <lars.persson@axis.com>, <linux-mips@linux-mips.org>
CC:     Lars Persson <larper@axis.com>
Subject: Re: [PATCH] MIPS: Fix syscall tracing interface
References: <1395042021-6186-1-git-send-email-larper@axis.com>
In-Reply-To: <1395042021-6186-1-git-send-email-larper@axis.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.136]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39479
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

Hi Lars,

On 03/17/2014 07:40 AM, Lars Persson wrote:
> The MIPS syscall tracing interface had multiple bugs
> that made it completely unusable.
>
> Signed-off-by: Lars Persson <larper@axis.com>

The last part of your patch will conflict with

http://patchwork.linux-mips.org/patch/6402/

which is already in the linux-next tree.

The rest of the changes look reasonable to me.

I believe it is best if you base your patches on 
upstream-sfr/mips-for-linux-next[1] branch.

[1] 
http://git.linux-mips.org/?p=ralf/upstream-sfr.git;a=shortlog;h=refs/heads/mips-for-linux-next

-- 
markos
