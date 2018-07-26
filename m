Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jul 2018 15:02:25 +0200 (CEST)
Received: from mout.gmx.net ([212.227.15.18]:46537 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990439AbeGZNCSjgr7v (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 26 Jul 2018 15:02:18 +0200
Received: from ls3530 ([155.56.40.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MTTKZ-1fbDCy051L-00SQbY; Thu, 26
 Jul 2018 14:59:51 +0200
Date:   Thu, 26 Jul 2018 14:59:40 +0200
From:   Helge Deller <deller@gmx.de>
To:     Alex Ghiti <alex@ghiti.fr>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@kernel.org>, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will.deacon@arm.com, tony.luck@intel.com,
        fenghua.yu@intel.com, ralf@linux-mips.org, paul.burton@mips.com,
        jhogan@kernel.org, jejb@parisc-linux.org, deller@gmx.de,
        benh@kernel.crashing.org, paulus@samba.org,
        ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH v4 00/11] hugetlb: Factorize hugetlb architecture
 primitives
Message-ID: <20180726125940.GA15033@ls3530>
References: <20180705110716.3919-1-alex@ghiti.fr>
 <20180709141621.GD22297@dhcp22.suse.cz>
 <2173685f-7f85-7acb-4685-2383210c5fa2@ghiti.fr>
 <87d0vehx16.fsf@concordia.ellerman.id.au>
 <67aba0f0-c0d4-b06f-5fbc-f4d113ce5033@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67aba0f0-c0d4-b06f-5fbc-f4d113ce5033@ghiti.fr>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Provags-ID: V03:K1:LJW7STv0ttsGWNRGMntZtI8g9h5WdEk1zchAg4XmzjhCReDadlR
 KG+cYi35nReER/0L3a4C+m2kngX4xI03Labu+btPyA68jH3f+GC+B4qcZQauRRzrEc80ERE
 aHGns9dZ853xNeeLFJnjGRUYdQsbCokyKXfbOydvSxnYlIPh6n3wWXsfKwCi920Up+MZU84
 4FSFjVIiKuyHgJ1Qk6Gqg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zkWr1oFCSxI=:2ucBH/SBIgeCNQ0BKUKeje
 F+9jymR6qNiTUTKtDh89IYd0+6+Bsc5f/Syop13rLKmBEhnPFN+a41RacteZnwIBnLF9+ETjJ
 3DlfTAUQSeuGdnHBeADJFltjUCSTvD2vsM58+aeCkxMNMpajnlaqA3E/deNmLotmpKsrqKmrT
 xKlckvHALi8pkKIKyDt5rE4pekx9GLBQHrEB1NEyQsX83D0pk7Fa15jDIyPGlYAUMVCVuoT17
 DJeVFQ5oHMqQh4fvuIix9e6XmiP1i+/MxLVEOA++ocfAgfIXxZeQXNYsUss7wqZLlZ95KbpB4
 nd1/9LjVBmgjK5zN4wTz2onTOFwgtJc09QXPUK1MLL2IOfESmDkYBPc0kTy3WMG7EITGFYPNq
 HixBpBdcYX9LbmNXK17ispo3ECpjyd5I/z1NjyQd8knCR5tSlGgpWo5QqwfeE9aDbbXriwJ2t
 /wsnmcXaL6hle00w1eZUquG+XYKrKxQ6+QU6lgXufdZW3cmVVZx0KiO+TJqk6T+10Ttt7D51L
 ujer+8dhR2WIpubn1MFUSxKLz1do/E1GCp6bqM8TA5hUW2sPPdTl0fBs2i/8FGaAHsQc2Puzf
 1WyUDN0KnN7FwyxWaM99MUxbH1kX70dfXAa6+p3GiEzjwd/dTVZ0boShlQ9esqyhagkmjVRiz
 z92FKnMmMwTkiykoE6mXlzBujDqmwCJ79GxbpgbZDTJVWBDagHK9DfPcW+VFFx/JUDs6tZHJa
 7LWB3ZcIw/5wqxV9V2OErrXZ/ChLYXLIWUiYsWrkJVlmrNajjZivfGblY84=
Return-Path: <deller@gmx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65154
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: deller@gmx.de
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

* Alex Ghiti <alex@ghiti.fr>:
> This is the result of the build for all arches tackled in this series
> rebased on 4.18-rc6:
> ...
> parisc:
> ������� generic-64bit_defconfig: with huge page does not link
> ������� generic-64bit_defconfig: without huge page does not link
> ������� BUT not because of this series, any feedback welcome.
Strange, but I will check that later....

Anyway, I applied your v4-patch to my parisc64 tree, built the kernel,
started it and ran some hugetlb LTP testcases sucessfully.
So, please add:

Tested-by: Helge Deller <deller@gmx.de> # parisc

Helge
