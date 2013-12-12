Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Dec 2013 15:42:35 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:31895 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6867261Ab3LLOmc59GZH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 12 Dec 2013 15:42:32 +0100
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id rBCEg2mk008225
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Thu, 12 Dec 2013 09:42:03 -0500
Received: from horse.usersys.redhat.com ([10.18.17.71])
        by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id rBCEg1kL013005;
        Thu, 12 Dec 2013 09:42:01 -0500
Received: by horse.usersys.redhat.com (Postfix, from userid 10451)
        id 3E20765FE2; Thu, 12 Dec 2013 09:42:01 -0500 (EST)
Date:   Thu, 12 Dec 2013 09:42:01 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Qais Yousef <Qais.Yousef@imgtec.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Holzheu <holzheu@linux.vnet.ibm.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] crash_dump: fix compilation error (on MIPS at least)
Message-ID: <20131212144201.GA31540@redhat.com>
References: <1386172702-31266-1-git-send-email-qais.yousef@imgtec.com>
 <20131205135835.GA1600@redhat.com>
 <392C4BDEFF12D14FA57A3F30B283D7D13C7764@LEMAIL01.le.imgtec.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <392C4BDEFF12D14FA57A3F30B283D7D13C7764@LEMAIL01.le.imgtec.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Return-Path: <vgoyal@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38699
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

Generally akpm picks the kexec/kdump arch independent changes. 

Andrew, can you please consider this patch for inclusion.

Thanks
Vivek

On Wed, Dec 11, 2013 at 11:43:32AM +0000, Qais Yousef wrote:
> > -----Original Message-----
> > From: Vivek Goyal [mailto:vgoyal@redhat.com]
> > Sent: 05 December 2013 13:59
> > To: Qais Yousef
> > Cc: linux-kernel@vger.kernel.org; Andrew Morton; Michael Holzheu; linux-
> > mips@linux-mips.org; stable@vger.kernel.org
> > Subject: Re: [PATCH] crash_dump: fix compilation error (on MIPS at least)
> > 
> > On Wed, Dec 04, 2013 at 03:58:22PM +0000, Qais Yousef wrote:
> > >   In file included from kernel/crash_dump.c:2:0:
> > >   include/linux/crash_dump.h:22:27: error: unknown type name ‘pgprot_t’
> > >
> > > when CONFIG_CRASH_DUMP=y
> > >
> > > The error was traced back to this commit:
> > >
> > >   9cb218131de1 vmcore: introduce remap_oldmem_pfn_range()
> > >
> > > include <asm/pgtable.h> to get the missing definition
> > >
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> > > Cc: Vivek Goyal <vgoyal@redhat.com>
> > > Cc: <linux-mips@linux-mips.org>
> > > Cc: <stable@vger.kernel.org> # 3.12
> > > Reviewed-by: James Hogan <james.hogan@imgtec.com>
> > > Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
> > > ---
> > 
> > Looks good to me.
> > 
> > Acked-by: Vivek Goyal <vgoyal@redhat.com>
> > 
> > Vivek
> 
> Hi,
> 
> I failed to see this picked up by anyone. I'm not sure which tree it should go to to be honest. Do I need to add more people to the Cc? Or am I just being impatient? :)
> 
> Thanks,
> Qais
> 
> > 
> > > I haven't tried any other architecture except mips.
> > > If OK this should be considered for stable 3.12 (CCed).
> > >
> > >  include/linux/crash_dump.h |    2 ++
> > >  1 files changed, 2 insertions(+), 0 deletions(-)
> > >
> > > diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
> > > index fe68a5a..7032518 100644
> > > --- a/include/linux/crash_dump.h
> > > +++ b/include/linux/crash_dump.h
> > > @@ -6,6 +6,8 @@
> > >  #include <linux/proc_fs.h>
> > >  #include <linux/elf.h>
> > >
> > > +#include <asm/pgtable.h> /* for pgprot_t */
> > > +
> > >  #define ELFCORE_ADDR_MAX	(-1ULL)
> > >  #define ELFCORE_ADDR_ERR	(-2ULL)
> > >
> > > --
> > > 1.7.1
> > >
