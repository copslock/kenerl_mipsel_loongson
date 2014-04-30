Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Apr 2014 10:34:51 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.89.28.114]:2101 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6816383AbaD3IesdB03W (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Apr 2014 10:34:48 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 299158BA5FD55
        for <linux-mips@linux-mips.org>; Wed, 30 Apr 2014 09:34:40 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Wed, 30 Apr
 2014 09:34:41 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Wed, 30 Apr 2014 09:34:41 +0100
Received: from [192.168.154.57] (192.168.154.57) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.174.1; Wed, 30 Apr
 2014 09:34:40 +0100
Message-ID: <5360B5A0.6020301@imgtec.com>
Date:   Wed, 30 Apr 2014 09:34:40 +0100
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
MIME-Version: 1.0
To:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: mm: Fix broken microMIPS kernel regression.
References: <1397156777-18759-1-git-send-email-Steven.Hill@imgtec.com>
In-Reply-To: <1397156777-18759-1-git-send-email-Steven.Hill@imgtec.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.57]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39988
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

On 04/10/2014 08:06 PM, Steven J. Hill wrote:
> From: "Steven J. Hill" <Steven.Hill@imgtec.com>
> 
> Commit f4ae17aa0f2122b52f642985b46210a1f2eceb0a broke microMIPS
> kernel builds. This patch refactors that code similar to what
> was done for the 'clear_page' and 'copy_page' functions.
> 
> Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
> ---

Hi Ralf,

If this patch is accepted, can we please consider it for the v3.14
stable kernel which is also affected?

Thanks

-- 
markos
