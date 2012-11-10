Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Nov 2012 22:28:40 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:57337 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6826554Ab2KJV2kU-uji (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 10 Nov 2012 22:28:40 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id qAALSc02029723;
        Sat, 10 Nov 2012 22:28:38 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id qAALSZd9029722;
        Sat, 10 Nov 2012 22:28:35 +0100
Date:   Sat, 10 Nov 2012 22:28:35 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Sanjay Lal <sanjayl@kymasys.com>
Cc:     kvm@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 01/20] KVM/MIPS32: Infrastructure/build files.
Message-ID: <20121110212835.GA26931@linux-mips.org>
References: <6A87701A-F946-489D-AFC3-3BC8B7723CE0@kymasys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6A87701A-F946-489D-AFC3-3BC8B7723CE0@kymasys.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34930
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Wed, Oct 31, 2012 at 11:17:22AM -0400, Sanjay Lal wrote:

> index 7dd65cf..d2cfe45 100644
> --- a/arch/mips/Kbuild
> +++ b/arch/mips/Kbuild
> @@ -17,3 +17,7 @@ obj- := $(platform-)
>  obj-y += kernel/
>  obj-y += mm/
>  obj-y += math-emu/
> +
> +ifdef CONFIG_KVM
> +obj-y += kvm/
> +endif

Shorter:

obj-$(CONFIG_KVM) += kvm/

  Ralf
