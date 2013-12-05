Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Dec 2013 14:58:54 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:38153 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6831298Ab3LEN6sCui2a (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 5 Dec 2013 14:58:48 +0100
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id rB5DwaLE023154
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Thu, 5 Dec 2013 08:58:37 -0500
Received: from horse.usersys.redhat.com ([10.18.17.71])
        by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id rB5DwZQG017356;
        Thu, 5 Dec 2013 08:58:36 -0500
Received: by horse.usersys.redhat.com (Postfix, from userid 10451)
        id A08B166B5D; Thu,  5 Dec 2013 08:58:35 -0500 (EST)
Date:   Thu, 5 Dec 2013 08:58:35 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Qais Yousef <qais.yousef@imgtec.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michael Holzheu <holzheu@linux.vnet.ibm.com>,
        linux-mips@linux-mips.org, stable@vger.kernel.org
Subject: Re: [PATCH] crash_dump: fix compilation error (on MIPS at least)
Message-ID: <20131205135835.GA1600@redhat.com>
References: <1386172702-31266-1-git-send-email-qais.yousef@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1386172702-31266-1-git-send-email-qais.yousef@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.12
Return-Path: <vgoyal@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38660
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vgoyal@redhat.com
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

On Wed, Dec 04, 2013 at 03:58:22PM +0000, Qais Yousef wrote:
>   In file included from kernel/crash_dump.c:2:0:
>   include/linux/crash_dump.h:22:27: error: unknown type name ‘pgprot_t’
> 
> when CONFIG_CRASH_DUMP=y
> 
> The error was traced back to this commit:
> 
>   9cb218131de1 vmcore: introduce remap_oldmem_pfn_range()
> 
> include <asm/pgtable.h> to get the missing definition
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: <linux-mips@linux-mips.org>
> Cc: <stable@vger.kernel.org> # 3.12
> Reviewed-by: James Hogan <james.hogan@imgtec.com>
> Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
> ---

Looks good to me.

Acked-by: Vivek Goyal <vgoyal@redhat.com>

Vivek

> I haven't tried any other architecture except mips.
> If OK this should be considered for stable 3.12 (CCed).
> 
>  include/linux/crash_dump.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
> index fe68a5a..7032518 100644
> --- a/include/linux/crash_dump.h
> +++ b/include/linux/crash_dump.h
> @@ -6,6 +6,8 @@
>  #include <linux/proc_fs.h>
>  #include <linux/elf.h>
>  
> +#include <asm/pgtable.h> /* for pgprot_t */
> +
>  #define ELFCORE_ADDR_MAX	(-1ULL)
>  #define ELFCORE_ADDR_ERR	(-2ULL)
>  
> -- 
> 1.7.1
> 
