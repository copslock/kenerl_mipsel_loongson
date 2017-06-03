Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Jun 2017 16:13:45 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:47426 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991960AbdFCONhSgmm1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 3 Jun 2017 16:13:37 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B98E9AB9D;
        Sat,  3 Jun 2017 14:13:36 +0000 (UTC)
Subject: Re: [PATCH v3 1/2] tty: add compat_ioctl callbacks
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Valentin Rothberg <vrothberg@suse.com>
References: <20170603135111.5444-1-asarai@suse.de>
 <20170603135111.5444-2-asarai@suse.de>
From:   Aleksa Sarai <asarai@suse.de>
Message-ID: <7bd066af-bd37-5a66-74b7-1267b58a43f8@suse.de>
Date:   Sun, 4 Jun 2017 00:13:27 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20170603135111.5444-2-asarai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <asarai@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58189
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: asarai@suse.de
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

> diff --git a/Makefile b/Makefile
> index 470bd4d9513a..fb689286d83a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -401,6 +401,7 @@ KBUILD_CFLAGS   := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
>   		   -fno-strict-aliasing -fno-common \
>   		   -Werror-implicit-function-declaration \
>   		   -Wno-format-security \
> +		   -Wno-error=int-in-bool-context \
>   		   -std=gnu89 $(call cc-option,-fno-PIE)


Ah sorry, I committed that by accident. I'll send a fixed version.

-- 
Aleksa Sarai
Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/
