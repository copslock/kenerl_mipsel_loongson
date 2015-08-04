Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Aug 2015 22:37:02 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:33081 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012454AbbHDUhAkglGi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Aug 2015 22:37:00 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id F035279567541;
        Tue,  4 Aug 2015 21:36:50 +0100 (IST)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 4 Aug
 2015 21:36:54 +0100
Received: from [10.20.3.79] (10.20.3.79) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Tue, 4 Aug 2015
 13:36:51 -0700
Message-ID: <55C12263.7070407@imgtec.com>
Date:   Tue, 4 Aug 2015 13:36:51 -0700
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     David Daney <ddaney@caviumnetworks.com>
CC:     David Daney <ddaney.cavm@gmail.com>, <linux-mips@linux-mips.org>,
        <ralf@linux-mips.org>, David Daney <david.daney@cavium.com>,
        <stable@vger.kernel.org>
Subject: Re: MIPS: Make set_pte() SMP safe.
References: <1438649323-1082-1-git-send-email-ddaney.cavm@gmail.com> <55C10F4B.2050003@imgtec.com> <55C11A37.5070509@caviumnetworks.com> <55C1214F.8050208@imgtec.com>
In-Reply-To: <55C1214F.8050208@imgtec.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.20.3.79]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48572
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Leonid.Yegoshin@imgtec.com
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

David,

Note: Excuse me for bothering you but if guard page logic doesn't work 
anymore then it can be scraped. It allows me to optimize some cache 
flushes in VMAP area - instead of flushing a full cache, just flush a 
range of pages.

- Leonid.
