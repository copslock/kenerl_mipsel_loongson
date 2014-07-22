Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jul 2014 15:14:28 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:60927 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6826452AbaGVMcFz4tkq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Jul 2014 14:32:05 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 526E3999BDD15;
        Tue, 22 Jul 2014 13:31:56 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 22 Jul 2014 13:31:58 +0100
Received: from [192.168.154.158] (192.168.154.158) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 22 Jul
 2014 13:31:58 +0100
Message-ID: <53CE59BE.104@imgtec.com>
Date:   Tue, 22 Jul 2014 13:31:58 +0100
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@nsn.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
CC:     <stable@vger.kernel.org>
Subject: Re: [PATCH] MIPS: OCTEON: make get_system_type() thread-safe
References: <1406029868-6210-1-git-send-email-aaro.koskinen@nsn.com>
In-Reply-To: <1406029868-6210-1-git-send-email-aaro.koskinen@nsn.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.158]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41441
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

On 07/22/2014 12:51 PM, Aaro Koskinen wrote:
> get_system_type() is not thread-safe on OCTEON. It uses static data,
> also more dangerous issue is that it's calling cvmx_fuse_read_byte()
> every time without any synchronization. Currently it's possible to get
> processes stuck looping forever in kernel simply by launching multiple
> readers of /proc/cpuinfo:
> 
> 	(while true; do cat /proc/cpuinfo > /dev/null; done) &
> 	(while true; do cat /proc/cpuinfo > /dev/null; done) &
> 	...
> 
> Fix by initializing the system type string only once during the early
> boot.
> 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@nsn.com>
> Cc: stable@vger.kernel.org
> ---
>  arch/mips/cavium-octeon/setup.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 

It looks reasonable to me.

Reviewed-by: Markos Chandras <markos.chandras@imgtec.com>

-- 
markos
