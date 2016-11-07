Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Nov 2016 21:06:33 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:1385 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991986AbcKGUG1XjW58 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Nov 2016 21:06:27 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id A51A273E0762;
        Mon,  7 Nov 2016 20:06:17 +0000 (GMT)
Received: from HHMAIL-X.hh.imgtec.org (10.100.10.113) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 7 Nov 2016 20:06:21 +0000
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by HHMAIL-X.hh.imgtec.org
 (10.100.10.113) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 7 Nov
 2016 20:06:21 +0000
Received: from [10.20.2.61] (10.20.2.61) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.266.1; Mon, 7 Nov 2016
 12:06:18 -0800
Message-ID: <5820DEBA.6080800@imgtec.com>
Date:   Mon, 7 Nov 2016 12:06:18 -0800
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Sven Schnelle <svens@stackframe.org>, <linux-mips@linux-mips.org>
Subject: Re: MIPS: MIPS74K needs post dma flush
References: <20161107194128.25086-2-svens@stackframe.org>
In-Reply-To: <20161107194128.25086-2-svens@stackframe.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.20.2.61]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55720
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

74K does NOT have an aggressive speculation, never for D-Cache, never 
for I-cache. D-Cache doesn't an advance speculation load at all, I-cache 
never does a wrong speculation.

So, post-DMA flush is not needed in any form.

- Leonid.
