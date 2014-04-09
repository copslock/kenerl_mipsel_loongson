Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Apr 2014 11:10:14 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.89.28.114]:33645 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6815804AbaDIJKMFwNk6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Apr 2014 11:10:12 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id A5C494C7B44F2;
        Wed,  9 Apr 2014 10:10:03 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Wed, 9 Apr 2014 10:10:05 +0100
Received: from [192.168.154.89] (192.168.154.89) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.174.1; Wed, 9 Apr
 2014 10:10:04 +0100
Message-ID: <53450E7E.1020700@imgtec.com>
Date:   Wed, 9 Apr 2014 10:10:22 +0100
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
MIME-Version: 1.0
To:     Paul Bolle <pebolle@tiscali.nl>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: Re: MIPS: Remove last traces of SMTC Support too?
References: <1397033309.22767.8.camel@x220> <53450BBE.7050501@imgtec.com> <1397034201.22767.15.camel@x220>
In-Reply-To: <1397034201.22767.15.camel@x220>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.89]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39741
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

On 04/09/2014 10:03 AM, Paul Bolle wrote:
> Hi Markos,
>
> On Wed, 2014-04-09 at 09:58 +0100, Markos Chandras wrote:
>> I talked to Ralf yesterday. It seems the patch was not applied correctly
>> and there are a few traces left. My original patch definitely removes
>> the traces listed in your patch.
>
> Assuming Ralf and you sort this out, and a complete removal of SMTC
> support will eventually hit linux-next, I won't be bothering you again.
>
> Thanks,
>
>
> Paul Bolle
>
Hi Paul,

As James pointed out, it seems there are a few traces of SMTC left even 
with my original patch. I will make sure everything is gone in time though.

-- 
markos
