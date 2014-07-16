Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2014 09:44:32 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:22609 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6816671AbaGPHoa00kAi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Jul 2014 09:44:30 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 35BB95BF00AA3;
        Wed, 16 Jul 2014 08:44:22 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 16 Jul
 2014 08:44:23 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 16 Jul 2014 08:44:23 +0100
Received: from [192.168.154.67] (192.168.154.67) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 16 Jul
 2014 08:44:22 +0100
Message-ID: <53C62D56.7090401@imgtec.com>
Date:   Wed, 16 Jul 2014 08:44:22 +0100
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH 0/3] Use dedicated RI/XI exceptions for MIPSR5 cores
References: <1405429797-18281-1-git-send-email-markos.chandras@imgtec.com> <53C5780B.1090602@gmail.com>
In-Reply-To: <53C5780B.1090602@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.67]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41213
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

Hi David,

On 07/15/2014 07:50 PM, David Daney wrote:
> On 07/15/2014 06:09 AM, Markos Chandras wrote:
>> Hi,
>>
>> This patchset adds support for unique RI/XI exceptions. This feature has
>> been added in MIPSr5. Using this feature, we reduce the time it takes
>> to deal with a TLB exception caused by the RI/XI bits since the TLB load
>> handler is skipped and we use the tlb_do_page_failt_0 path directly.
>>
>> This patch depends on the Hardware Page Table Walker (HTW) patchset
>> http://www.linux-mips.org/archives/linux-mips/2014-07/msg00195.html
> 
> They are unrelated features, why the dependency?
Because of the conflicts in cpu.h and cpu-features.h. I am just trying
to make Ralf' life easier when he tries to determine the order to apply
this patches.

-- 
markos
