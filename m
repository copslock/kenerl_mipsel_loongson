Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Apr 2016 14:39:11 +0200 (CEST)
Received: from mail-pf0-f173.google.com ([209.85.192.173]:35237 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026803AbcDQMjIDw1Vr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 17 Apr 2016 14:39:08 +0200
Received: by mail-pf0-f173.google.com with SMTP id n1so71619453pfn.2;
        Sun, 17 Apr 2016 05:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rF8tBR6FeVKmNAFmTqMzkb6ZmHXyqas7YHtcuM09CVM=;
        b=V7pNzT7xeuViB4xZOm2JrSU0tSeVXJntYg5RhBPcD7zHw7IoZ2OYcfO9sEsjXwLn22
         ING2eDG0+QXUAP+EMYRTujmlTpaCXBVezK2Ih+BXbVGMwHotL5iNbtmLCs7iWmKQxyfz
         8KCByXPfPT47Y7bP+5iNuDnnbdzZh2UKiJAm7pMeHO5Blrwv3hVadksTe9yoxTWfttJg
         JThYcaJjltSG4HlK1ZC4zAGjTJfVLabSBV1ErVe53vST21wOTDceV7JGTI4e06Nkv3y4
         MRr9tamYLjIVkUz3De/VMUQbBeLtfKh3gKxt5jYcmkYtkca9WYREBjdKTke6JIATNKUx
         o8+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rF8tBR6FeVKmNAFmTqMzkb6ZmHXyqas7YHtcuM09CVM=;
        b=RG8lGQdEMrrIa1hs69Geucxh6Pvh+GwCNOGGsvlNQHVnKBiY00B9vUPheXrkRZRdS2
         nqywX+Tlh/mlvDyXQrCK8WZlxWtKlauVaeqOspR4Ax/SZ+qC0sxnWE787y41BWd/PKc/
         sMKg97//1fHsXzHGvMtRjk4Mhlp5tmse9cxErqwvUpJAFSq8k5JQ8AgJjTS+OzLXKH1K
         KuVT8n+MLf9fI9v3PeLSukiSOWPKzU4WSLEHAbqwl4f3gZ9ywq26gzIntTEBEuIZP8Lp
         7UmUl7PTmowjsv22gJwtDqsSnoBxEG3lCmMFMfkFRm3ovP1bCETUbjJ7FV95owRT35jV
         4yxg==
X-Gm-Message-State: AOPr4FVYKC2uw8o8KKgvbnnbJeuhruF3c1uDvhpa8+ZMSgNgmeszPAZwITqx3rQTC4stcA==
X-Received: by 10.98.69.1 with SMTP id s1mr42788103pfa.56.1460896741959;
        Sun, 17 Apr 2016 05:39:01 -0700 (PDT)
Received: from dtor-ws ([2620:0:1000:1311:8532:83a7:8148:9133])
        by smtp.gmail.com with ESMTPSA id w125sm13204085pfb.16.2016.04.17.05.38.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 17 Apr 2016 05:39:01 -0700 (PDT)
Date:   Sun, 17 Apr 2016 05:38:57 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     zengzhaoxiu@163.com
Cc:     linux-kernel@vger.kernel.org,
        Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>,
        adi-buildroot-devel@lists.sourceforge.net,
        Andrew Morton <akpm@linux-foundation.org>,
        Anton Blanchard <anton@samba.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Borislav Petkov <bp@suse.de>,
        Bruce Allan <bruce.w.allan@intel.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        David Herrmann <dh.herrmann@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Duson Lin <dusonlin@emc.com.tw>,
        Guenter Roeck <linux@roeck-us.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ingo Molnar <mingo@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Julian Calaby <julian.calaby@gmail.com>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        linux-alpha@vger.kernel.org, linux-am33-list@redhat.com,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com,
        linux-crypto@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org, linux@lists.openrisc.net,
        linux-m68k@lists.linux-m68k.org, linux-media@vger.kernel.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        Martin Kepplinger <martink@posteo.de>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Nazarewicz <mina86@mina86.com>, netdev@vger.kernel.org,
        Peter Hutterer <peter.hutterer@who-t.net>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Pingchao Yang <pingchao.yang@intel.com>, qat-linux@intel.com,
        Ralf Baechle <ralf@linux-mips.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Sasha Levin <sasha.levin@oracle.com>,
        Scott Wood <oss@buserror.net>, sparclinux@vger.kernel.org,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Takashi Iwai <tiwai@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Torsten Duwe <duwe@lst.de>,
        uclinux-h8-devel@lists.sourceforge.jp,
        Ulrik De Bie <ulrik.debie-os@e2big.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "wim.coekaerts@oracle.com" <wim.coekaerts@oracle.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Yury Norov <yury.norov@gmail.com>,
        =?utf-8?B?5rSq5LiA56u5?= <sam.hung@emc.com.tw>
Subject: Re: [PATCH V3 00/29] bitops: add parity functions
Message-ID: <20160417123857.GD33215@dtor-ws>
References: <1460601525-3822-1-git-send-email-zengzhaoxiu@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1460601525-3822-1-git-send-email-zengzhaoxiu@163.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <dmitry.torokhov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53030
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitry.torokhov@gmail.com
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

On Thu, Apr 14, 2016 at 10:36:41AM +0800, zengzhaoxiu@163.com wrote:
>  drivers/input/joystick/grip_mp.c             |  16 +--
>  drivers/input/joystick/sidewinder.c          |  24 +----
>  drivers/input/mouse/elantech.c               |  10 +-
>  drivers/input/mouse/elantech.h               |   1 -
>  drivers/input/serio/ams_delta_serio.c        |   8 +-
>  drivers/input/serio/pcips2.c                 |   2 +-
>  drivers/input/serio/sa1111ps2.c              |   2 +-

For input bits:

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry
