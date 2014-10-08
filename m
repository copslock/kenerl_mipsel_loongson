Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Oct 2014 15:28:59 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:47356 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010840AbaJHN2zQy0DB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Oct 2014 15:28:55 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id B3AE1710EDB20
        for <linux-mips@linux-mips.org>; Wed,  8 Oct 2014 14:28:45 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 8 Oct 2014 14:28:48 +0100
Received: from [192.168.154.56] (192.168.154.56) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 8 Oct
 2014 14:28:47 +0100
Message-ID: <54353C0F.6000704@imgtec.com>
Date:   Wed, 8 Oct 2014 14:28:47 +0100
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
MIME-Version: 1.0
To:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH v2] MIPS: Kconfig: Add choice symbol to select microMIPS
 or SmartMIPS
References: <1401785177-7904-1-git-send-email-markos.chandras@imgtec.com> <1405928774-20630-1-git-send-email-markos.chandras@imgtec.com>
In-Reply-To: <1405928774-20630-1-git-send-email-markos.chandras@imgtec.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.56]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43111
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

On 07/21/2014 08:46 AM, Markos Chandras wrote:
> microMIPS and SmartMIPS can't be used together. This fixes the
> following build problem:
> 
> Warning: the 32-bit microMIPS architecture does not support the `smartmips'
> extension
> arch/mips/kernel/entry.S:90: Error: unrecognized opcode `mtlhx $24'
> [...]
> arch/mips/kernel/entry.S:109: Error: unrecognized opcode `mtlhx $24'
> 
> Link: https://dmz-portal.mips.com/bugz/show_bug.cgi?id=1021
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> ---
> Hi Ralf,
> 
> Here is v2 of that patch, making SmartMIPS and microMIPS a
> choice symbol as you requested in
> http://www.linux-mips.org/archives/linux-mips/2014-06/msg00011.html
> 
> However, I still feel this is wrong since these two ASEs are completely
> unrelated. The v1 of the patch is probably better in my opinion.
> If the user fails to find the 'smartmips' option due to having 'micromips'
> enabled, he/she can always search for the 'smartmips' symbol in the
> menuconfig and he/she will notice the dependency on !micromips.
> And if the user knows what he is doing he will probably never want to
> use 'smartmips' and 'micromips' together.
> ---
> 
Hi,

Any comments on that one?

-- 
markos
