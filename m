Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Mar 2017 02:03:28 +0100 (CET)
Received: from mail-qk0-x243.google.com ([IPv6:2607:f8b0:400d:c09::243]:36851
        "EHLO mail-qk0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994766AbdCNBDVcVvHc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Mar 2017 02:03:21 +0100
Received: by mail-qk0-x243.google.com with SMTP id n141so39416428qke.3;
        Mon, 13 Mar 2017 18:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=tFFS1QSYmRlRAVXFgf95c3VU6d8CI9QDkSqeMaufsjM=;
        b=TAXzVH5ltYIQS/LLmzA80vH5xmOq1HzZ/kjU0ICsN3TgbRjnPu0WONQKTYRpTA1WKX
         we3oZBkUgJXakehyFBCc7zhvNMJ0qkw0UcmUsHSFuPBs415oNzBuEnZ+4ubD/dLarCtJ
         LYj4FrK6x5ubpArz7kzs1HDJ4O5s56CJ2yqpyjHgZ/B7cluS/Pi2jEsYNU4iz3IdnLz2
         xP+go6eoNi5kFf+5t0r0700e6ea9HaUVcoZEouMErSkCkzMTKswZCUBmaF5V6SiDakQr
         TiYAxU9RaFbif5lmZ9C3lTYzDaQmwYLr/BmiWrJipA49PI8shpm08G6jaeTtgwiFZ7J7
         yK1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=tFFS1QSYmRlRAVXFgf95c3VU6d8CI9QDkSqeMaufsjM=;
        b=iBG5c4Br17CKQvPamt+wgzTXCD40lS6oFDxoD4C5YJp87/dXmbH36ZXcoqMWaT3HYl
         /khA2fMKOLov6jNc9lxzo90WPEnwnr7vJEA6diFlZwWhSbAGc6T7PBfBg0oC+3R7UuEM
         xPedBP5ZQpmdPeoZL6kQMExVSdHPPujAQq0zdFZuNU8dRmwklbwHuo3W574vZuW1HZ1C
         jmV3tHdH8xgQVL9VBPfcbxmpnPPTPRVmO+ld8whLK+TMV/21f29eJ+vlTu+QNxjR/mEu
         0JS7wT3APwauJvo8cKsiAMUDbTtvzUujiVoqNQe4KgUVnKiIMWq43zkcI04/qXZ/E9k/
         escA==
X-Gm-Message-State: AFeK/H0zavFFyy1KX967K0/sRoeex5j8C5UcSTqQle78+0ndQDapn3hMaGaVVKETYaEq7w==
X-Received: by 10.55.209.28 with SMTP id s28mr33116763qki.178.1489453395867;
        Mon, 13 Mar 2017 18:03:15 -0700 (PDT)
Received: from bigtime.twiddle.net ([220.240.225.200])
        by smtp.googlemail.com with ESMTPSA id f66sm13359286qkj.13.2017.03.13.18.02.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Mar 2017 18:03:14 -0700 (PDT)
Subject: Re: [RFC PATCH 00/13] Introduce first class virtual address spaces
To:     Till Smejkal <till.smejkal@googlemail.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Steven Miao <realmz6@gmail.com>,
        Richard Kuo <rkuo@codeaurora.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Pawel Osciak <pawel@osciak.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Cyrille Pitchen <cyrille.pitchen@atmel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>,
        Nadia Yvette Chambers <nyc@holomorphy.com>,
        Jeff Layton <jlayton@poochiereds.net>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-media@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-usb@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, linux-mm@kvack.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, alsa-devel@alsa-project.org
References: <20170314003935.2jwycgajo7eojmvm@arch-dev>
From:   Richard Henderson <rth@twiddle.net>
Message-ID: <fa60d132-0eef-4350-3c88-1558f447a48f@twiddle.net>
Date:   Tue, 14 Mar 2017 11:02:37 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170314003935.2jwycgajo7eojmvm@arch-dev>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <rth7680@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57190
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rth@twiddle.net
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

On 03/14/2017 10:39 AM, Till Smejkal wrote:
>> Is this an indication that full virtual address spaces are useless?  It
>> would seem like if you only use virtual address segments then you avoid all
>> of the problems with executing code, active stacks, and brk.
>
> What do you mean with *virtual address segments*? The nice part of first class
> virtual address spaces is that one can share/reuse collections of address space
> segments easily.

What do *I* mean?  You introduced the term, didn't you?
Rereading your original I see you called them "VAS segments".

Anyway, whatever they are called, it would seem that these segments do not 
require any of the syncing mechanisms that are causing you problems.


r~
