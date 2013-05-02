Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 May 2013 10:04:00 +0200 (CEST)
Received: from smtp-out-229.synserver.de ([212.40.185.229]:1047 "EHLO
        smtp-out-227.synserver.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6827452Ab3EBIDyv043S (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 May 2013 10:03:54 +0200
Received: (qmail 22245 invoked by uid 0); 2 May 2013 08:03:54 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@metafoo.de
X-SynServer-PPID: 22215
Received: from host-188-174-192-6.customer.m-online.net (HELO ?192.168.178.26?) [188.174.192.6]
  by 217.119.54.81 with AES256-SHA encrypted SMTP; 2 May 2013 08:03:53 -0000
Message-ID: <51821DC9.2010601@metafoo.de>
Date:   Thu, 02 May 2013 10:03:21 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
MIME-Version: 1.0
To:     eunb.song@samsung.com
CC:     "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Fix build error crash_dump.c file.
References: <21270808.191281367481634509.JavaMail.weblogic@epv6ml12>
In-Reply-To: <21270808.191281367481634509.JavaMail.weblogic@epv6ml12>
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36306
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
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

On 05/02/2013 10:00 AM, EUNBONG SONG wrote:
> 
> This patch fixes crash_dump.c build error.
> 

When fixing a compile error/warning you should always include the error
message in the commit log.

> Signed-off-by: Eunbong Song <eunb.song@samsung.com>
> ---
>  arch/mips/kernel/crash_dump.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/mips/kernel/crash_dump.c b/arch/mips/kernel/crash_dump.c
> index 35bed0d..3be9e7b 100644
> --- a/arch/mips/kernel/crash_dump.c
> +++ b/arch/mips/kernel/crash_dump.c
> @@ -2,6 +2,7 @@
>  #include <linux/bootmem.h>
>  #include <linux/crash_dump.h>
>  #include <asm/uaccess.h>
> +#include <linux/slab.h>
>  
>  static int __init parse_savemaxmem(char *p)
>  {
