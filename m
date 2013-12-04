Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Dec 2013 22:30:44 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:50302 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823977Ab3LDVal4xYL2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 4 Dec 2013 22:30:41 +0100
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id rB4LUIb0016870
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Wed, 4 Dec 2013 16:30:31 -0500
Received: from horse.usersys.redhat.com ([10.18.17.71])
        by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id rB4LUHte015667;
        Wed, 4 Dec 2013 16:30:17 -0500
Received: by horse.usersys.redhat.com (Postfix, from userid 10451)
        id 5390266BA6; Wed,  4 Dec 2013 16:30:17 -0500 (EST)
Date:   Wed, 4 Dec 2013 16:30:17 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Qais Yousef <qais.yousef@imgtec.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michael Holzheu <holzheu@linux.vnet.ibm.com>,
        linux-mips@linux-mips.org, stable@vger.kernel.org
Subject: Re: [PATCH] crash_dump: fix compilation error (on MIPS at least)
Message-ID: <20131204213017.GJ19087@redhat.com>
References: <1386172702-31266-1-git-send-email-qais.yousef@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1386172702-31266-1-git-send-email-qais.yousef@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.25
Return-Path: <vgoyal@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38641
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

pgprot_t definition for mips seems to be in asm/page.h. So why are you
including asm/pgtable.h and not asm/page.h? For other architectures it
seems to be in other files. That means those arch will have broken
compilation now. 

So question is, is there any arch specific file which one can include
and be covered for pgprot_t definition for all the arches.

Thanks
Vivek

> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: <linux-mips@linux-mips.org>
> Cc: <stable@vger.kernel.org> # 3.12
> Reviewed-by: James Hogan <james.hogan@imgtec.com>
> Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
> ---
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
