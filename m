Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Nov 2015 14:13:10 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:14788 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012155AbbKCNNJYi0dD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Nov 2015 14:13:09 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 14B9D1757CDDF;
        Tue,  3 Nov 2015 13:12:57 +0000 (GMT)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.235.1; Tue, 3 Nov
 2015 13:12:58 +0000
Received: from [10.20.79.37] (10.20.79.37) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Tue, 3 Nov 2015
 05:12:56 -0800
Subject: Re: 4.1: XPA breaks Alchemy
To:     Manuel Lauss <manuel.lauss@gmail.com>,
        Linux-MIPS <linux-mips@linux-mips.org>
References: <CAOLZvyHPYF2kO2EdijCCX9OSt=hdo8g-tUXzZee0sSXT=-WdDw@mail.gmail.com>
 <CAOLZvyE3GYuU8E9Rico3bjRFs=4wn5mWfRf0NyCk_zJqxQTneg@mail.gmail.com>
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
Message-ID: <5638B2D7.9050809@imgtec.com>
Date:   Tue, 3 Nov 2015 07:12:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <CAOLZvyE3GYuU8E9Rico3bjRFs=4wn5mWfRf0NyCk_zJqxQTneg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.20.79.37]
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49820
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@imgtec.com
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

On 07/14/2015 01:28 AM, Manuel Lauss wrote:
> Ping
>
> This issue still exists in latest -git.  It goes away when
> CONFIG_PHYS_ADDR_T_64BIT
> is disabled, but then we lose PCI and PCMCIA (and other chipselect signals which
> are mapped beyond 4G).
>
> I'm going to look into this today if nobody beats me to it.
>
> Manuel
>
Hey Manuel.

I'm sorry that I did not pay attention and see this on the mailing list. 
I will get a fix out today (tomorrow your time).

Steve
