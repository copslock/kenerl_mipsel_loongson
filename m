Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Sep 2015 10:29:34 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:3338 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006709AbbIGI3cM0lMV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Sep 2015 10:29:32 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id CDB056917AFA5;
        Mon,  7 Sep 2015 09:29:24 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 7 Sep 2015 09:29:26 +0100
Received: from [192.168.154.88] (192.168.154.88) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 7 Sep
 2015 09:29:25 +0100
Subject: Re: [PATCH 1/2 for-4.3] MIPS: BPF: Avoid unreachable code on little
 endian
To:     Aurelien Jarno <aurelien@aurel32.net>, <linux-mips@linux-mips.org>
References: <1441471618-5613-1-git-send-email-aurelien@aurel32.net>
CC:     Ralf Baechle <ralf@linux-mips.org>
From:   Markos Chandras <Markos.Chandras@imgtec.com>
Message-ID: <55ED4AE5.6060404@imgtec.com>
Date:   Mon, 7 Sep 2015 09:29:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <1441471618-5613-1-git-send-email-aurelien@aurel32.net>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.88]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49118
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

On 09/05/2015 05:46 PM, Aurelien Jarno wrote:
> On little endian, avoid generating the big endian version of the code
> by using #else in addition to #ifdef #endif. Also fix one alignment
> issue wrt delay slot.
> 
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Markos Chandras <markos.chandras@imgtec.com>
> Cc: stable@vger.kernel.org # v4.2+
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> ---
>  arch/mips/net/bpf_jit_asm.S | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Markos Chandras <markos.chandras@imgtec.com>

-- 
markos
