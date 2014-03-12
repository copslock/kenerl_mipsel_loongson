Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Mar 2014 00:02:28 +0100 (CET)
Received: from mail.active-venture.com ([67.228.131.205]:52611 "EHLO
        mail.active-venture.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6870548AbaCLXC0BNKbi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Mar 2014 00:02:26 +0100
Received: (qmail 91432 invoked by uid 399); 12 Mar 2014 23:02:19 -0000
Received: from unknown (HELO server.roeck-us.net) (linux@roeck-us.net@108.223.40.66)
  by mail.active-venture.com with ESMTPAM; 12 Mar 2014 23:02:19 -0000
X-Originating-IP: 108.223.40.66
X-Sender: linux@roeck-us.net
Message-ID: <5320E77A.20900@roeck-us.net>
Date:   Wed, 12 Mar 2014 16:02:18 -0700
From:   Guenter Roeck <linux@roeck-us.net>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Paul Bolle <pebolle@tiscali.nl>,
        Huacai Chen <chenhc@lemote.com>, Andreas Barth <aba@ayous.org>
Subject: Re: [PATCH RESEND 2/2] MIPS: fpu: fix conflict of register usage
References: <1394664067-17712-1-git-send-email-aaro.koskinen@iki.fi> <1394664067-17712-3-git-send-email-aaro.koskinen@iki.fi>
In-Reply-To: <1394664067-17712-3-git-send-email-aaro.koskinen@iki.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39461
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On 03/12/2014 03:41 PM, Aaro Koskinen wrote:
> From: Huacai Chen <chenhc@lemote.com>
>
> In _restore_fp_context/_restore_fp_context32, t0 is used for both
> CP0_Status and CP1_FCSR. This is a mistake and cause FP exeception on
> boot, so fix it.
>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Tested-by: Andreas Barth <aba@ayous.org>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>

With qemu-system-mips64:

Tested-by: Guenter Roeck <linux@roeck-us.net>
