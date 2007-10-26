Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Oct 2007 12:56:26 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:47837 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20027258AbXJZL4R (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 26 Oct 2007 12:56:17 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id A0D653EC9; Fri, 26 Oct 2007 04:56:12 -0700 (PDT)
Message-ID: <4721D5E6.4010107@ru.mvista.com>
Date:	Fri, 26 Oct 2007 15:56:22 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: 2.6.24-rc1: au1xxx and clocksource
References: <20071024183135.GA23096@roarinelk.homelinux.net> <20071025175914.GB27616@linux-mips.org> <20071026061835.GA1267@roarinelk.homelinux.net> <20071026112455.GA2792@roarinelk.homelinux.net>
In-Reply-To: <20071026112455.GA2792@roarinelk.homelinux.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17244
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Manuel Lauss wrote:

> Setting mips_hpt_frequency to processor speed gives me a booting kernel.

    I thought it's done in arch/mips/au1000/common/time.c...

> Sorry for the noise!

WBR, Sergei
