Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Mar 2016 10:01:47 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.126.134]:58025 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007226AbcCBJBpX2RuB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Mar 2016 10:01:45 +0100
Received: from wuerfel.localnet ([78.42.132.4]) by mrelayeu.kundenserver.de
 (mreue004) with ESMTPSA (Nemesis) id 0LtBsd-1Zur0C1RAR-012t9T; Wed, 02 Mar
 2016 10:01:15 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Manuel Lauss <manuel.lauss@gmail.com>
Cc:     linux-pcmcia@lists.infradead.org,
        Linux-MIPS <linux-mips@linux-mips.org>, linus.walleij@linaro.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] pcmcia: db1xxx_ss: fix last irq_to_gpio user
Date:   Wed, 02 Mar 2016 10:01:14 +0100
Message-ID: <10378188.DNrgKt6rYE@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <1456906572-101795-1-git-send-email-manuel.lauss@gmail.com>
References: <1456906572-101795-1-git-send-email-manuel.lauss@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K0:AadaD+taI2Xl7zNr2lEOKgXmBFqZvpD0w6cqxOXDC/kqkCuAFJt
 FUGmo3kYUO0Zj6osnH9EaDhgGZc1UYQdIrOkWhppkhFIFEWyv0q8DuTCXhJgIT9BlqOjlao
 otXdieK946xh5Kjr10UZiXN5mjgt94KO+Glkhqiwe7Mo2DpgrDoUGUqnXUiUoxAq9uqT+aX
 tOxP6UWkipH6utB0Yhb3A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lIuXCF/uInQ=:BQnwHcC/ECtm3TMS7xTTYj
 kzcpN+Pd9LKmV5qUiwz9GsuaDopSz4CgZuWXrmgPcZnuGMI18VxaIEvfC4eUjNvrTryKtktU8
 iPeHlsEuf86BCCDGoCVpbj5/odu8ECV1ebOIPd2GVi0ek9R517lyE38sTTVSNd7EDSqmgeJ+a
 p2OuwpYiLXlJwXPdVLxJinjiTxdcrUAXrTpcilnVS03B+BtZqYjANFFJWmIPGGPUf0B8UhrrY
 j8bNx1Hldve+Ip3IsPvUY+X+SOFCYlVkxa63GfE1tccVshfC0k9f1S2br85Nm7xrbanurxJgK
 bsDH4qixy0P91S+dkKqdbMNxX+ICcVXXpUSy1SEVxc5tGyf4X6Gl+sa4yzqacAyGazF0gN4eC
 XuUFarGwk/GpOaKW/Dv0oIbJBoMqyyH/jW8lhP8OS+WP0YxFUBNkOfGTFgnn7S9zxbnlImGuQ
 d4pYm+Wf/QFCa6ZRO3MvG+ILEtd0Kp53ngNteiBgfum+tYyTYAT9E8N8Y+0LRwf72ELK5hGMb
 R3vvBm24DvTITBUTRGy/j5RientIZtbWr5+eZFN769byL9YN1NZLn8LblVh4KeVkQgNoKzP92
 /BmYo+IN9WvepsoUQjTN6v2SSBJknK800b9KtGrlnSh9WgZtxpbZlDEwulUyveAeZUymjMIAq
 tDCiY7bXuN4erj47DzXuUZrda5XHpTsYnYtGbmFRgm4pmrqiTYwmEdt39SeoLN6fZd92YWcFx
 wt7zHmhn8pPkbduQ
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52415
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Wednesday 02 March 2016 09:16:12 Manuel Lauss wrote:
> remove the usage of removed irq_to_gpio() function.  On pre-DB1200
> boards, pass the actual carddetect GPIO number instead of the IRQ,
> because we need the gpio to actually test card status (inserted or
> not) and can get the irq number with gpio_to_irq() instead.
> 
> Tested on DB1300 and DB1500, this patch fixes PCMCIA on the DB1500,
> which used irq_to_gpio().
> 
> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>

Thanks for addressing this

Acked-by: Arnd Bergmann <arnd@arndb.de>

You should probably add the fixes line from my earlier patch,
and add Cc:stable so it gets backported to 4.4.

>  
> -	/* insert: irq which triggers on card insertion/ejection */
> +	/* insert: irq which triggers on card insertion/ejection
> +	 * BIG FAT NOTE: on DB1000/1100/1500/1550 we pass a GPIO here!
> +	 */
>  	r = platform_get_resource_byname(pdev, IORESOURCE_IRQ, "insert");
>  	sock->insert_irq = r ? r->start : -1;
> +	if (sock->board_type == BOARD_TYPE_DEFAULT) {
> +		sock->insert_gpio = r ? r->start : -1;
> +		sock->insert_irq = r ? gpio_to_irq(r->start) : -1;
> +	}
>  
>  	/* stschg: irq which trigger on card status change (optional) */
>  	r = platform_get_resource_byname(pdev, IORESOURCE_IRQ, "stschg");

My first approach was to pass the gpio number as platform_data, but
that seemed to get rather complicated, so I dropped the initial
patch.

Passing it as an IORESOURCE_IRQ is a bit weird too, but I guess it
gets the job done.

	Arnd
