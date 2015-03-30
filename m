Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Mar 2015 00:02:33 +0200 (CEST)
Received: from mail-ig0-f176.google.com ([209.85.213.176]:38454 "EHLO
        mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010143AbbC3WCbVdky8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Mar 2015 00:02:31 +0200
Received: by igbqf9 with SMTP id qf9so1858728igb.1;
        Mon, 30 Mar 2015 15:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=9GnI1UcO11GUtMy/lqgU8Vc5mP/wl9HL1e5N+4a7cn0=;
        b=BJJhymqJdKBM5JvyD3lLMl9sZ7wMa+2Zzsm+dgbIxnVcH65aGjneXLtfUPdXsFz1bV
         WBOnDdHKjOYxnGRz8EFkgQ/kzMJOtzhEIVEayeWYGXcej0kVhOppUQf8V4P8O32vencS
         PfPoB+WeaeEnHmuQ26vEjjBRsqNve5+Bz538nq9QRVIXN9Eghc4hMpRAbA73ATABTiW/
         KoYoV53VhFrtppUEaunVl+oJqQ1GtHCUfrVmjbCo1kjljlL73teoYHv+qfHvzMEB7MfT
         3oARV9h3rtaGPi2ViuujkKqyIC3JugWmLwd/xUzmZhF1YwSbHvnMjAoLVRC8DrNwpu2/
         0J+g==
X-Received: by 10.43.13.200 with SMTP id pn8mr65794741icb.0.1427752946505;
        Mon, 30 Mar 2015 15:02:26 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id k13sm3049576ioe.28.2015.03.30.15.02.24
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 30 Mar 2015 15:02:25 -0700 (PDT)
Message-ID: <5519C7EF.4070602@gmail.com>
Date:   Mon, 30 Mar 2015 15:02:23 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Paul Martin <paul.martin@codethink.co.uk>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH 00/10] MIPS: OCTEON: Little Endian roll-up
References: <1427731263-29950-1-git-send-email-paul.martin@codethink.co.uk>
In-Reply-To: <1427731263-29950-1-git-send-email-paul.martin@codethink.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46613
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 03/30/2015 09:00 AM, Paul Martin wrote:
> This is an experimental patch set for enabling Little Endian working on
> the Cavium Octeon II.  It may work for other Octeon models but has not
> been tested on them.
>
> It's been extensively tested on a Ubiquiti EdgeRouter Pro, building a
> current GNU/Linux toolchain from sources using an external USB drive.
>
> My contributions (with the exception of the changes to octeon-md5) are
> mainly cherry-picked from the GPL tarball released by Ubiquiti, and
> appear to have originally been authored by Cavium.
>
> David Daney (3):
>    MIPS: OCTEON: Handle bootloader structures in little-endian mode.
>    MIPS: OCTEON: Add mach-cavium-octeon/mangle-port.h
>    MIPS: OCTEON: Enable little endian kernel.
>
> Paul Martin (7):
>    MIPS: OCTEON: Turn hardware bitfields and structures inside out.
>    MIPS: OCTEON: Set appropriate endianness in L2C registers
>    MIPS: OCTEON: Reverse the order of register accesses to the FAU
>    MIPS: OCTEON: Set up ethernet hardware for little endian
>    MIPS: OCTEON: Make octeon-md5 driver endian-agnostic
>    MIPS: OCTEON: Fix to IP checksum offloading in Little Endian
>    MIPS: OCTEON: Fix Kconfig file typo
>
>   arch/mips/Kconfig                                  |   3 +-
>   arch/mips/cavium-octeon/crypto/octeon-crypto.h     |   8 +-
>   arch/mips/cavium-octeon/executive/cvmx-l2c.c       |  45 ++++
>   arch/mips/cavium-octeon/octeon-platform.c          |  12 +
>   arch/mips/cavium-octeon/octeon_boot.h              |  23 ++
>   .../include/asm/mach-cavium-octeon/mangle-port.h   |  74 ++++++
>   arch/mips/include/asm/octeon/cvmx-address.h        |  67 ++++++
>   arch/mips/include/asm/octeon/cvmx-bootinfo.h       |  55 +++++
>   arch/mips/include/asm/octeon/cvmx-bootmem.h        |  14 ++
>   arch/mips/include/asm/octeon/cvmx-fau.h            |  22 ++
>   arch/mips/include/asm/octeon/cvmx-fpa.h            |   7 +
>   arch/mips/include/asm/octeon/cvmx-l2c.h            |   9 +
>   arch/mips/include/asm/octeon/cvmx-packet.h         |   8 +
>   arch/mips/include/asm/octeon/cvmx-pko.h            |  31 +++
>   arch/mips/include/asm/octeon/cvmx-pow.h            | 247 +++++++++++++++++++++
>   arch/mips/include/asm/octeon/cvmx-wqe.h            |  71 ++++++
>   drivers/staging/octeon/ethernet-tx.c               |   5 +-
>   drivers/staging/octeon/ethernet.c                  |  10 +
>   18 files changed, 705 insertions(+), 6 deletions(-)
>   create mode 100644 arch/mips/include/asm/mach-cavium-octeon/mangle-port.h
>

The whole series:

Acked-by: David Daney <david.daney@cavium.com>

Thanks for doing the work.

David.
