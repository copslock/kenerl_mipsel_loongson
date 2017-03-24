Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Mar 2017 15:33:02 +0100 (CET)
Received: (from localhost user: 'ralf' uid#1000 fake: STDIN
        (ralf@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23992028AbdCXOcyZ4Fgu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 24 Mar 2017 15:32:54 +0100
Date:   Fri, 24 Mar 2017 15:32:52 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "kernelci.org bot" <bot@kernelci.org>,
        kernel-build-reports@lists.linaro.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-crypto@vger.kernel.org, linux-mips@linux-mips.org,
        "Steven J. Hill" <steven.hill@cavium.com>
Subject: Re: next build: 208 builds: 9 failed, 199 passed, 857 errors, 444
 warnings (next-20170323)
Message-ID: <20170324143252.GA1520@linux-mips.org>
References: <58d36150.82ce190a.a6597.51eb@mx.google.com>
 <CAK8P3a0OHuqV-iK0T3BaYnsNgT2RDpAgpa5vQEFneEZZ65Dn9g@mail.gmail.com>
 <20170323184450.GB13254@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170323184450.GB13254@linux-mips.org>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57433
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

On Thu, Mar 23, 2017 at 07:44:50PM +0100, Ralf Baechle wrote:

> > On Thu, Mar 23, 2017 at 6:46 AM, kernelci.org bot <bot@kernelci.org> wrote:
> > 
> > > acs5k_defconfig (arm) — PASS, 0 errors, 2 warnings, 0 section mismatches
> > >
> > > Warnings:
> > > :1328:2: warning: #warning syscall arch_prctl not implemented [-Wcpp]
> > > :1328:2: warning: #warning syscall arch_prctl not implemented [-Wcpp]
> > 
> > patch sent today, we don't really want this syscall except on x86
> > 
> > > allmodconfig (arm64) — FAIL, 6 errors, 5 warnings, 0 section mismatches
> > >
> > > Errors:
> > > ERROR (phandle_references): Reference to non-existent node or label "pwm_f_clk_pins"
> > > ERROR (phandle_references): Reference to non-existent node or label "pwm_ao_a_3_pins"
> > > ERROR: Input tree has errors, aborting (use -f to force output)
> > > ERROR (phandle_references): Reference to non-existent node or label "pwm_f_clk_pins"
> > > ERROR (phandle_references): Reference to non-existent node or label "pwm_ao_a_3_pins"
> > > ERROR: Input tree has errors, aborting (use -f to force output)
> > 
> > Kevin has already backed out the commit that caused this.
> > 
> > > Warnings:
> > > :1325:2: warning: #warning syscall statx not implemented [-Wcpp]
> > 
> > Should get fixed in the next few days when the patch gets picked up for arm64.
> > 
> > > drivers/misc/aspeed-lpc-ctrl.c:232:17: warning: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'resource_size_t {aka long long unsigned int}' [-Wformat=]
> > 
> > patch sent today
> > 
> > > include/uapi/linux/byteorder/big_endian.h:32:26: warning: large integer implicitly truncated to unsigned type [-Woverflow]
> > > include/uapi/linux/byteorder/big_endian.h:32:26: warning: large integer implicitly truncated to unsigned type [-Woverflow]
> > 
> > I sent this one a few days ago
> > 
> > > allmodconfig (x86) — PASS, 0 errors, 11 warnings, 0 section mismatches
> > >
> > > Warnings:
> > > drivers/crypto/cavium/zip/zip_main.c:489:18: warning: format '%ld' expects argument of type 'long int', but argument 4 has type 'long long int' [-Wformat=]
> > > drivers/crypto/cavium/zip/zip_main.c:489:18: warning: format '%ld' expects argument of type 'long int', but argument 5 has type 'long long int' [-Wformat=]
> > 
> > This one too.
> > 
> > > cavium_octeon_defconfig (mips) — FAIL, 830 errors, 3 warnings, 0 section mismatches
> > >
> > > Errors:
> > > arch/mips/include/asm/octeon/cvmx-mio-defs.h:78:3: error: expected specifier-qualifier-list before '__BITFIELD_FIELD'
> > > arch/mips/include/asm/octeon/cvmx-mio-defs.h:95:3: error: expected specifier-qualifier-list before '__BITFIELD_FIELD'
> > 
> > Maybe caused by 4cd156de2ca8 ("MIPS: Octeon: Remove unused MIO types
> > and macros.")
> > I have not looked in detail
> 
> Seems an #include <uapi/asm/bitfield.h.> is missing.  I'm going to sort
> this one.

I fixed this in my branch for linux-next only to encounter another build
error so I dropped another two patches.

  Ralf
