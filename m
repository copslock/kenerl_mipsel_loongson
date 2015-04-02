Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Apr 2015 14:46:33 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:43263 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27013844AbbDBMqbnfcLP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 2 Apr 2015 14:46:31 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t32CkUkF020938;
        Thu, 2 Apr 2015 14:46:30 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t32CkSOm020937;
        Thu, 2 Apr 2015 14:46:28 +0200
Date:   Thu, 2 Apr 2015 14:46:28 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Subject: Re: [PATCH V9 6/7] MIPS: Loongson-3: Add chipset ACPI platform driver
Message-ID: <20150402124628.GD20157@linux-mips.org>
References: <1427597650-2368-1-git-send-email-chenhc@lemote.com>
 <1427597650-2368-7-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1427597650-2368-7-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46700
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

On Sun, Mar 29, 2015 at 10:54:10AM +0800, Huacai Chen wrote:

>  arch/mips/loongson/common/pci.c   |    6 ++
>  drivers/platform/mips/Makefile    |    3 +
>  drivers/platform/mips/acpi_init.c |  150 +++++++++++++++++++++++++++++++++++++

Applied - but:

This isn't even a proper driver but rather a collection of subroutines.
I wonder this has to reside in drivers/platform/mips, not in drivers/acpi/
or even in the Loongson arch code?

> diff --git a/drivers/platform/mips/Makefile b/drivers/platform/mips/Makefile
> index 8dfd039..522c8e1 100644
> --- a/drivers/platform/mips/Makefile
> +++ b/drivers/platform/mips/Makefile
> @@ -1 +1,4 @@
> +ifdef CONFIG_CPU_LOONGSON3
> +obj-y += acpi_init.o
>  obj-$(CONFIG_CPU_HWMON) += cpu_hwmon.o
> +endif

This is where the yelling starts.  A Makefile that doesn't define any
obj-* or lib-* variables such as this one if CONFIG_CPU_LOONGSON3 is
undefined, will break the build.  In other words, this hasn't been tested
on even a single other platform.  I've fixed this but it's normally
up to the submitter to ensure this sort of thing doesn't happen.

  Ralf
