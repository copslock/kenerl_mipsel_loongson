Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Jul 2006 20:24:11 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:33948 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S8133577AbWGBTXz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 2 Jul 2006 20:23:55 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 253B33EC9; Sun,  2 Jul 2006 12:23:29 -0700 (PDT)
Message-ID: <44A81CEF.3010907@ru.mvista.com>
Date:	Sun, 02 Jul 2006 23:22:23 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Rodolfo Giometti <giometti@linux.it>
Cc:	linux-mips@linux-mips.org
Subject: Re: au1000_lowlevel_probe on au1000_eth.c
References: <20060626221441.GA10595@enneenne.com> <20060627155914.GD10595@enneenne.com> <44A3EBD7.8090408@ru.mvista.com> <20060629151130.GM7471@enneenne.com>
In-Reply-To: <20060629151130.GM7471@enneenne.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11900
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Rodolfo Giometti wrote:

>>   Hrm, wouldn't it be better to put this stuff into a separate function 
>>   then?

> Maybe, but I considered that these stuff are dignificative only during
> boot time so I decided to do not consider them during wake up. Is that
> wrong?

    No. And exactly because of this, the __init time stuff should better be 
separated (if possible)...

> Ciao,

> Rodolfo
