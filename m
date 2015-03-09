Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Mar 2015 16:24:57 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:60796 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007660AbbCIPYqY6FAR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Mar 2015 16:24:46 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 730B288BFB8F8
        for <linux-mips@linux-mips.org>; Mon,  9 Mar 2015 15:24:38 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 9 Mar 2015 15:24:41 +0000
Received: from [192.168.154.96] (192.168.154.96) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 9 Mar
 2015 15:24:40 +0000
Message-ID: <54FDBB38.4070600@imgtec.com>
Date:   Mon, 9 Mar 2015 15:24:40 +0000
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH 4/4] MIPS; asm: bitops: Add missing ISA levels for MIPS
 R6
References: <1425408530-21613-1-git-send-email-markos.chandras@imgtec.com> <1425408530-21613-5-git-send-email-markos.chandras@imgtec.com>
In-Reply-To: <1425408530-21613-5-git-send-email-markos.chandras@imgtec.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.96]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46294
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

On 03/03/2015 06:48 PM, Markos Chandras wrote:
> Commit 87a927eff4da("MIPS: asm: bitops: update ISA constraints for
> MIPS R6 support") replaced hardcoded ISA levels in order to support
> MIPS R6 new opcodes but it missed a few cases.
> 
> Fixes: 87a927eff4da("MIPS: asm: bitops: update ISA constraints for MIPS R6 support")
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> ---

This patch is not needed since it introduced new ".set" statements for
no good reason. I marked it as rejected in patchwork.

-- 
markos
