Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Sep 2016 17:28:41 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.126.130]:51666 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992127AbcILP2ebLiTG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Sep 2016 17:28:34 +0200
Received: from wuerfel.localnet ([78.43.20.153]) by mrelayeu.kundenserver.de
 (mreue002) with ESMTPSA (Nemesis) id 0M8WB9-1annrp22Bn-00wCNC; Mon, 12 Sep
 2016 17:20:22 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     kbuild test robot <lkp@intel.com>
Cc:     Baoyou Xie <baoyou.xie@linaro.org>, kbuild-all@01.org,
        ralf@linux-mips.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, akpm@linux-foundation.org,
        paul.burton@imgtec.com, chenhc@lemote.com, david.daney@cavium.com,
        kumba@gentoo.org, yamada.masahiro@socionext.com,
        kirill.shutemov@linux.intel.com, dave.hansen@linux.intel.com,
        toshi.kani@hpe.com, JBeulich@suse.com, dan.j.williams@intel.com,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, xie.baoyou@zte.com.cn
Subject: Re: [PATCH] mm: move phys_mem_access_prot_allowed() declaration to pgtable.h
Date:   Mon, 12 Sep 2016 17:20:12 +0200
Message-ID: <2215618.aZj7FWYi6Z@wuerfel>
User-Agent: KMail/5.1.3 (Linux/4.4.0-34-generic; KDE/5.18.0; x86_64; ; )
In-Reply-To: <201609122309.XmaxEnpl%fengguang.wu@intel.com>
References: <201609122309.XmaxEnpl%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K0:kAlG144xvEHhcjGabnmZh2ji43fG3yMXSIInbQ7JojVTsoYaacU
 xuaC18vQm0Iir6rgKA6Bwq6IcidlQfusaKn8zcQnamjuokcOhL6xeWdW76YghSYaqg+Omuo
 RS9qrWhbg+yHuOHSwSZIC2bvvO4v07kFRYgWhh8U4G2YPTAzojtufGLBpN5/BVF0eiBEYNP
 1c82xcLTZ5g0g7MSDZlHg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KAQVw1ir2B4=:1j4ESsbzqQwwy47pDZWuPU
 XVpSxNGLiY0s7+hABDISu0TLkWIxSAiLwXg18TnxJx1L9Qs29/PcaTx2ZmZBsqMHnCkDZp3nh
 n+vYLk0sXSivdDlSK/F39szKrnqgsuDLrQd9QD8fD4MH1sj+pXOfc0amE0/cH2fRLLgTWfPCP
 CyjY5OgdITurUcEk8J7r5Lp1ocxPJCz36V2aZiCPkgWUZz+0NTcx61T8iV3WnGcuA/3Z6/0ku
 QtLxZQHxL/dxc5a+ieu/fX6k3uzsv5kicEc3qJVmXbIn7spqvsVFsUcfQNhaX75oLgkE/f1lP
 +JNO7f/tV1Mvc88xieVnl+0soTd1JF1eXZGPhO1Rk4UJFcg/4BlfZxf1jeZEyGFBjr9eWAQID
 ed34YCuu8UDvOx06WYf9oPT1VDME3XPack2kfbLAjp5ETo/+5CgHEwufOrMIPmtXAQdP16L7P
 nirZWOpFoWatSzSA+tfw8Dyv7RrhHRjrDcG2KhitsAKDk8oJ4BNaPbRMGDuTDF+zl/oZtPmrS
 BC1aDYN1VGnL8V3dRWbuiyDqh7NKtSz1YZpFTS+8/LqtvzpSvHlmw93sdKGJBE40IL6JAIrrK
 oR3dmV2aSW/ZjY3VdgxlNO09EJeepuzSHZirsy0dIy5o9MuuH2wpNqTZqjE0RoL5mNUN3aD5c
 r72tP+eIMIvyC693qzZ04RdwowwKnMH2O/Mlvr/00gWscykVecOKHx08G7KAV29GRKYKnqTk0
 ej0dCFsajoUJEuUN
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55105
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Monday, September 12, 2016 11:13:45 PM CEST kbuild test robot wrote:
>    816  
>  > 817  struct file;
>  > 818  int phys_mem_access_prot_allowed(struct file *file, unsigned long pfn,
>  > 819                          unsigned long size, pgprot_t *vma_prot);
>    820  #endif /* _ASM_GENERIC_PGTABLE_H */

This should be inside of the #ifdef __ASSEMBLY__

	Arnd
