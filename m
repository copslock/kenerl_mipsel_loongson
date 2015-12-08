Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Dec 2015 02:19:23 +0100 (CET)
Received: from szxga03-in.huawei.com ([119.145.14.66]:22964 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008161AbbLHBTV0xEQC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Dec 2015 02:19:21 +0100
Received: from 172.24.1.50 (EHLO lggeml429-hub.china.huawei.com) ([172.24.1.50])
        by szxrg03-dlp.huawei.com (MOS 4.4.3-GA FastPath queued)
        with ESMTP id BSH23119;
        Tue, 08 Dec 2015 09:18:32 +0800 (CST)
Received: from [127.0.0.1] (10.177.23.4) by lggeml429-hub.china.huawei.com
 (10.72.61.81) with Microsoft SMTP Server id 14.3.235.1; Tue, 8 Dec 2015
 09:18:22 +0800
Subject: Re: [PATCH part3 v12 00/10] Cleanup platform pci_domain_nr()
To:     Bjorn Helgaas <helgaas@kernel.org>
References: <1437393678-4077-1-git-send-email-wangyijing@huawei.com>
 <20151207215356.GD14429@localhost>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@arm.linux.org.uk>, <dja@axtens.net>,
        <linux-xtensa@linux-xtensa.org>, <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-mips@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Rusty Russell <rusty@rustcorp.com.au>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-s390@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>, <linux-ia64@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        <linux-alpha@vger.kernel.org>, <linux-m68k@lists.linux-m68k.org>,
        <linux-am33-list@redhat.com>, Liviu Dudau <liviu@dudau.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
From:   wangyijing <wangyijing@huawei.com>
Message-ID: <56662FCE.40807@huawei.com>
Date:   Tue, 8 Dec 2015 09:18:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <20151207215356.GD14429@localhost>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.23.4]
X-CFilter-Loop: Reflected
X-Mirapoint-Virus-RAPID-Raw: score=unknown(0),
        refid=str=0001.0A090203.56662FEB.00E4,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0,
        ip=0.0.0.0,
        so=2013-05-26 15:14:31,
        dmn=2013-03-21 17:37:32
X-Mirapoint-Loop-Id: a6b93a47e1cf0aee86250994f755bfd7
Return-Path: <wangyijing@huawei.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50409
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wangyijing@huawei.com
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

> 
> Doesn't apply to v4.4-rc2.  Please refresh and repost if this is still
> relevant.

Hi Bjorn, this is still relevant, I will refresh it and post the new version soon.

Thanks!
Yijing.


> 
> .
> 
