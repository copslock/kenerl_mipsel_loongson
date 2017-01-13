Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jan 2017 17:01:22 +0100 (CET)
Received: from mail-lf0-x234.google.com ([IPv6:2a00:1450:4010:c07::234]:32927
        "EHLO mail-lf0-x234.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993940AbdAMQBPiEmji (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Jan 2017 17:01:15 +0100
Received: by mail-lf0-x234.google.com with SMTP id k86so41055458lfi.0
        for <linux-mips@linux-mips.org>; Fri, 13 Jan 2017 08:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind-com.20150623.gappssmtp.com; s=20150623;
        h=reply-to:subject:references:to:cc:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=/zoqQ5rcLG0TI8EVzxtNvAGbwi8ruFdulRz8b1kAaC8=;
        b=XVwuAS+aWpgNFsxenrKe45/397TUcHI9uQWkMYvfEFRsizZdPFMgSyStMW3ilf/MzP
         C10bs38SegWOXuQnKt0IXPT3wSwq+o4DDIF4Z5ZyroL0tUjk8/7iWS8OdfmRUlkvdBqP
         tQr873yNPZ5yVM6+7vVk36Rq8N62go1UW2vMegGTtRwvQnAOG7HN6Is9EVLLewdLyTfR
         UcdycRTi5fx5BIprPS64ByZ89/Uqvic8M63Wu/JWBl0oIfOjuXLeVtSf8qVIW7ed/UTW
         DSnfENQ+3WszEne4Zr8T837cHl872dmXRfYxAdijga7YJ/cv7P4Q6u/Lmm25tg50Sy32
         uiPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:references:to:cc:from
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=/zoqQ5rcLG0TI8EVzxtNvAGbwi8ruFdulRz8b1kAaC8=;
        b=dPJy7rJ1jYjbpdjeX3Xf67w5ZiGGHoXEj1S1puOodT0N18kh8e7ITVs2bYAEXRCNKy
         /6AUpYKPEiVkP5IXgh+hV5DnucRjcodj2j0PAdYWUG5E2jmk+fx0hY3oPc90M+bTSl32
         jCyAx5d3g+bDI/nmbgRBKh0k7Aljs/cQJQcMOoWBuEXtYmaC6p3rlQjFxnigHau4iRs9
         XX/ZmzBvdiqK3YHJygs9gs352aLB2PcrsnquTptO5eIQuipRuiJcW9OmitjkvKMkHYf8
         pYWMNkqb/9LDeAiOEYyxzvyGITu7mafhX8rhNV58gnCyl+byghpos+OcoCg6T54X58lJ
         umRQ==
X-Gm-Message-State: AIkVDXKZ2brfmwTHN0bsbUfNKZDGvXKQ7FAUKhUKmJ8zN8+klDYmd3jsE3KHPXZXzWwf7oip
X-Received: by 10.25.169.82 with SMTP id s79mr6476425lfe.76.1484323268098;
        Fri, 13 Jan 2017 08:01:08 -0800 (PST)
Received: from ?IPv6:2a01:e35:8b63:dc30:a59f:2d65:8857:f31? ([2a01:e35:8b63:dc30:a59f:2d65:8857:f31])
        by smtp.gmail.com with ESMTPSA id c66sm4102689ljd.44.2017.01.13.08.01.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jan 2017 08:01:07 -0800 (PST)
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH v3 1/8] arm: put types.h in uapi
References: <1484304406-10820-2-git-send-email-nicolas.dichtel@6wind.com>
 <3131144.4Ej3KFWRbz@wuerfel>
 <1484304406-10820-1-git-send-email-nicolas.dichtel@6wind.com>
 <25063.1484321803@warthog.procyon.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     arnd@arndb.de, linux-mips@linux-mips.org,
        linux-m68k@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-doc@vger.kernel.org, alsa-devel@alsa-project.org,
        dri-devel@lists.freedesktop.org, linux-mtd@lists.infradead.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-am33-list@redhat.com,
        linux-c6x-dev@linux-c6x.org, linux-rdma@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-sh@vger.kernel.org,
        linux@armlinux.org.uk, coreteam@netfilter.org,
        fcoe-devel@open-fcoe.org, xen-devel@lists.xenproject.org,
        linux-snps-arc@lists.infradead.org, linux-media@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-xtensa@linux-xtensa.org, linux-kbuild@vger.kernel.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-raid@vger.kernel.org, openrisc@lists.librecores.org,
        linux-fbdev@vger.kernel.org, linux-metag@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-cris-kernel@axis.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, netfilter-devel@vger.kernel.org,
        linux-alpha@vger.kernel.org, nio2-dev@lists.rocketboards.org,
        linuxppc-dev@lists.ozlabs.org
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
Message-ID: <4633e475-47f2-5627-81a9-a1747dfddbc0@6wind.com>
Date:   Fri, 13 Jan 2017 17:01:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <25063.1484321803@warthog.procyon.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-Path: <nicolas.dichtel@6wind.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56305
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

Please, do not remove the email subject when you reply. I restore it to ease the
thread follow-up.

Le 13/01/2017 à 16:36, David Howells a écrit :
> Nicolas Dichtel <nicolas.dichtel@6wind.com> wrote:
> 
>> This header file is exported, thus move it to uapi.
> 
> Exported how?
It is listed in include/uapi/asm-generic/Kbuild.asm, which is included by
arch/arm/include/uapi/asm/Kbuild.

You can also have a look at patch #5 to see why it was exported even if it was
not in an uapi directory.

Regards,
Nicolas
