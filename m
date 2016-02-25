Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Feb 2016 12:17:01 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:61023 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007194AbcBYLQ7tz430 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Feb 2016 12:16:59 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 5423D1ACE789B;
        Thu, 25 Feb 2016 11:16:52 +0000 (GMT)
Received: from [10.100.200.149] (10.100.200.149) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.266.1; Thu, 25 Feb 2016
 11:16:53 +0000
Date:   Thu, 25 Feb 2016 11:16:52 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Huacai Chen <chenhc@lemote.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH] MIPS: Introduce cpu_has_coherent_cache feature
In-Reply-To: <CAAhV-H5NW7NG0C9OU-qjCzPO-CB+pWmsh0RC0ZmKKmUx0U75=Q@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1602251116010.15885@tp.orcam.me.uk>
References: <1456324384-18118-1-git-send-email-chenhc@lemote.com> <1456324384-18118-3-git-send-email-chenhc@lemote.com> <alpine.DEB.2.00.1602250050170.15885@tp.orcam.me.uk> <CAAhV-H5NW7NG0C9OU-qjCzPO-CB+pWmsh0RC0ZmKKmUx0U75=Q@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.100.200.149]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52256
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

On Thu, 25 Feb 2016, Huacai Chen wrote:

> Joshua Kinard suggest me to split the patch, which you can see here:
> https://patchwork.linux-mips.org/patch/12324/
> If it is better to not split, please see my V2 patchset.

 Splitting is the correct action, however please answer my questions as 
well.

  Maciej
