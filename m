Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Nov 2014 16:10:52 +0100 (CET)
Received: from mail-wi0-f176.google.com ([209.85.212.176]:64613 "EHLO
        mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007011AbaKYPKspdbe9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Nov 2014 16:10:48 +0100
Received: by mail-wi0-f176.google.com with SMTP id ex7so9461489wid.3
        for <linux-mips@linux-mips.org>; Tue, 25 Nov 2014 07:10:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:subject:to:cc:in-reply-to:references
         :date:message-id;
        bh=VX2cwJLr0yBf8pJwewZBYwX+p1lipXcpxn3oC5I2/bw=;
        b=bPmLnxqyvAYn5zRY9g067CKemRWKfy5nuDHcKqAAhasfb13Q/9vfzuselh4Tg3nN/J
         TYFbBFu7QVDu+dorofcuYx7qa51Tg4C88gevghA6/mz/TUtD++cWgBiy0RCD+MIalxJ7
         xJle4VV2UvPksk0IafhKfyzliGycjstR+kRh3cP98xm66KtRKmLno4hMmQxIUV3MOICh
         +J7LfuZ3I/j5bXJPrzlwzE9Qd/1UsQ0K8WKfu3629mU+Odsw07+vpEKPkl+jQwIe4lnj
         dJycBZXHVpVwyi2A+aa/Ug3r4Z+NATABS7TMXB0IcMCxxLXvKgcl2dVLLx5/7x5jY5gT
         TJOw==
X-Gm-Message-State: ALoCoQluZa2iuq9JBOloqMghoD1qz0nskxgnqVv9RhDIFFupgme33hl6bPhGs3GZ4/+nf6/BNPCS
X-Received: by 10.180.84.198 with SMTP id b6mr32704005wiz.41.1416928243264;
        Tue, 25 Nov 2014 07:10:43 -0800 (PST)
Received: from trevor.secretlab.ca (host86-166-84-117.range86-166.btcentralplus.com. [86.166.84.117])
        by mx.google.com with ESMTPSA id hz9sm2271238wjb.17.2014.11.25.07.10.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Nov 2014 07:10:42 -0800 (PST)
Received: by trevor.secretlab.ca (Postfix, from userid 1000)
        id 359EAC44343; Tue, 25 Nov 2014 15:10:18 +0000 (GMT)
From:   Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH V3 0/7] serial: Configure {big,native}-endian MMIO
 accesses via DT
To:     Kevin Cernekee <cernekee@gmail.com>, gregkh@linuxfoundation.org,
        jslaby@suse.cz, robh@kernel.org
Cc:     arnd@arndb.de, f.fainelli@gmail.com, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org
In-Reply-To: <1416872182-6440-1-git-send-email-cernekee@gmail.com>
References: <1416872182-6440-1-git-send-email-cernekee@gmail.com>
Date:   Tue, 25 Nov 2014 15:10:18 +0000
Message-Id: <20141125151018.359EAC44343@trevor.secretlab.ca>
Return-Path: <glikely@secretlab.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44443
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@linaro.org
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

On Mon, 24 Nov 2014 15:36:15 -0800
, Kevin Cernekee <cernekee@gmail.com>
 wrote:
> My last submission attempted to work around serial driver coexistence
> problems on multiplatform kernels.  Since there are still questions
> surrounding the best way to solve that problem, this patch series
> will focus on the narrower topic of big endian MMIO support on serial.
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

For the whole series:
Acked-by: Grant Likely <grant.likely@linaro.org>

Greg, which tree do you want to merge this through? My DT tree, or the
tty tree?

g.

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
> -- 
> 2.1.0
> 
