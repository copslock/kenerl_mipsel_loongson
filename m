Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Mar 2015 20:19:19 +0100 (CET)
Received: from mail-ig0-f181.google.com ([209.85.213.181]:33611 "EHLO
        mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008800AbbCPTTSPfd7x (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Mar 2015 20:19:18 +0100
Received: by ignm3 with SMTP id m3so38901187ign.0
        for <linux-mips@linux-mips.org>; Mon, 16 Mar 2015 12:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=3Gww5PbkfrFWFIcdwdccvlgliLEOULbWEmM2WxWI2q4=;
        b=Aq1M+kmpLQPvj5jq4kyytgM0h0NiAB7qEdGaNWb694T0FefKHGW0qJbu/QcYjGuwWP
         uktEJfKBNxGTN/jsSiuL9u3PsAONuYgY5FRAvt6ZfyFbOIyGFgeqV3Oy42FGZUk3jzad
         L6ppK/YRNOJLNsmiin6hD2/39fOBw0VrqDO8Gf3N8CmJlNElS4dlbNaq19HkDb6195+D
         ULy6bS2THlQ4y/pe77NNNcHWNrJG08TqVCX5S5CX/BzzrC1ELfsZUKxu2GIZVXP8J4eS
         oBs7dyyQfkapozD1c6opvIh1gS3z0KexzF61UWZ2Z1ziz/m484UX5APeQgkteYoMMwM+
         FDnw==
X-Received: by 10.50.43.130 with SMTP id w2mr112110631igl.30.1426533553162;
        Mon, 16 Mar 2015 12:19:13 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id 17sm7231935iol.39.2015.03.16.12.19.12
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 16 Mar 2015 12:19:12 -0700 (PDT)
Message-ID: <55072CAD.7050906@gmail.com>
Date:   Mon, 16 Mar 2015 12:19:09 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Paul Martin <paul.martin@codethink.co.uk>,
        "Makarov, Aleksey" <aleksey.makarov@auriga.com>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH 0/7] MIPS: OCTEON: Experimental patches to enable Little
 Endian
References: <1426529923-13340-1-git-send-email-paul.martin@codethink.co.uk>
In-Reply-To: <1426529923-13340-1-git-send-email-paul.martin@codethink.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46413
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

On 03/16/2015 11:18 AM, Paul Martin wrote:
> Octeon II CPUs can switch from Big Endian to Little Endian freely
> even in kernel/supervisor mode.

There are many caveats for dynamic endian switching.  "Freely" doesn't 
really describe it.

>
> These patches allow an EdgeRouterPro to boot in LE mode with no
> hardware modifications.  They have not been subjected to extensive
> testing yet and should be considered experimental.  (I have seen some
> strange memory corruption in libstdc++ which I haven't yet been able
> to trace.)
>
> Parts of this patchset are based on the "GPL" sources released by
> Ubiquiti.
>

Aleksey (On the To: list here) also has a patch set for this that he is 
readying.

Some of your patches are even incorrect.  I will respond to those 
individually.

> v2:
> * Remove unneeded assembler code in kernel-entry-init.h
> * Add patch to octeon-md5 code
> * Re-order patches
> * Sign the patches
>
> Paul Martin (7):
>    MIPS: OCTEON: Ensure CPUs come up little endian
>    MIPS: OCTEON: Turn hardware bitfields and structures inside out
>    MIPS: OCTEON: Set appropriate endianness in L2C registers
>    MIPS: OCTEON: Reverse the order of register accesses to the FAU
>    MIPS: OCTEON: Set up ethernet hardware for little endian
>    MIPS: OCTEON: Make octeon-md5 driver endian-agnostic
>    MIPS: OCTEON: Tell the kernel build system we can do Little Endian
>
>   arch/mips/Kconfig                                  |   1 +
>   arch/mips/cavium-octeon/crypto/octeon-crypto.h     |   8 +-
>   arch/mips/cavium-octeon/executive/cvmx-l2c.c       |  45 ++++
>   arch/mips/cavium-octeon/octeon-platform.c          |  12 +
>   .../asm/mach-cavium-octeon/kernel-entry-init.h     |  68 ++++++
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
>   drivers/staging/octeon/ethernet-tx.c               |   3 +
>   drivers/staging/octeon/ethernet.c                  |  10 +
>   17 files changed, 674 insertions(+), 4 deletions(-)
>
