Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Aug 2015 02:06:45 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:41374 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012495AbbHFAGmkvuD1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Aug 2015 02:06:42 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id B1F34AAF0AA5B;
        Thu,  6 Aug 2015 01:06:32 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 6 Aug
 2015 01:06:37 +0100
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.235.1; Thu, 6 Aug
 2015 01:06:36 +0100
Received: from [10.20.3.79] (10.20.3.79) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Wed, 5 Aug 2015
 17:06:33 -0700
Message-ID: <55C2A50A.50805@imgtec.com>
Date:   Wed, 5 Aug 2015 17:06:34 -0700
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Paul Burton <paul.burton@imgtec.com>
CC:     <daniel.sanders@imgtec.com>, <linux-mips@linux-mips.org>,
        <cernekee@gmail.com>, <Zubair.Kakakhel@imgtec.com>,
        <geert+renesas@glider.be>, <david.daney@cavium.com>,
        <peterz@infradead.org>, <heiko.carstens@de.ibm.com>,
        <paul.gortmaker@windriver.com>, <behanw@converseincode.com>,
        <macro@linux-mips.org>, <cl@linux.com>, <pkarat@mvista.com>,
        <linux@roeck-us.net>, <tkhai@yandex.ru>, <james.hogan@imgtec.com>,
        <alexinbeijing@gmail.com>, <rusty@rustcorp.com.au>,
        <Steven.Hill@imgtec.com>, <lars.persson@axis.com>,
        <aleksey.makarov@auriga.com>, <linux-kernel@vger.kernel.org>,
        <ralf@linux-mips.org>, <luto@amacapital.net>,
        <dahi@linux.vnet.ibm.com>, <markos.chandras@imgtec.com>,
        <eunb.song@samsung.com>, <kumba@gentoo.org>
Subject: Re: [PATCH v4 3/3] MIPS: set stack/data protection as non-executable
References: <20150805234348.20722.71740.stgit@ubuntu-yegoshin> <20150805234936.20722.60927.stgit@ubuntu-yegoshin> <20150805235543.GG2057@NP-P-BURTON>
In-Reply-To: <20150805235543.GG2057@NP-P-BURTON>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.20.3.79]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48637
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

On 08/05/2015 04:55 PM, Paul Burton wrote:
>
>
> As was pointed out last time you posted this, it breaks backwards
> compatibility with userland & thus cannot be applied.

Never observed since first version.

In other side, the problem with apps like ssh_keygen is observed in 
absence of executable stack protection.

- Leonid.
