Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 May 2014 07:23:25 +0200 (CEST)
Received: from mail.windriver.com ([147.11.1.11]:55049 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822096AbaE0FXWrrNJ0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 May 2014 07:23:22 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail.windriver.com (8.14.5/8.14.5) with ESMTP id s4R5NAjP011137
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
        Mon, 26 May 2014 22:23:10 -0700 (PDT)
Received: from localhost (128.224.162.188) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.169.1; Mon, 26 May
 2014 22:23:09 -0700
Date:   Tue, 27 May 2014 13:23:07 +0800
From:   Yong Zhang <yong.zhang@windriver.com>
To:     Li Zefan <lizefan@huawei.com>
CC:     <ralf@linux-mips.org>, <huawei.libin@huawei.com>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        Xinwei Hu <huxinwei@huawei.com>
Subject: Re: [PATCH V2] MIPS: change type of asid_cache to unsigned long
Message-ID: <20140527052307.GA16493@pek-yzhang-d1>
Reply-To: Yong Zhang <yong.zhang@windriver.com>
References: <1400650563-1033-1-git-send-email-yong.zhang@windriver.com>
 <5384119E.7010606@huawei.com>
 <20140527045038.GB16193@pek-yzhang-d1>
 <53841D88.3040306@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <53841D88.3040306@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [128.224.162.188]
Return-Path: <yong.zhang@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40276
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yong.zhang@windriver.com
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

On Tue, May 27, 2014 at 01:07:20PM +0800, Li Zefan wrote:
> On 2014/5/27 12:50, Yong Zhang wrote:
> > BTW, I realy don't care who credits the patch and Ralf said that
> > he will applied the one which moves the place of udelay_val.
> > 
> > Anyway, if your company pays you more money if you contribute to
> > the community, just take it and talk about it with Ralf ;-)
> > 
> 
> We don't do contribution for money, and I don't think you do,
> but crediting properly is one of the reason that our kernel
> community keeps prosperous for so many years, and that's one
> of the reason we introduced Reported-by and Tested-by tags.

I'll reply this email for the last time.

To me your action is just like Reported-by, but I admit that
you also do analysis. If you don't the way change it to whatever
you want.

Thanks,
Yong
