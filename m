Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Jan 2018 10:10:11 +0100 (CET)
Received: from verein.lst.de ([213.95.11.211]:57570 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990488AbeAOJKEageYY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 15 Jan 2018 10:10:04 +0100
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 513C36FA82; Mon, 15 Jan 2018 10:10:02 +0100 (CET)
Date:   Mon, 15 Jan 2018 10:10:02 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org,
        linux-mips@linux-mips.org, Michal Simek <monstr@monstr.eu>,
        linux-ia64@vger.kernel.org,
        Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Konrad Rzeszutek Wilk <konrad@darnok.org>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 10/22] swiotlb: refactor coherent buffer allocation
Message-ID: <20180115091002.GA398@lst.de>
References: <20180110080932.14157-1-hch@lst.de> <20180110080932.14157-11-hch@lst.de> <cecc98cf-2e6a-a7bc-7390-d6dcced038c4@arm.com> <20180110154649.GA18529@lst.de> <03c25dda-30da-9169-a8a1-1720ec741b9d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03c25dda-30da-9169-a8a1-1720ec741b9d@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62106
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
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

On Wed, Jan 10, 2018 at 05:02:30PM +0000, Robin Murphy wrote:
>>>
>>> Aren't we leaking the pages here?
>>
>> Yes, that free_pages got lost somewhere in the rebases, I've added
>> it back.
>
> Cool.

FYI, here is the fixed version, I don't want to re-send the whole
series for this fix:

http://git.infradead.org/users/hch/misc.git/commitdiff/0176adb004065d6815a8e67946752df4cd947c5b
