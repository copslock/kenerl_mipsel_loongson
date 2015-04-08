Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Apr 2015 11:48:31 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:56966 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010412AbbDHJs3KIXkF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 8 Apr 2015 11:48:29 +0200
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t389kHCj006602
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 8 Apr 2015 05:46:17 -0400
Received: from krava.redhat.com (vpn-202-41.tlv.redhat.com [10.35.202.41])
        by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id t389k8BP019512;
        Wed, 8 Apr 2015 05:46:12 -0400
Date:   Wed, 8 Apr 2015 11:46:06 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     David Daney <david.daney@cavium.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Paul Mackerras <paulus@samba.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: Re: [PATCH 1/2] perf tools: Add support for MIPS userspace DWARF
 callchains.
Message-ID: <20150408094606.GA14284@krava.redhat.com>
References: <cover.1428450297.git.ralf@linux-mips.org>
 <2ed9bd678ec4f448c0a312f8a4cdafe5d5caefa2.1428450297.git.ralf@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ed9bd678ec4f448c0a312f8a4cdafe5d5caefa2.1428450297.git.ralf@linux-mips.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Return-Path: <jolsa@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46834
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jolsa@redhat.com
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

On Wed, Apr 08, 2015 at 01:58:46AM +0200, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> Hack up the Makefile and add support code for mips unwinding
> and dwarf-regs.

hi,
we changed our build system just recently and this patch
is made over the old one.. comments below

> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> Cc: linux-mips@linux-mips.org
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
> Patchwork: https://patchwork.linux-mips.org/patch/5249/
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> ---
>  tools/perf/Makefile                      |  3 ++
>  tools/perf/arch/mips/Makefile            |  7 +++
>  tools/perf/arch/mips/include/perf_regs.h | 84 ++++++++++++++++++++++++++++++++
>  tools/perf/arch/mips/util/dwarf-regs.c   | 37 ++++++++++++++
>  tools/perf/arch/mips/util/unwind.c       | 20 ++++++++
>  5 files changed, 151 insertions(+)
>  create mode 100644 tools/perf/arch/mips/Makefile
>  create mode 100644 tools/perf/arch/mips/include/perf_regs.h
>  create mode 100644 tools/perf/arch/mips/util/dwarf-regs.c
>  create mode 100644 tools/perf/arch/mips/util/unwind.c
> 
> diff --git a/tools/perf/Makefile b/tools/perf/Makefile
> index cb2e586..c2a089a 100644
> --- a/tools/perf/Makefile
> +++ b/tools/perf/Makefile
> @@ -28,6 +28,9 @@ ifeq ($(JOBS),)
>    ifeq ($(JOBS),)
>      JOBS := 1
>    endif
> +  ifeq ($(ARCH),mips)
> +    LIB_H += arch/mips/include/perf_regs.h
> +  endif
>  endif

LIB_H is no longer supported, the build now detects
all headers automatically


>  
>  #
> diff --git a/tools/perf/arch/mips/Makefile b/tools/perf/arch/mips/Makefile
> new file mode 100644
> index 0000000..fe9b61e
> --- /dev/null
> +++ b/tools/perf/arch/mips/Makefile
> @@ -0,0 +1,7 @@
> +ifndef NO_DWARF
> +PERF_HAVE_DWARF_REGS := 1
> +LIB_OBJS += $(OUTPUT)arch/$(ARCH)/util/dwarf-regs.o
> +endif
> +ifndef NO_LIBUNWIND
> +LIB_OBJS += $(OUTPUT)arch/$(ARCH)/util/unwind.o
> +endif

the tools/perf/arch/mips/Makefile now provides make arch's
dependent variables setup, so your's should be:

---
ifndef NO_DWARF
PERF_HAVE_DWARF_REGS := 1
endif
---

from building side mips seems similar to arch/powerpc/ setup:

---
[jolsa@krava perf]$ cat arch/powerpc/Build 
libperf-y += util/
[jolsa@krava perf]$ cat arch/powerpc/util/Build 
libperf-y += header.o

libperf-$(CONFIG_DWARF) += dwarf-regs.o
libperf-$(CONFIG_DWARF) += skip-callchain-idx.o
---

so arch/mips/Build should be identical to arch/powerpc/Build
and arch/mips/util/Build should look like:

---
libperf-$(CONFIG_DWARF)     += dwarf-regs.o
libperf-$(CONFIG_LIBUNWIND) += unwind.o
---

could you please also rename 'unwind.c' to 'unwind-libunwind.c',
cause we have also libdw unwind and we try to keep them separated

thanks,
jirka
