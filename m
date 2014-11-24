Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Nov 2014 00:55:47 +0100 (CET)
Received: from mail-pd0-f173.google.com ([209.85.192.173]:55402 "EHLO
        mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006785AbaKXXzqlOEug (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Nov 2014 00:55:46 +0100
Received: by mail-pd0-f173.google.com with SMTP id ft15so10743206pdb.32
        for <linux-mips@linux-mips.org>; Mon, 24 Nov 2014 15:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=DBU64whKfeW+Oc201oO6q/EMm5ueCMwJyB8yrIVhV3Q=;
        b=Q7yheozjqfOdawGVdgK55SI6YhjJvOkrI0rU1Bwt65B77+CdEn6FzwU5gj3kzQZkZe
         TxQzp4Z428dOv9qxjHbzV7yft9tOz2y7a2ftyiqLyTvdBcf7Lhkyei8pQnynL3CDOwJZ
         tBQw/dVNegZsThKxUF1abza9rums2bYiNwD7aJfG77iR6iujh6GRJ3SyhTL6u/ibW/lA
         9+c3Z8J6Y3G/tIqRW3hEpv18jgQtHl4gLUW3luJTh2TooquSjJudaUF/ZnZYyM5UvAdv
         oc/QVpPKQf46rrLwP9QF6Qfz0gpq+dvmqAu7zfGGbI6aF8gTZtUsV0PDkjy8udz9BXGn
         2w7A==
X-Received: by 10.67.12.236 with SMTP id et12mr38525761pad.31.1416873340832;
        Mon, 24 Nov 2014 15:55:40 -0800 (PST)
Received: from [10.12.164.252] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by mx.google.com with ESMTPSA id xg4sm6806825pab.8.2014.11.24.15.55.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Nov 2014 15:55:40 -0800 (PST)
Message-ID: <5473C56D.1050308@gmail.com>
Date:   Mon, 24 Nov 2014 15:55:25 -0800
From:   Florian Fainelli <f.fainelli@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Kevin Cernekee <cernekee@gmail.com>, gregkh@linuxfoundation.org,
        jslaby@suse.cz, robh@kernel.org, grant.likely@linaro.org
CC:     arnd@arndb.de, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH V3 0/7] serial: Configure {big,native}-endian MMIO accesses
 via DT
References: <1416872182-6440-1-git-send-email-cernekee@gmail.com>
In-Reply-To: <1416872182-6440-1-git-send-email-cernekee@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44420
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

On 11/24/2014 03:36 PM, Kevin Cernekee wrote:
> My last submission attempted to work around serial driver coexistence
> problems on multiplatform kernels.  Since there are still questions
> surrounding the best way to solve that problem, this patch series
> will focus on the narrower topic of big endian MMIO support on serial.

FWIW:

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

> 
> 
> V2->V3:
> 
>  - Document the new DT properties.
> 
>  - Add libfdt-based wrapper, to complement the "struct device_node" based
>    version.
> 
>  - Restructure early_init_dt_scan_chosen_serial() changes to use a
>    temporary variable, so it is easy to add more of_setup_earlycon()
>    properties later.
> 
>  - Make of_serial and serial8250 honor the new "big-endian" property.
> 
> 
> This series applies cleanly to:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/glikely/linux.git devicetree/next-overlay
> 
> but was tested on the mips-for-linux-next branch because my BE platform
> isn't supported in mainline yet.
> 
> 
> Kevin Cernekee (7):
>   of: Add helper function to check MMIO register endianness
>   of/fdt: Add endianness helper function for early init code
>   of: Document {little,big,native}-endian bindings
>   serial: core: Add big-endian iotype
>   serial: earlycon: Set UPIO_MEM32BE based on DT properties
>   serial: of_serial: Support big-endian register accesses
>   serial: 8250: Add support for big-endian MMIO accesses
> 
>  .../devicetree/bindings/common-properties.txt      | 60 ++++++++++++++++++++++
>  drivers/of/base.c                                  | 23 +++++++++
>  drivers/of/fdt.c                                   | 26 +++++++++-
>  drivers/tty/serial/8250/8250_core.c                | 20 ++++++++
>  drivers/tty/serial/8250/8250_early.c               |  5 ++
>  drivers/tty/serial/earlycon.c                      |  4 +-
>  drivers/tty/serial/of_serial.c                     |  3 +-
>  drivers/tty/serial/serial_core.c                   |  2 +
>  include/linux/of.h                                 |  6 +++
>  include/linux/of_fdt.h                             |  2 +
>  include/linux/serial_core.h                        | 15 +++---
>  11 files changed, 155 insertions(+), 11 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/common-properties.txt
> 
