Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Mar 2014 10:25:42 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.89.28.114]:44741 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6816288AbaCGJZjRAc74 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Mar 2014 10:25:39 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 6B5B64367FA65
        for <linux-mips@linux-mips.org>; Fri,  7 Mar 2014 09:25:31 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Fri, 7 Mar 2014 09:25:33 +0000
Received: from [192.168.154.65] (192.168.154.65) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.174.1; Fri, 7 Mar
 2014 09:25:32 +0000
Message-ID: <5319908C.4060008@imgtec.com>
Date:   Fri, 7 Mar 2014 09:25:32 +0000
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
CC:     <linux-mips@linux-mips.org>, <paul.burton@imgtec.com>,
        <Leonid.Yegoshin@imgtec.com>, <Steven.Hill@imgtec.com>
Subject: Re: [PATCH] MIPS FPU emulator: Fix prefx detection and COP1X function
 field definition
References: <1394154327-16677-1-git-send-email-dengcheng.zhu@imgtec.com>
In-Reply-To: <1394154327-16677-1-git-send-email-dengcheng.zhu@imgtec.com>
X-Enigmail-Version: 1.5.2
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.65]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39440
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

On 07/03/14 01:05, Deng-Cheng Zhu wrote:
> From: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
> 
> When running applications which contain the instruction "prefx" on FPU-less
> CPUs, a message "Illegal instruction" will be seen. This instruction is
> supposed to be ignored by the FPU emulator. However, its current detection
> and function field encoding are incorrect. This patch fix the issue.
> 
> Reviewed-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> Reviewed-by: Paul Burton <paul.burton@imgtec.com>
> Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>

This appears to go back to the beginning of the git era (remove "uapi"
for older versions). It should probably be marked for stable when applied.

Cheers
James
