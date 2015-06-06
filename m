Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 06 Jun 2015 23:22:02 +0200 (CEST)
Received: from hauke-m.de ([5.39.93.123]:50976 "EHLO hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007464AbbFFVWAE5mD2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 6 Jun 2015 23:22:00 +0200
Received: from [192.168.178.24] (p5DE94F25.dip0.t-ipconnect.de [93.233.79.37])
        by hauke-m.de (Postfix) with ESMTPSA id 8BF3F20166;
        Sat,  6 Jun 2015 23:21:59 +0200 (CEST)
Message-ID: <55736477.6000009@hauke-m.de>
Date:   Sat, 06 Jun 2015 23:21:59 +0200
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
CC:     Arend van Spriel <arend@broadcom.com>,
        Hante Meuleman <meuleman@broadcom.com>
Subject: Re: [PATCH V2] MIPS: BCM47XX: Add helper variable for storing NVRAM
 length
References: <1433625383-31120-1-git-send-email-zajec5@gmail.com>
In-Reply-To: <1433625383-31120-1-git-send-email-zajec5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47895
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

On 06/06/2015 11:16 PM, Rafał Miłecki wrote:
> This simplifies code just a bit (also maybe makes it a bit more
> intuitive?) and will allow us to stop storing header. Right now we copy
> whole NVRAM including its header to the internal buffer. It is not
> needed to store a header as we don't access all these details like CRC,
> flags, etc. The next improvement that should follow is copying only the
> real contents.
> 
> Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
> ---
> V2: Extend patch description.
> ---
>  arch/mips/bcm47xx/nvram.c | 37 ++++++++++++++++---------------------
>  1 file changed, 16 insertions(+), 21 deletions(-)
> 
Acked-by: Hauke Mehrtens <hauke@hauke-m.de>
