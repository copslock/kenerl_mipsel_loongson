Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Feb 2015 21:12:12 +0100 (CET)
Received: from terminus.zytor.com ([198.137.202.10]:36509 "EHLO mail.zytor.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012783AbbBFUMKjR5vI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 6 Feb 2015 21:12:10 +0100
Received: from anacreon.sc.intel.com (fmdmzpr03-ext.fm.intel.com [192.55.54.38])
        (authenticated bits=0)
        by mail.zytor.com (8.14.8/8.14.5) with ESMTP id t16KBp8a015597
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Fri, 6 Feb 2015 12:11:51 -0800
Message-ID: <54D52000.40508@zytor.com>
Date:   Fri, 06 Feb 2015 12:11:44 -0800
From:   "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>
CC:     "Dmitry V. Levin" <ldv@altlinux.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Will Drewry <wad@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@plumgrid.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>
Subject: Re: [PATCH v5 3/5] x86: Split syscall_trace_enter into two phases
References: <cover.1409954077.git.luto@amacapital.net>  <2df320a600020fda055fccf2b668145729dd0c04.1409954077.git.luto@amacapital.net>   <20150205211916.GA31367@altlinux.org>   <CAGXu5j+aXxt55LsxxbNkfGGF719ubXBZ2JAFwUPNARwKMVFgng@mail.gmail.com>    <20150205214027.GB31367@altlinux.org>   <CALCETrXFzcXngHsX=_72hYZqms32Zf7oFYDBgC3XNw7zOGdDCA@mail.gmail.com>    <CAGXu5jJtHT9o8WMoynifN13=uZoARt4G9iVcgZsc9xYOBEwWsg@mail.gmail.com>    <20150205233945.GA31540@altlinux.org>   <CAGXu5jLTH+mUF0JxeR2qA_r=ocWjPHPSK2OPgE0Fu_JKoQyQ9w@mail.gmail.com>    <CALCETrXsCUje+_V=Ud+TB4A2jH2M7yqyoCFMLEyxOD6pd7Di5w@mail.gmail.com>    <20150206023249.GB31540@altlinux.org>   <CALCETrWTnqKDoatK+5FN=yYDOeENoW5=r5YMToYKhZ8Zfv5wWA@mail.gmail.com> <CAGXu5j+nopAMFukwMu=Cy0GOapziOLTb-ryJhA-aywk_uerg9A@mail.gmail.com>
In-Reply-To: <CAGXu5j+nopAMFukwMu=Cy0GOapziOLTb-ryJhA-aywk_uerg9A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <hpa@zytor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45756
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hpa@zytor.com
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

On 02/06/2015 11:23 AM, Kees Cook wrote:
> 
> Strictly speaking (ISO C, "man 3 errno"), errno is supposed to be a
> full int, though digging around I find this in include/linux/err.h:
> 

That doesn't mean the kernel has to support them.

> /*
>  * Kernel pointers have redundant information, so we can use a
>  * scheme where we can return either an error code or a normal
>  * pointer with the same return value.
>  *
>  * This should be a per-architecture thing, to allow different
>  * error and pointer decisions.
>  */
> #define MAX_ERRNO       4095
> 
> #ifndef __ASSEMBLY__
> 
> #define IS_ERR_VALUE(x) unlikely((x) >= (unsigned long)-MAX_ERRNO)
> 
> But no architecture overrides this.
> 

We used to have a much lower value, that was per-architecture, in order
to optimize the resulting assembly (e.g. 8-bit immediates on x86).  This
didn't work as the number of errnos increased.  The other motivation was
probably binary compatibility with other Unices, which was an idea for a
while.

	-hpa
