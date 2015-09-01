Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Sep 2015 16:11:47 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:3864 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007213AbbIAOLnf1fbe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Sep 2015 16:11:43 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 9A4D8401302B6;
        Tue,  1 Sep 2015 15:11:34 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 1 Sep 2015 15:11:37 +0100
Received: from [192.168.154.168] (192.168.154.168) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 1 Sep
 2015 15:11:36 +0100
Subject: Re: [PATCH v2] MIPS: Fix console output for Fulong2e system
To:     Guenter Roeck <linux@roeck-us.net>,
        Ralf Baechle <ralf@linux-mips.org>
References: <1440994798-14032-1-git-send-email-linux@roeck-us.net>
CC:     Huacai Chen <chenhc@lemote.com>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
From:   Markos Chandras <Markos.Chandras@imgtec.com>
X-Enigmail-Draft-Status: N1110
Message-ID: <55E5B218.2050506@imgtec.com>
Date:   Tue, 1 Sep 2015 15:11:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <1440994798-14032-1-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.168]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49073
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

On 08/31/2015 05:19 AM, Guenter Roeck wrote:
> Commit 3adeb2566b9b ("MIPS: Loongson: Improve LEFI firmware interface")
> made the number of UARTs dynamic if LEFI_FIRMWARE_INTERFACE is configured.
> Unfortunately, it did not initialize the number of UARTs if
> LEFI_FIRMWARE_INTERFACE is not configured. As a result, the Fulong2e
> system has no console.
> 
> Fixes: 3adeb2566b9b ("MIPS: Loongson: Improve LEFI firmware interface")
> Acked-by: Huacai Chen <chenhc@lemote.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---

Tested-by: Markos Chandras <markos.chandras@imgtec.com>

-- 
markos
