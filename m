Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Sep 2015 16:42:36 +0200 (CEST)
Received: from demumfd002.nsn-inter.net ([93.183.12.31]:60322 "EHLO
        demumfd002.nsn-inter.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007864AbbIOOmfMI5jH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 Sep 2015 16:42:35 +0200
Received: from demuprx016.emea.nsn-intra.net ([10.150.129.55])
        by demumfd002.nsn-inter.net (8.15.2/8.15.2) with ESMTPS id t8FEgJZV000310
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Tue, 15 Sep 2015 14:42:20 GMT
Received: from ak-desktop.emea.nsn-net.net ([10.144.35.206])
        by demuprx016.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with SMTP id t8FEgGfT000594;
        Tue, 15 Sep 2015 16:42:17 +0200
Received: by ak-desktop.emea.nsn-net.net (sSMTP sendmail emulation); Tue, 15 Sep 2015 17:38:51 +0300
Date:   Tue, 15 Sep 2015 17:38:50 +0300
From:   Aaro Koskinen <aaro.koskinen@nokia.com>
To:     Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org
Subject: [BISECTED] Linux 4.3-rc1 boot regression on OCTEON
Message-ID: <20150915143850.GO1199@ak-desktop.emea.nsn-net.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-size: 3061
X-purgate-ID: 151667::1442328141-0000538C-4837EEF2/0/0
Return-Path: <aaro.koskinen@nokia.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49203
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

OCTEON+/OCTEON II fails to boot with 4.3-rc1. Bisected to:

1a3d59579b9f436da038f377309cf2270c76318e is the first bad commit
commit 1a3d59579b9f436da038f377309cf2270c76318e
Author: Paul Burton <paul.burton@imgtec.com>
Date:   Mon Aug 3 08:49:30 2015 -0700

    MIPS: Tidy up FPU context switching

The crash log is below.

[  202.529364] do_cpu invoked from kernel context![#1]:
[  202.534158] CPU: 0 PID: 2 Comm: kthreadd Not tainted 4.3.0-rc1-octeon-distro.git-v1.12-27-gac8875b-00512-ge0f5188 #1
[  202.544658] task: 8000000033130e00 ti: 800000003313c000 task.ti: 800000003313c000
[  202.552121] $ 0   : 0000000000000000 ffffffff811825fc 0000000000100000 ffffffffbfffffff
[  202.560106] $ 4   : 8000000033130e00 8000000033130000 800000003312c000 0000000000000004
[  202.568092] $ 8   : 0000000000000000 0000000000000001 0000000000000000 0000000000000001
[  202.576077] $12   : 0000000010108ce3 0000000002119c60 0000000000000000 800000003313c000
[  202.584063] $16   : 8000000033130000 ffffffff8179cc80 8000000002f6fd00 8000000033130e00
[  202.592049] $20   : 0000000000000000 8000000033131328 0000000000000000 0000000000000000
[  202.600034] $24   : 0000000000000004 ffffffff8117f9a8                                  
[  202.608020] $28   : 800000003313c000 800000003313fd90 ffffffff817cc630 ffffffff816136c0
[  202.616006] Hi    : 0000000000fa8257
[  202.619565] Lo    : ffffffffe15cfc00
[  202.623128] epc   : ffffffff8112bc9c resume+0x9c/0x200
[  202.628250] ra    : ffffffff816136c0 __schedule+0x470/0xaa0
[  202.633799] Status: 10108ce2	KX SX UX KERNEL EXL 
[  202.638487] Cause : 1080002c (ExcCode 0b)
[  202.642480] PrId  : 000d9108 (Cavium Octeon II)
[  202.646993] Modules linked in:
[  202.650033] Process kthreadd (pid: 2, threadinfo=800000003313c000, task=8000000033130e00, tls=0000000000000000)
[  202.660100] Stack : 0000000000000001 ffffffff81617a34 8000000033130e00 ffffffff811736ac
	  0000000000000001 ffffffff81eb98f8 0000000000000000 ffffffff817b0000
	  ffffffff817b6390 ffffffff811694d0 0000000000000001 0000000000000000
	  0000000000000000 ffffffff81613da4 8000000033130e00 ffffffff8116a070
	  ffffffff81169ee0 0000000000000000 0000000000000000 0000000000000000
	  0000000000000000 0000000000000000 0000000000000000 ffffffff81120a4c
	  0000000000000000 0000000000000000 0000000000000000 0000000000000000
	  0000000000000000 0000000000000000 0000000000000000 0000000000000000
	  0000000000000000 0000000000000000 0000000000000000 0000000000000000
	  0000000000000000 0000000000000000 0000000000000000 0000000000000000
	  ...
[  202.725026] Call Trace:
[  202.727459] [<ffffffff8112bc9c>] resume+0x9c/0x200
[  202.732234] [<ffffffff816136c0>] __schedule+0x470/0xaa0
[  202.737441] [<ffffffff81613da4>] schedule+0x4c/0xc8
[  202.742303] [<ffffffff8116a070>] kthreadd+0x190/0x1b0
[  202.747338] [<ffffffff81120a4c>] ret_from_kernel_thread+0x14/0x1c
[  202.753411] 
[  202.754885] 
Code: f49b09b8  f49d09c8  f49f09d8 <444df800> f48008e0  f48208f0  f4840900  f4860910  f4880920 

A.
