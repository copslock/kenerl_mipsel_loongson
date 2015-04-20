Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Apr 2015 20:41:57 +0200 (CEST)
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:50976 "EHLO
        filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011771AbbDTSlzquNex (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Apr 2015 20:41:55 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri2.pp.htv.fi (Postfix) with ESMTP id C7AC519BDC7;
        Mon, 20 Apr 2015 21:41:56 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp4.welho.com ([213.243.153.38])
        by localhost (filtteri2.pp.htv.fi [213.243.153.185]) (amavisd-new, port 10024)
        with ESMTP id 5JNTpmgFBjcY; Mon, 20 Apr 2015 21:41:51 +0300 (EEST)
Received: from fuloong-minipc (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp4.welho.com (Postfix) with ESMTP id CCB915BC011;
        Mon, 20 Apr 2015 21:41:51 +0300 (EEST)
Date:   Mon, 20 Apr 2015 21:41:51 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Kelvin Cheung <keguang.zhang@gmail.com>
Subject: Re: [RFC PATCH] MIPS: Loongson: Naming style cleanup and rework
Message-ID: <20150420184151.GA31618@fuloong-minipc.musicnaut.iki.fi>
References: <1429521179-25758-1-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1429521179-25758-1-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46946
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Hi,

On Mon, Apr 20, 2015 at 05:12:59PM +0800, Huacai Chen wrote:
> +config MACH_LOONGSON64
> +	bool "Loongson-2/3 family of machines"
>  	select SYS_SUPPORTS_ZBOOT
>  	help
> -	  This enables the support of Loongson family of machines.
> +	  This enables the support of Loongson-2/3 family of machines.
>  
> -	  Loongson is a family of general-purpose MIPS-compatible CPUs.
> -	  developed at Institute of Computing Technology (ICT),
> +	  Loongson is a family of 64-bit general-purpose MIPS-compatible
> +	  CPUs. developed at Institute of Computing Technology (ICT),
              ^
              ^ This dot should be removed.

Also you should probably say "Loongson-2/3 is a family...".

A.
