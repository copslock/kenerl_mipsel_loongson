Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Apr 2015 17:16:24 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:9751 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012146AbbD2PQXMw1Iu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Apr 2015 17:16:23 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 94DC6AA0A4242;
        Wed, 29 Apr 2015 16:16:16 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 29 Apr 2015 16:16:19 +0100
Received: from [192.168.154.77] (192.168.154.77) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 29 Apr
 2015 16:16:18 +0100
Message-ID: <5540F5C2.5090502@imgtec.com>
Date:   Wed, 29 Apr 2015 16:16:18 +0100
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     Huacai Chen <chenhc@lemote.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Kelvin Cheung <keguang.zhang@gmail.com>
Subject: Re: [PATCH V2] MIPS: Loongson: Naming style cleanup and rework
References: <1429581635-26476-1-git-send-email-chenhc@lemote.com>       <55361A86.9060000@imgtec.com> <CAAhV-H66XZB0Ytvc8mDQE6pqNmJsz4TY1zjh26Pp6rnSRU_Kcw@mail.gmail.com>
In-Reply-To: <CAAhV-H66XZB0Ytvc8mDQE6pqNmJsz4TY1zjh26Pp6rnSRU_Kcw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.77]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47163
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

On 04/22/2015 01:34 AM, Huacai Chen wrote:
> Really? I have seen many patches with their changelog in commit messages.
> 
> Huacai
> 

That's probably a mistake I'd say. A patch changelog has no value in the
commit message. You mostly care about the patch itself rather than how
it evolved over time before it reaches the final version. Especially
when you read the commit message after a few years.

-- 
markos
