Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Apr 2017 13:32:51 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:59023 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990557AbdDGLcpFimTW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Apr 2017 13:32:45 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id B7EC54845ACB;
        Fri,  7 Apr 2017 12:32:36 +0100 (IST)
Received: from [10.80.2.5] (10.80.2.5) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 7 Apr
 2017 12:32:39 +0100
Subject: Re: [PATCH] MIPS: Use common outgoing-CPU-notification code
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Ralf Baechle <ralf@linux-mips.org>
References: <1491559974-20197-1-git-send-email-marcin.nowakowski@imgtec.com>
 <57852660-ca40-0fb5-14b9-5e9e69cde907@cogentembedded.com>
CC:     <linux-mips@linux-mips.org>
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Message-ID: <09d0ef07-c66b-1cbd-4895-0f8ac03352a7@imgtec.com>
Date:   Fri, 7 Apr 2017 13:32:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <57852660-ca40-0fb5-14b9-5e9e69cde907@cogentembedded.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.2.5]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57618
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marcin.nowakowski@imgtec.com
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

Hi,

On 07.04.2017 13:04, Sergei Shtylyov wrote:
> Hello!
>
> On 4/7/2017 1:12 PM, Marcin Nowakowski wrote:
>
>> This commit removes the open-coded CPU-offline notification with new
>
>    Replaces, perhaps?
>

Yeah, that will be better. I'll send an updated version.

thanks
Marcin
