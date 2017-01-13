Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jan 2017 17:08:54 +0100 (CET)
Received: from mail-wm0-x232.google.com ([IPv6:2a00:1450:400c:c09::232]:36278
        "EHLO mail-wm0-x232.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993940AbdAMQIsaNIDi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Jan 2017 17:08:48 +0100
Received: by mail-wm0-x232.google.com with SMTP id c85so71169834wmi.1
        for <linux-mips@linux-mips.org>; Fri, 13 Jan 2017 08:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind-com.20150623.gappssmtp.com; s=20150623;
        h=reply-to:subject:references:to:cc:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Avg3is2joRsoOW1SoBexrSu2HFewlOZOKE9YrkazkLI=;
        b=fL4eZGCF2ZGuK8MA5HcRUAW+LfACU/iv9o7m2cMmr5OAMRnlyRsPSNNVf+6mJJ+vtF
         +gAEqK7eTn3Flx/yyFHnn5JJWtcqtva21uJ+Nc5AyKcdZ9ZDVL+BtUPxfUnzf0hrQrkk
         torjHWgSMBVyVGn0rxA7ePORLTwaGT+wFAvv4V9NFxcwbZbdnG3Rc3sBH6bURFmsykWC
         JSiP51qEScCDWiowcRL8imt6EiAewCrf/aM4AV48isAyGlne52kULARPugTpfuR+RXoz
         L16OETZ9u/FZH2v0+ZpW0l/3D/e+S8uNeNKfzzZeunMY61OP2ZhRxArszkkGLg305J/u
         ksBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:references:to:cc:from
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=Avg3is2joRsoOW1SoBexrSu2HFewlOZOKE9YrkazkLI=;
        b=MNFKUPl123y8NdfXHvBqblpZNy9pR5/fqbiz59eaOiCAlVSMR37VgkyrY7wZYhSG9M
         NIY8Yc9FRbW/YYw9cwRHOy7L2Q1ZYhNYiRgOYcWSvxvbc+Ncwk6SNgIdiQJJYgGakH4y
         q8Ba6lv5xdmj9Qpf2gjeb90Mzh7e2VnJXJ+Nl0HaAK2l42cyQxM853nK080IKpd9+ew0
         n490iBdDnFG6mZL2BAwvbB+D8iEWeDi3RWQ2zglqXAgVxFsaMu2YJ+5Fls36HPFGcNCW
         6Os2k/sLRideXl82mRymXYgirArcvrAXy/eW/s5PM51dhG7qE8d4OvZfG0Hqw6vrtyBl
         g6oA==
X-Gm-Message-State: AIkVDXKKyG/5xPxmanjutwuwIR8QjQwUoRuy4iupGxldnlIYbCuZpt9mkLoh3dABEIhdGhRR
X-Received: by 10.28.213.193 with SMTP id m184mr3013217wmg.28.1484323723088;
        Fri, 13 Jan 2017 08:08:43 -0800 (PST)
Received: from ?IPv6:2a01:e35:8b63:dc30:a59f:2d65:8857:f31? ([2a01:e35:8b63:dc30:a59f:2d65:8857:f31])
        by smtp.gmail.com with ESMTPSA id d199sm5503933wmd.0.2017.01.13.08.08.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jan 2017 08:08:42 -0800 (PST)
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH v3 4/8] x86: stop exporting msr-index.h to userland
References: <1484304406-10820-5-git-send-email-nicolas.dichtel@6wind.com>
 <3131144.4Ej3KFWRbz@wuerfel>
 <1484304406-10820-1-git-send-email-nicolas.dichtel@6wind.com>
 <25483.1484322229@warthog.procyon.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     arnd@arndb.de, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@vger.kernel.org, linux-metag@vger.kernel.org,
        linux-mips@linux-mips.org, linux-am33-list@redhat.com,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org, dri-devel@lists.freedesktop.org,
        netdev@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mmc@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, linux-nfs@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-rdma@vger.kernel.org,
        fcoe-devel@open-fcoe.org, alsa-devel@alsa-project.org,
        linux-fbdev@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux@armlinux.org.uk, Borislav Petkov <bp@alien8.de>
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
Message-ID: <dd826bc7-e1ef-be29-e0c3-692afb346036@6wind.com>
Date:   Fri, 13 Jan 2017 17:08:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <25483.1484322229@warthog.procyon.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-Path: <nicolas.dichtel@6wind.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56306
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nicolas.dichtel@6wind.com
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

Le 13/01/2017 à 16:43, David Howells a écrit :
>> -header-y += msr-index.h
> 
> I see it on my desktop as /usr/include/asm/msr-index.h and it's been there at
> least four years - and as such it's part of the UAPI.  I don't think you can
> remove it unless you can guarantee there are no userspace users.
I keep it in the v2 of the series, but the maintainer, Borislav Petkov, asks me
to un-export it.

I will follow the maintainer decision.


Regards,
Nicolas
