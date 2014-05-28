Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 May 2014 22:09:39 +0200 (CEST)
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:41847 "EHLO
        filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6854780AbaE1UJh16qqx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 May 2014 22:09:37 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri5.pp.htv.fi (Postfix) with ESMTP id 6E9345A6F93;
        Wed, 28 May 2014 23:09:32 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp6.welho.com ([213.243.153.40])
        by localhost (filtteri5.pp.htv.fi [213.243.153.188]) (amavisd-new, port 10024)
        with ESMTP id nhSVhLRGnp5z; Wed, 28 May 2014 23:09:25 +0300 (EEST)
Received: from drone (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp6.welho.com (Postfix) with ESMTP id 1C7175BC004;
        Wed, 28 May 2014 23:09:30 +0300 (EEST)
Date:   Wed, 28 May 2014 23:09:29 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Li Zefan <lizefan@huawei.com>
Cc:     Yong Zhang <yong.zhang@windriver.com>, ralf@linux-mips.org,
        huawei.libin@huawei.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Xinwei Hu <huxinwei@huawei.com>
Subject: Re: [PATCH V2] MIPS: change type of asid_cache to unsigned long
Message-ID: <20140528200929.GA30528@drone.musicnaut.iki.fi>
References: <1400650563-1033-1-git-send-email-yong.zhang@windriver.com>
 <5384119E.7010606@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5384119E.7010606@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40289
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

On Tue, May 27, 2014 at 12:16:30PM +0800, Li Zefan wrote:
> On 2014/5/21 13:36, Yong Zhang wrote:
> > asid_cache must be unsigned long otherwise on 64bit system
> > it will become 0 if the value in get_new_mmu_context()
> > reaches 0xffffffff and in the end the assumption of
> > ASID_FIRST_VERSION is not true anymore thus leads to
> > more dangerous things.
> 
> We should describe what problem this bug can lead to, which
> will help people who encounter the same problem and google it.

Please describe it, then. Even if the patch is already committed,
googling would probably still find this e-mail thread.

Thanks,

A.
