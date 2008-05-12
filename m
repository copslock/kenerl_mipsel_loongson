Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 May 2008 15:40:01 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:16721 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20031072AbYELOjy (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 12 May 2008 15:39:54 +0100
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 8BB923EC9; Mon, 12 May 2008 07:39:48 -0700 (PDT)
Message-ID: <48285699.5060700@ru.mvista.com>
Date:	Mon, 12 May 2008 18:39:21 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	abhiruchi.g@vaultinfo.com
Cc:	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
	kernel-testers@vger.kernel.org
Subject: Re: WARNING: arch/mips/au1000/common/built-in.o(.text+0x15c0): Section
 mismatch: reference to .init.data: (between 'au1xxx_platform_init' and '__fixup_bigphys_addr')
References: <54350.192.168.1.71.1210568848.webmail@192.168.1.71>
In-Reply-To: <54350.192.168.1.71.1210568848.webmail@192.168.1.71>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19216
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

abhiruchi.g@vaultinfo.com wrote:

> Hi all,
>   I am trying to configure the kernel for mips(DB1200 bosrd).I am getting this warning.
> how to remove this warning?

> WARNING: arch/mips/au1000/common/built-in.o(.text+0x15c0): Section mismatch: reference to .init.data: (between 'au1xxx_platform_init' and '__fixup_bigphys_addr')
> WARNING: arch/mips/au1000/common/built-in.o(.text+0x15c4): Section mismatch: reference to .init.data: (between 'au1xxx_platform_init' and '__fixup_bigphys_addr

    Which kernel version are you building? I'mnot seeing anything alike.

WBR, Sergei
