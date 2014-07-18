Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Jul 2014 12:05:50 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:61222 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6861334AbaGRKFrxG0ge (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Jul 2014 12:05:47 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 6B6D43427808F;
        Fri, 18 Jul 2014 11:05:39 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 18 Jul 2014 11:05:41 +0100
Received: from [192.168.154.109] (192.168.154.109) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 18 Jul
 2014 11:05:40 +0100
Message-ID: <53C8F174.70603@imgtec.com>
Date:   Fri, 18 Jul 2014 11:05:40 +0100
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH 7/7] MIPS: GIC: Fix GICBIS macro
References: <1405585259-24941-1-git-send-email-markos.chandras@imgtec.com> <1405585259-24941-8-git-send-email-markos.chandras@imgtec.com> <53C7C5E2.1020307@cogentembedded.com> <53C8D2AE.3020300@imgtec.com>
In-Reply-To: <53C8D2AE.3020300@imgtec.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.109]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41311
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

On 07/18/2014 08:54 AM, Jeffrey Deans wrote:
> 
>>
>>> +        data &= ~(mask);        \
>>> +        data |= ((bits) & (mask));    \
>>
>>     Outer () not needed.
> 
> Agreed.
> 
Thanks for the review. This is a minor fix and I see no reason for v2.
Ralf could you please remove the outer () when you get to apply this patch?

Thanks!

-- 
markos
