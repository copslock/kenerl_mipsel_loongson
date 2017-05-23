Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 May 2017 22:51:10 +0200 (CEST)
Received: from mout.web.de ([212.227.15.14]:49841 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994933AbdEWUvAfmwHv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 23 May 2017 22:51:00 +0200
Received: from [192.168.1.2] ([78.49.50.198]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MbyJ4-1dUOTE0cmE-00JG1K; Tue, 23
 May 2017 22:50:26 +0200
To:     linux-mips@linux-mips.org, Ingo Molnar <mingo@kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Kees Cook <keescook@chromium.org>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        =?UTF-8?Q?Ralf_B=c3=a4chle?= <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>
From:   SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/5] MIPS-kernel: Adjustments for some function
 implementations
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Message-ID: <e866716c-5ce4-3658-f944-e310007db127@users.sourceforge.net>
Date:   Tue, 23 May 2017 22:50:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:kGk7S/cwV0GfvU05VdiM/Mvn/J9Lgp6R3+XbdcEfK362YdOoU+m
 zVv/YPJSQH6lQQn1l7b8BfSBl1iyo72OnUvJ5YdHjjQpWe2VSiZ+YcR/gl3pXRBhwkwEXzN
 daC5gb+Evv6oxL9iqUon3sv3ZhY3xOqnS4UVr2zHwpn3qvgSIqByNUDF9GAi5DTRnV78ftq
 lZl+MUZFf0+SzPevr/BoQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9XYTPDoKlRU=:gvYoOky/gXv/4n9r2njnxe
 dncz5dWa+3UUEwXPAas1TW+7C5XW3IewdC3yT94J54IbM1M8owJ5ivsbeqsT7HLe34TAL/hJ7
 9s73GLBWgwm/MLLBQCUNk8mKatDjw2dHT6+Ss0fM/0h5YCW42BTQSlUbsWjlbGGZpcs9Y//MF
 s+wxeTBUh5ESJfSZnez5/eq8Qax4qx328J8TPK8fcpY5akiWXbVc0BgpzZ3wfVM3S/3/ld/yh
 XIJPglhftuxiu+m+2fCV+FfANmLvdzO5LyR4An0IVs9LqLeSyDKQroNZp0d0cS5jyg7o63SKr
 oI7qIdsb/IZ/MxwnqUxWE038g5920dmpJST40V4/Riwq9GK2tjQ0+bJCg2E5niiu881UQmCGQ
 dmEfn8qKnvxM10un+oiHuceHbqhQzk2m2MAjVPSU359vnU9HFEdH7KHR4WWW7x83m3MLLUT2m
 pCmuzzRTbFp+5ugRen53YVEDaXXlYqyO2TBvkZCY2fty/eHJ5cV/451D8bFOA8F+3HmvSBkvK
 lnwbLzb0WFQi3AJde7A1O7lpDoa0JkOJBAqpCikF2yc66bh2wfYK7+svuBtJu5S0W94g2f18j
 95MNx9WQYsT+sLabJPRlAoAoJ3uufvwAD2ZKPArso8Qyt8BsmZCy75EcnyKQt72bCHM7LyUTd
 01REc+E+ATGcvI8gMU+JLoI0+woRlCpEHFs8ODLRA/XwE+kNOz8xRw7WeFq+RfCOHDX3Nc9YL
 RUiCM+7K3LVjMiIIs4EG8BIqX07pVMnIrioG3rZDKHb1dZCkh2CQoy0OrNF2lilFPns/k9LMF
 adXvpYs
Return-Path: <elfring@users.sourceforge.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57958
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
Date: Tue, 23 May 2017 22:40:04 +0200

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (5):
  Delete an error message for a failed memory allocation in cps_pm_online_cpu()
  Delete error messages for failed memory allocations in cps_prepare_cpus()
  Delete an error message for a failed memory allocation in vpe_open()
  Improve a size determination in two functions
  Adjust 13 checks for null pointers

 arch/mips/kernel/pm-cps.c  |  5 ++---
 arch/mips/kernel/smp-cps.c |  9 ++-------
 arch/mips/kernel/vpe.c     | 37 +++++++++++++++++--------------------
 3 files changed, 21 insertions(+), 30 deletions(-)

-- 
2.13.0
