Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Jun 2010 18:54:41 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:11969 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491172Ab0FIQyf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Jun 2010 18:54:35 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c0fc75b0000>; Wed, 09 Jun 2010 09:54:51 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 9 Jun 2010 09:54:30 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 9 Jun 2010 09:54:30 -0700
Message-ID: <4C0FC741.4020505@caviumnetworks.com>
Date:   Wed, 09 Jun 2010 09:54:25 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100430 Fedora/3.0.4-2.fc12 Thunderbird/3.0.4
MIME-Version: 1.0
To:     Christoph Egger <siccegge@cs.fau.de>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Yang Shi <yang.shi@windriver.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Tejun Heo <tj@kernel.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, vamos@i4.informatik.uni-erlangen.de
Subject: Re: [PATCH 2/9] Removing dead CONFIG_GDB_CONSOLE
References: <cover.1275925108.git.siccegge@cs.fau.de> <598418d662edd83225b8b47ead59a5cf18a26fc6.1275925108.git.siccegge@cs.fau.de>
In-Reply-To: <598418d662edd83225b8b47ead59a5cf18a26fc6.1275925108.git.siccegge@cs.fau.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Jun 2010 16:54:30.0697 (UTC) FILETIME=[6DDF8190:01CB07F4]
X-archive-position: 27112
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 6585

On 06/09/2010 04:20 AM, Christoph Egger wrote:
> CONFIG_GDB_CONSOLE doesn't exist in Kconfig, therefore removing all
> references for it from the source code.
>
> Signed-off-by: Christoph Egger<siccegge@cs.fau.de>

Acked-by: David Daney <ddaney@caviumnetworks.com>

> ---
>   arch/mips/cavium-octeon/serial.c    |    4 ----
>   arch/mips/cavium-octeon/setup.c     |    4 ----
>   arch/mips/pmc-sierra/yosemite/irq.c |    4 ----
>   3 files changed, 0 insertions(+), 12 deletions(-)
>
