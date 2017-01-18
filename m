Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jan 2017 19:53:21 +0100 (CET)
Received: from mout.web.de ([212.227.17.12]:50000 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992221AbdARSxOhQtf- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 18 Jan 2017 19:53:14 +0100
Received: from [192.168.1.2] ([78.48.198.118]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Mf0cv-1c5UcF06wr-00OW54; Wed, 18
 Jan 2017 19:52:58 +0100
To:     linux-mips@linux-mips.org,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        =?UTF-8?Q?Ralf_B=c3=a4chle?= <ralf@linux-mips.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
From:   SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/3] MIPS: Fine-tuning for three function implementations
Message-ID: <bb402413-83e5-9b34-304c-9f4bca6037d9@users.sourceforge.net>
Date:   Wed, 18 Jan 2017 19:52:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:Za4yujI/L49lIWKAWOuMP5XishYT9puE4Yg/uCdkGMrz9+/R8B/
 RbmI7Egl5tAayBKL4GqQeVtIHnwkxekD25bjzMyUi8SlG3kKXnOMvI+MjlvhbqZ5JvmiGhG
 w07YENGr4sX5xszzkxiMdNrgb6CJGBMYMakv9RIjLSFApWujGd4b7pFTAK4WNrHcyM5vlR+
 KXpl5/j3cPzmyCHByub+A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ORVPF4kKI88=:wB8vu1S5BAzsrlGKsy9xhD
 TMlg6iwzyNyj2BUHSCo8xgAlbXdX9LgVcrE4rZXpzcTQGnl/ABoW5cxBEk6TYNwwEshpNetSG
 aT/5gYSzOlyQu1MoyNfu42hRoRjjFn28A+MqVQ4ebSfwvj+t5bvRJQl7nXod8AqKNg+RwJ1yu
 AFWmuxs7h08DRD+iQXUB1dXXMOaqvKEgWnucld5Fx2ww2c9vp1qODEjOG6CNTbKJLoY+qK30M
 wEE5uKoAGQeWuFm9zAzlOiMUYMkMENIATWc6ylN9bP85ONnOM7RRGoKuaXQQGNZcLTPe0Oeh/
 SGAcnTkCsH4Nng6LlZ2kb7Mq+CJ17kqTp3irYvLLE0hoL99rJ+1IVNl+Idp/FJSf0mtBFDaZc
 k4D/6ii2kEIpWSFFtizM5CXKrJS2YiihRh7qhorlCpeim02ZZyAaPH+CpIpv6JE+NY0Gxs1Qe
 LG/tiD4G5uC8EhnvP1197nz7UYE6D3QXVKVzrJ4vxo4L4KpfiYalh7a1rU9GsGX2blWjuW9TV
 Lt5eVFRYCDVoAVzYwiqrIHnYkAEktMCitI5IbGLHMmV+luZc+BtyuHgMJHG/4VC/NS5CddejU
 HdMiM+w7OcwU9rN6Qocmg8iIQv/66EH8sMf0OyAIkrCcTLWvU80KwMZ3BZuJGwhBQkfr2aeGZ
 be5n9Hn7esVsHp64j2A9FEO5ZhGB6W7TqZRG2sjipyPCCYx5SbVHkl+VyjgI85vASac4TN1/d
 6yk2WDUbf+Em1SZFsfR5zsJmG0ODnEimtiVN4hB9L+Uro3NEQCdprNztuQrpSrcMmHe1HpBte
 GP/uyfT
Return-Path: <elfring@users.sourceforge.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56398
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

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 18 Jan 2017 19:43:34 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  Return directly in 32_mmap2()
  Move an assignment for the variable "retval" in mipsmt_sys_sched_setaffinity()
  Return directly in mips_mmap()

 arch/mips/kernel/linux32.c       | 11 +++--------
 arch/mips/kernel/mips-mt-fpaff.c |  5 +++--
 arch/mips/kernel/syscall.c       | 11 ++---------
 3 files changed, 8 insertions(+), 19 deletions(-)

-- 
2.11.0
