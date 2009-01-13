Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jan 2009 17:38:51 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:32544 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S21103555AbZAMRit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 13 Jan 2009 17:38:49 +0000
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 317723EC9; Tue, 13 Jan 2009 09:38:46 -0800 (PST)
Message-ID: <496CD1CB.60805@ru.mvista.com>
Date:	Tue, 13 Jan 2009 20:39:23 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Ihar Hrachyshka <ihar.hrachyshka@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [pnx833x_port]: device name prefix - ttyS or ttySA?
References: <1231859270.25974.32.camel@EPBYMINW0568>
In-Reply-To: <1231859270.25974.32.camel@EPBYMINW0568>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21726
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Ihar Hrachyshka wrote:

> In 'drivers/serial/pnx833x_port.c' we define the prefix for UART serial
> device as "ttyS". Anyway, we use major:minor numbers for SA1100 serial
> driver (that are 204:5).

    Why?

WBR, Sergei
