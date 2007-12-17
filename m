Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Dec 2007 19:53:52 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:18154 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20022366AbXLQTxn (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 17 Dec 2007 19:53:43 +0000
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 145153EC9; Mon, 17 Dec 2007 11:53:11 -0800 (PST)
Message-ID: <4766D3BE.7070509@ru.mvista.com>
Date:	Mon, 17 Dec 2007 22:53:34 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Joe Perches <joe@perches.com>
Cc:	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] include/asm-mips/: Spelling fixes
References: <1197919875-5288-10-git-send-email-joe@perches.com>
In-Reply-To: <1197919875-5288-10-git-send-email-joe@perches.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17838
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Joe Perches wrote:

> Signed-off-by: Joe Perches <joe@perches.com>

> diff --git a/include/asm-mips/mach-wrppmc/mach-gt64120.h b/include/asm-mips/mach-wrppmc/mach-gt64120.h
> index 00d8bf6..465234a 100644
> --- a/include/asm-mips/mach-wrppmc/mach-gt64120.h
> +++ b/include/asm-mips/mach-wrppmc/mach-gt64120.h
> @@ -45,7 +45,7 @@
>  #define GT_PCI_IO_SIZE	0x02000000UL
>  
>  /*
> - * PCI interrupts will come in on either the INTA or INTD interrups lines,
> + * PCI interrupts will come in on either the INTA or INTD interrupts lines,

    "interrupt" here.

WBR, Sergei
