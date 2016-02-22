Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Feb 2016 13:43:33 +0100 (CET)
Received: from demumfd002.nsn-inter.net ([93.183.12.31]:57029 "EHLO
        demumfd002.nsn-inter.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007591AbcBVMncdEzJY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Feb 2016 13:43:32 +0100
Received: from demuprx016.emea.nsn-intra.net ([10.150.129.55])
        by demumfd002.nsn-inter.net (8.15.2/8.15.2) with ESMTPS id u1MChPiA027460
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Mon, 22 Feb 2016 12:43:25 GMT
Received: from ak-desktop.emea.nsn-net.net ([10.144.36.118])
        by demuprx016.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with SMTP id u1MChMh8011499;
        Mon, 22 Feb 2016 13:43:22 +0100
Received: by ak-desktop.emea.nsn-net.net (sSMTP sendmail emulation); Mon, 22 Feb 2016 14:43:03 +0200
Date:   Mon, 22 Feb 2016 14:43:03 +0200
From:   Aaro Koskinen <aaro.koskinen@nokia.com>
To:     Yang Shi <yang.shi@windriver.com>, david.daney@cavium.com
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: 4.5-rc4 kernel is failed to bootup on CN6880
Message-ID: <20160222124303.GR22974@ak-desktop.emea.nsn-net.net>
References: <56C7BD89.2040800@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56C7BD89.2040800@windriver.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-size: 1334
X-purgate-ID: 151667::1456145005-00004E94-CE82AB39/0/0
Return-Path: <aaro.koskinen@nokia.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52154
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@nokia.com
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

Hi,

On Fri, Feb 19, 2016 at 05:12:41PM -0800, Yang Shi wrote:
> I tried to boot 4.5-rc4 kernel on my CN6880 board, but it is failed at
> booting up secondary cores. The error is:

With v4.5-rc5, EBB6800 is booting fine:

[    0.000000] CPU0 revision is: 000d9108 (Cavium Octeon II)
[...]
[ 2286.273935] SMP: Booting CPU01 (CoreId  1)...
[ 2286.278201] CPU1 revision is: 000d9108 (Cavium Octeon II)
[...]
[ 2287.214953] SMP: Booting CPU31 (CoreId 31)...
[ 2287.224668] CPU31 revision is: 000d9108 (Cavium Octeon II)
[ 2287.224865] Brought up 32 CPUs

> CPU31 revision is: 000d9101 (Cavium Octeon II)
> SMP: Booting CPU32 (CoreId 32)...
> Secondary boot timeout
> 
> I passed "numcores=32" in kernel commandline since there are 32 cores ion
> CN6880.

You shouldn't have CPU32 in that case, the numbering starts from zero.
Also the coremask is 32-bit.

I can reproduce your issue with CONFIG_NR_CPUS=64. Possibly this code
is incorrect for NR_CPUS bigger than 32:

        /* The present CPUs get the lowest CPU numbers. */
        cpus = 1;
        for (id = 0; id < NR_CPUS; id++) {
                if ((id != coreid) && (core_mask & (1 << id))) {
                        set_cpu_possible(cpus, true);
                        set_cpu_present(cpus, true);

What CONFIG_NR_CPUS did you use?

A.
