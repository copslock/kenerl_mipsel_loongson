Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 May 2014 13:53:06 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:11034 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6837162AbaEULxC6SSLf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 May 2014 13:53:02 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id AAFD24B687686
        for <linux-mips@linux-mips.org>; Wed, 21 May 2014 12:52:52 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Wed, 21 May
 2014 12:52:55 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Wed, 21 May 2014 12:52:54 +0100
Received: from [192.168.154.137] (192.168.154.137) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.174.1; Wed, 21 May
 2014 12:52:54 +0100
Message-ID: <537C9395.1000700@imgtec.com>
Date:   Wed, 21 May 2014 12:52:53 +0100
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Fix a typo error in AUDIT_ARCH definition
References: <1400640559-29867-1-git-send-email-chenhc@lemote.com>
In-Reply-To: <1400640559-29867-1-git-send-email-chenhc@lemote.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.137]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40215
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

On 05/21/2014 03:49 AM, Huacai Chen wrote:
> Missing a "|" in AUDIT_ARCH_MIPSEL64N32 macro definition.
> 
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---

Ooops sorry about that. Thanks for fixing it. Ralf, can we have this for
3.15 please?

Reviewed-by: Markos Chandras <markos.chandras@imgtec.com>

-- 
markos
