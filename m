Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Nov 2018 05:22:13 +0100 (CET)
Received: from mail-wr1-x443.google.com ([IPv6:2a00:1450:4864:20::443]:37485
        "EHLO mail-wr1-x443.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992081AbeKLEWE68xYj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Nov 2018 05:22:04 +0100
Received: by mail-wr1-x443.google.com with SMTP id o15-v6so7728490wrv.4;
        Sun, 11 Nov 2018 20:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=02S7gP8CBtLu/d2vn+LP1VB7jEPtnklyU3WqzRNVQTc=;
        b=VzrSRQ+JM8AQLv7s6XcDBlE0ZdMcRcFn+6R+TNTqMLem6BSiFRB3dsOATP099IGwpd
         ujEP/GRork6e1NAWzbnuRxVWZlTp4B/TA1/FsIBQ152QWUAbp1Z2iJpWUmkG6G3pcNVp
         3D4bZk3y4+eGJM1qVcwn9yq7zT/LunSQnwxjx7/CvV4cp++6YMRnPfWGXpaFozbhxDB0
         xil5IcRk1ThTK9AnTHYQm1HWfxj3mAuAJihoW5G1NBvfVqzcMYi79X6YkAtryz5UweP0
         fVc37qOiSTUvs6rpobcLPxKINjBBLEPgoKVeOTEwZHBu0C0YQLSY0epaeHqSXAHbW2Ys
         RE4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=02S7gP8CBtLu/d2vn+LP1VB7jEPtnklyU3WqzRNVQTc=;
        b=Ox5unBMqUaStWPr+YzAyyO6GrBqJgmi+zb1UL2c7+125Cevbq4NbyhtVwx4HBd5OoS
         y3RLNrOz5DsPLRAJHdPC+4lVSZYES6xNZRRM1aSMhXjHY75gZlO/XwrXJnu4h3Sll/yL
         eBiucLMu/4KVqZisMbetySfdTixGYGXAJ9Xp6s5VFWV8nNPr1yMIw9cJVPklbGacxrDr
         IXlYlD9PEElL5+pO2qlnPTwkYrncTh17KHB/NbKwLUi2pv+x/U+YbOMFk4moxgA/OjrH
         9LtrCjNX0o8pqzNu3gZ80ROpNu335LLcO3r78TS6Jg7viC2PYuv8mWt1NaSB8WIy0pqP
         DDfg==
X-Gm-Message-State: AGRZ1gKAAH6kDokA5UzL/PcLBRq6KRRRb/gZEkV5kkQ6EKLK3F90Bc43
        n9cfS/6zNtHFw5VGINRNSz4=
X-Google-Smtp-Source: AJdET5dqo97oNvVhbeHeAC8ILm3BUif2kLLNwLcv0IBPSdLDjvuMRio/jZQQxfkfSCWQWlB8F0MuNQ==
X-Received: by 2002:adf:df0a:: with SMTP id y10-v6mr14821319wrl.127.1541996524481;
        Sun, 11 Nov 2018 20:22:04 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id j189-v6sm26136436wmf.18.2018.11.11.20.22.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 11 Nov 2018 20:22:03 -0800 (PST)
Date:   Mon, 12 Nov 2018 05:22:00 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Adam Borowski <kilobyte@angband.pl>
Cc:     linux-kernel@vger.kernel.org, Nick Terrell <terrelln@fb.com>,
        Russell King <linux@armlinux.org.uk>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        openrisc@lists.librecores.org,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org
Subject: Re: [PATCH 02/17] x86: Add support for ZSTD-compressed kernel
Message-ID: <20181112042200.GA96061@gmail.com>
References: <20181109185953.xwyelyqnygbskkxk@angband.pl>
 <20181109190304.8573-1-kilobyte@angband.pl>
 <20181109190304.8573-2-kilobyte@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109190304.8573-2-kilobyte@angband.pl>
User-Agent: Mutt/1.9.4 (2018-02-28)
Return-Path: <mingo.kernel.org@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67244
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingo@kernel.org
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


* Adam Borowski <kilobyte@angband.pl> wrote:

> From: Nick Terrell <terrelln@fb.com>
> 
> Integrates the ZSTD decompression code to the x86 pre-boot code.
> 
> Zstandard requires slightly more memory during the kernel decompression
> on x86 (192 KB vs 64 KB), and the memory usage is independent of the
> window size.
> 
> Zstandard requires memory proportional to the window size used during
> compression for decompressing the ramdisk image, since streaming mode is
> used. Newer versions of zstd (1.3.2+) list the window size of a file
> with `zstd -lv <file>'. The absolute maximum amount of memory required
> is just over 8 MB.
> 
> Signed-off-by: Nick Terrell <terrelln@fb.com>
> ---
>  Documentation/x86/boot.txt        | 6 +++---
>  arch/x86/Kconfig                  | 1 +
>  arch/x86/boot/compressed/Makefile | 5 ++++-
>  arch/x86/boot/compressed/misc.c   | 4 ++++
>  arch/x86/boot/header.S            | 8 +++++++-
>  arch/x86/include/asm/boot.h       | 6 ++++--
>  6 files changed, 23 insertions(+), 7 deletions(-)

Acked-by: Ingo Molnar <mingo@kernel.org>

> diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
> index 4c881c850125..af2efb256527 100644
> --- a/arch/x86/boot/header.S
> +++ b/arch/x86/boot/header.S
> @@ -526,8 +526,14 @@ pref_address:		.quad LOAD_PHYSICAL_ADDR	# preferred load addr
>  # the size-dependent part now grows so fast.
>  #
>  # extra_bytes = (uncompressed_size >> 8) + 65536
> +#
> +# ZSTD compressed data grows by at most 3 bytes per 128K, and only has a 22
> +# byte fixed overhead but has a maximum block size of 128K, so it needs a
> +# larger margin.
> +#
> +# extra_bytes = (uncompressed_size >> 8) + 131072
>  
> -#define ZO_z_extra_bytes	((ZO_z_output_len >> 8) + 65536)
> +#define ZO_z_extra_bytes	((ZO_z_output_len >> 8) + 131072)

This change would also affect other decompressors, not just ZSTD, 
correct?

Might want to split this change out into a separate preparatory patch to 
allow it to be bisected to, or at least mention it in the changelog more 
explicitly?

Thanks,

	Ingo
