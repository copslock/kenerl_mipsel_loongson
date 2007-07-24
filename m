Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jul 2007 17:58:29 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:54838 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20023120AbXGXQ61 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 24 Jul 2007 17:58:27 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 04D713EC9; Tue, 24 Jul 2007 09:58:24 -0700 (PDT)
Message-ID: <46A6302A.5010105@ru.mvista.com>
Date:	Tue, 24 Jul 2007 21:00:26 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] tx49xx: add some mach specific headers
References: <20070725.015008.78730579.anemo@mba.ocn.ne.jp>
In-Reply-To: <20070725.015008.78730579.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15891
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Atsushi Nemoto wrote:

> diff --git a/include/asm-mips/mach-tx49xx/cpu-feature-overrides.h b/include/asm-mips/mach-tx49xx/cpu-feature-overrides.h
> new file mode 100644
> index 0000000..275eaf9
> --- /dev/null
> +++ b/include/asm-mips/mach-tx49xx/cpu-feature-overrides.h
> @@ -0,0 +1,23 @@
[...]
> +#define cpu_has_mips32r1	0
> +#define cpu_has_mips32r2	0
> +#define cpu_has_mips64r1	0
> +#define cpu_has_mips64r2	0

    Hm, really?

> +
> +#endif /* __ASM_MACH_TX49XX_CPU_FEATURE_OVERRIDES_H */

MBR, Sergei
