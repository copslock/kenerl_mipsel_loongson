Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jun 2012 11:32:18 +0200 (CEST)
Received: from mail1.windriver.com ([147.11.146.13]:38270 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903394Ab2FSJcN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Jun 2012 11:32:13 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
        by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q5J9W3ja026664
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
        Tue, 19 Jun 2012 02:32:03 -0700 (PDT)
Received: from localhost (128.224.162.203) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.1.255.0; Tue, 19 Jun
 2012 02:32:02 -0700
Date:   Tue, 19 Jun 2012 17:32:00 +0800
From:   Yong Zhang <yong.zhang@windriver.com>
To:     Huacai Chen <chenhuacai@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: Re: [PATCH V2 15/16] MIPS: Loongson 3: Add CPU Hotplug support.
Message-ID: <20120619093200.GC305@windriver.com>
Reply-To: Yong Zhang <yong.zhang@windriver.com>
References: <1340088624-25550-1-git-send-email-chenhc@lemote.com>
 <1340088624-25550-16-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <1340088624-25550-16-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [128.224.162.203]
X-archive-position: 33712
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Tue, Jun 19, 2012 at 02:50:23PM +0800, Huacai Chen wrote:
> +#ifdef CONFIG_HOTPLUG_CPU
> +
> +static DEFINE_SPINLOCK(smp_reserve_lock);

Do you really need this lock?

Thanks,
Yong
