Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 May 2015 21:24:12 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:17701 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013073AbbETTYKfwOGY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 May 2015 21:24:10 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id ECEC7C7B353C9;
        Wed, 20 May 2015 20:24:02 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 20 May
 2015 20:23:05 +0100
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.224.2; Wed, 20 May
 2015 20:23:05 +0100
Received: from [10.20.3.79] (10.20.3.79) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Wed, 20 May
 2015 12:23:00 -0700
Message-ID: <555CDF14.70900@imgtec.com>
Date:   Wed, 20 May 2015 12:23:00 -0700
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     <linux-mips@linux-mips.org>, <rusty@rustcorp.com.au>,
        <alexinbeijing@gmail.com>, <paul.burton@imgtec.com>,
        <david.daney@cavium.com>, <alex@alex-smith.me.uk>,
        <linux-kernel@vger.kernel.org>, <ralf@linux-mips.org>,
        <james.hogan@imgtec.com>, <markos.chandras@imgtec.com>,
        <macro@linux-mips.org>, <eunb.song@samsung.com>,
        <manuel.lauss@gmail.com>, <andreas.herrmann@caviumnetworks.com>
Subject: Re: [PATCH 2/2] MIPS: MSA: bugfix of keeping MSA live context through
 clone or fork
References: <20150519211222.35859.52798.stgit@ubuntu-yegoshin> <20150519211359.35859.24907.stgit@ubuntu-yegoshin>
In-Reply-To: <20150519211359.35859.24907.stgit@ubuntu-yegoshin>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.20.3.79]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47501
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

Cancel this, please.

Reason - MSA registers are not supposed to be preserved through 
caller-called interface, including syscall.
In other side, keeping MSA context is expensive.

- Leonid.
