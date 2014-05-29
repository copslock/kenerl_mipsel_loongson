Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 May 2014 12:20:35 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:55769 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6822134AbaE2KUeMHgRZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 29 May 2014 12:20:34 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s4TAKU8v023308;
        Thu, 29 May 2014 12:20:30 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s4TAKPDD023307;
        Thu, 29 May 2014 12:20:25 +0200
Date:   Thu, 29 May 2014 12:20:25 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Li Zefan <lizefan@huawei.com>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Yong Zhang <yong.zhang@windriver.com>, huawei.libin@huawei.com,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Xinwei Hu <huxinwei@huawei.com>
Subject: Re: [PATCH V2] MIPS: change type of asid_cache to unsigned long
Message-ID: <20140529102025.GF5157@linux-mips.org>
References: <1400650563-1033-1-git-send-email-yong.zhang@windriver.com>
 <5384119E.7010606@huawei.com>
 <20140528200929.GA30528@drone.musicnaut.iki.fi>
 <5386F663.4010401@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5386F663.4010401@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40349
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Thu, May 29, 2014 at 04:57:07PM +0800, Li Zefan wrote:

> I don't think Ralf has committed it, so we'll send out a fix
> with detailed changelog.

It's queued to go upstream, commit e5eb925a1804c4a52994ba57f4f68ee7a9132905.

  Ralf
