Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 May 2017 22:52:04 +0200 (CEST)
Received: from mout.web.de ([212.227.15.4]:55949 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994955AbdEWUvvvo98v (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 23 May 2017 22:51:51 +0200
Received: from [192.168.1.2] ([78.49.50.198]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LiUZg-1dnRT61QTc-00cikT; Tue, 23
 May 2017 22:51:24 +0200
Subject: [PATCH 1/5] MIPS: pm-cps: Delete an error message for a failed memory
 allocation in cps_pm_online_cpu()
From:   SF Markus Elfring <elfring@users.sourceforge.net>
To:     linux-mips@linux-mips.org, Ingo Molnar <mingo@kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Kees Cook <keescook@chromium.org>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        =?UTF-8?Q?Ralf_B=c3=a4chle?= <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <e866716c-5ce4-3658-f944-e310007db127@users.sourceforge.net>
Message-ID: <b4a16560-9557-8d4c-d46c-2dd658bfa036@users.sourceforge.net>
Date:   Tue, 23 May 2017 22:51:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <e866716c-5ce4-3658-f944-e310007db127@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:NxvQdOciUccGbTMk0M4Ci6QXVsM3XCZGDSFLdrE61OAfLhqrH3G
 JMwC5ifDknCqt5N7YeTVMAM7r+GrtS+Y/qEUhie3WRUFVfxX+MxdnKFfZi9VSWJBm6+TZHj
 bfMx2JVSYf0a0/kxiA7hpkPYRDsHAkQoiqAc8KxuYGIu+/gh2RQxgekNaMe/PrAaqaBFCpK
 QHEfucvmh4469YDhlsBKw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3ir5zC//T2M=:krHFA5dn7NxvwPSzx/v9U+
 Dnlul1F01EwfgYQviyQ/SvmVgGPJcTCZeKeeNsGvM1tpquOe2Cv+PQdcNo7cR5YitMM/vPSIi
 FB8dcTooHgvvR0AFCdLGBPFQQVV8/QuWbKrTc+/IosJ0/QPk8rKtYt/6UsBERetlJjhNKbafd
 IPqjDpJ3cYQTeInxGiXeaqNhA7QsRWQHeYa1vhOEGYCGqKpCmFnMRHoL7BvwDPH2CDFkNcEnK
 NaBE6/LRWUFuaBlFOmMh3rf9zcqdD4A+QDOl6fSRrdFcXYDn5LylUcvnOwbPw+2CzPygmudpb
 Ff5XY1TGdGIIYwQeA34sy7pNp4DFp+62jzNyyLbac1QveI5QJ1Tn8S3kNMuiX62M/p0wGbHK0
 Zo4ywKwnsvsOl2NrINFvHYLhHBHQaIRv8DW1ql5uIudpAMRreG/ZazIapXTa8clnGlJDn9O6A
 M0orclKE36dLbQf2eOzmzzBY9Bw5XL53+SeHD9idQzalGIWMR815XkU7cweOODVtRn2lUkMKb
 Sx+gLkLYH5ixzd55YSzvsKKSAElYaseYKHClgxiTwghqU99J0fY9iMwMXWs6L6uVO6UZ0qBKR
 K88vpqP6dxgTQkEudjO5XQg4SxHdHlqciU9OA+htkPqmbIpuWiagRbs2ScjF3KvU6zSFdEddz
 K8AXqXmFpmWwGtMqnBc6UYu3cEk4k8v7+bbaNG/lC/HJrekypTNNCQ0zEbYg4T3IQWYi87vjp
 GY5BITvWsZPsawWRYzD/hxolkpYX5QP9I/3UhjpTKEl8SFVejI+wx7xUpfVQpj4rKldvlUCgx
 tk4LLXJ
Return-Path: <elfring@users.sourceforge.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57959
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: elfring@users.sourceforge.net
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

