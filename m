Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 May 2016 13:03:56 +0200 (CEST)
Received: from smtp2-g21.free.fr ([212.27.42.2]:41718 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27030917AbcEXLDyeO8nM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 24 May 2016 13:03:54 +0200
Received: from [172.27.0.114] (unknown [83.142.147.193])
        (Authenticated sender: slash.tmp)
        by smtp2-g21.free.fr (Postfix) with ESMTPSA id D4B172003AC;
        Tue, 24 May 2016 10:54:39 +0200 (CEST)
Subject: Re: [PATCH RESEND v4 5/9] MIPS: Loongson-1A: workaround of pll
 register's write-only property
To:     Binbin Zhou <zhoubb@lemote.com>, Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-clk@vger.kernel.org
References: <1463622432-10298-1-git-send-email-zhoubb@lemote.com>
From:   Mason <slash.tmp@free.fr>
Message-ID: <57443510.4020105@free.fr>
Date:   Tue, 24 May 2016 13:03:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:42.0) Gecko/20100101
 Firefox/42.0 SeaMonkey/2.39
MIME-Version: 1.0
In-Reply-To: <1463622432-10298-1-git-send-email-zhoubb@lemote.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <slash.tmp@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53635
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: slash.tmp@free.fr
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

On 19/05/2016 03:47, Binbin Zhou wrote:

> +#ifdef CONIFG_CPU_LOONGSON1A

As I pointed out last week, CONFIG is misspelled.

Regards.
