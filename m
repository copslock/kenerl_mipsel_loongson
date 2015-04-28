Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Apr 2015 09:20:57 +0200 (CEST)
Received: from smtp-out-223.synserver.de ([212.40.185.223]:1129 "EHLO
        smtp-out-223.synserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011873AbbD1HUzu1N0r (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Apr 2015 09:20:55 +0200
Received: (qmail 29651 invoked by uid 0); 28 Apr 2015 07:20:57 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@metafoo.de
X-SynServer-PPID: 29568
Received: from p4fde67af.dip0.t-ipconnect.de (HELO ?192.168.2.103?) [79.222.103.175]
  by 217.119.54.73 with AES128-SHA encrypted SMTP; 28 Apr 2015 07:20:56 -0000
Message-ID: <553F34DA.20400@metafoo.de>
Date:   Tue, 28 Apr 2015 09:20:58 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
MIME-Version: 1.0
To:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH v4 14/37] MIPS: JZ4740: drop intc debugfs code
References: <1429881457-16016-1-git-send-email-paul.burton@imgtec.com> <1429881457-16016-15-git-send-email-paul.burton@imgtec.com>
In-Reply-To: <1429881457-16016-15-git-send-email-paul.burton@imgtec.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47115
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
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

On 04/24/2015 03:17 PM, Paul Burton wrote:
> The debugfs code becomes a nuisance when attempting to avoid globals,
> since the interrupt controller probe function run too early for it to be
> safe to create the debugfs files. Drop it.
>
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> ---
> I recognise this one may be controversial. Please shout if you care
> about this debugfs code!

It's ok, it was useful during initial development of the driver, but I doubt 
anybody ever look at the debugfs files after it.

Acked-by: Lars-Peter Clausen <lars@metafoo.de>
