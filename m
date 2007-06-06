Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jun 2007 20:03:42 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:53380 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20027110AbXFFTDk (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 6 Jun 2007 20:03:40 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id C561A3EC9; Wed,  6 Jun 2007 12:03:07 -0700 (PDT)
Message-ID: <46670559.4000907@ru.mvista.com>
Date:	Wed, 06 Jun 2007 23:04:57 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: Tickless/dyntick kernel, highres timer and general time crapectomy
References: <20070606185450.GA10511@linux-mips.org>
In-Reply-To: <20070606185450.GA10511@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15310
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Ralf Baechle wrote:
> Particularly Alchemy (and any other system supporting clock scaling) will
> need some work there since the cp0 count/compare timer are not useful on
> such systems.

    Hm, why it's being used then? :-)

>   Ralf

WBR, Sergei
