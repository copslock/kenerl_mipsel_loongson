Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jan 2017 17:28:20 +0100 (CET)
Received: from ares40.inai.de ([IPv6:2a01:4f8:141:23c8::40]:44994 "EHLO
        ares41.inai.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993920AbdALQ2OB9wmI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 Jan 2017 17:28:14 +0100
Received: by ares41.inai.de (Postfix, from userid 25121)
        id 83D0C720881F; Thu, 12 Jan 2017 17:28:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by ares41.inai.de (Postfix) with ESMTP id 695F880D55A0;
        Thu, 12 Jan 2017 17:28:13 +0100 (CET)
Date:   Thu, 12 Jan 2017 17:28:13 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Nicolas Dichtel <nicolas.dichtel@6wind.com>
cc:     Christoph Hellwig <hch@infradead.org>, arnd@arndb.de,
        mmarek@suse.com, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org,
        linux-mips@linux-mips.org, linux-am33-list@redhat.com,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org, dri-devel@lists.freedesktop.org,
        netdev@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mmc@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, linux-nfs@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-rdma@vger.kernel.org,
        fcoe-devel@open-fcoe.org, alsa-devel@alsa-project.org,
        linux-fbdev@vger.kernel.org, xen-devel@lists.xenproject.org,
        airlied@linux.ie, davem@davemloft.net
Subject: Re: [PATCH v2 7/7] uapi: export all headers under uapi directories
In-Reply-To: <464a1323-4450-e563-ff59-9e6d57b75959@6wind.com>
Message-ID: <alpine.LSU.2.20.1701121727180.19188@erq.vanv.qr>
References: <bf83da6b-01ef-bf44-b3e1-ca6fc5636818@6wind.com> <1483695839-18660-1-git-send-email-nicolas.dichtel@6wind.com> <1483695839-18660-8-git-send-email-nicolas.dichtel@6wind.com> <20170109125638.GA15506@infradead.org>
 <464a1323-4450-e563-ff59-9e6d57b75959@6wind.com>
User-Agent: Alpine 2.20 (LSU 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <jengelh@inai.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56282
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jengelh@inai.de
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

On Thursday 2017-01-12 16:52, Nicolas Dichtel wrote:

>Le 09/01/2017 à 13:56, Christoph Hellwig a écrit :
>> On Fri, Jan 06, 2017 at 10:43:59AM +0100, Nicolas Dichtel wrote:
>>> Regularly, when a new header is created in include/uapi/, the developer
>>> forgets to add it in the corresponding Kbuild file. This error is usually
>>> detected after the release is out.
>>>
>>> In fact, all headers under uapi directories should be exported, thus it's
>>> useless to have an exhaustive list.
>>>
>>> After this patch, the following files, which were not exported, are now
>>> exported (with make headers_install_all):
>> 
>> ... snip ...
>> 
>>> linux/genwqe/.install
>>> linux/genwqe/..install.cmd
>>> linux/cifs/.install
>>> linux/cifs/..install.cmd
>> 
>> I'm pretty sure these should not be exported!
>> 
>Those files are created in every directory:
>$ find usr/include/ -name '\.\.install.cmd' | wc -l
>71

That still does not mean they should be exported.

Anything but headers (and directories as a skeleton structure) is maximally suspicious.
