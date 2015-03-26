Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Mar 2015 13:32:16 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:57135 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27014639AbbCZMcMbdErL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 26 Mar 2015 13:32:12 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t2QCW6HD012046;
        Thu, 26 Mar 2015 13:32:06 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t2QCW5c8012045;
        Thu, 26 Mar 2015 13:32:05 +0100
Date:   Thu, 26 Mar 2015 13:32:05 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Subject: Re: [PATCH V8 6/8] MIPS: Loongson-3: Add CPU Hwmon platform driver
Message-ID: <20150326123204.GB9705@linux-mips.org>
References: <1426213706-28542-1-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1426213706-28542-1-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46540
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

On Fri, Mar 13, 2015 at 10:28:25AM +0800, Huacai Chen wrote:

> +MODULE_AUTHOR("Yu Xiang <xiangy@lemote.com>");
> +MODULE_AUTHOR("Huacai Chen <chenhc@lemote.com>");
> +MODULE_DESCRIPTION("Loongson CPU Hwmon driver");

No MODULE_LICENSE()?  May I add a MODULE_LICENSE("GPL")?

  Ralf
