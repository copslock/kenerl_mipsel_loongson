Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Dec 2006 13:53:06 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:20357 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20039152AbWLGNxC (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 7 Dec 2006 13:53:02 +0000
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 663873EC9; Thu,  7 Dec 2006 05:52:59 -0800 (PST)
Message-ID: <45781D1C.40805@ru.mvista.com>
Date:	Thu, 07 Dec 2006 16:54:36 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Alexander Voropay <a.voropay@orange-ftgroup.ru>
Cc:	linux-mips@linux-mips.org
Subject: Re: [MIPS] Import updates from i386's i8259.c
References: <S20037871AbWLFUPw/20061206201552Z+14601@ftp.linux-mips.org> <20061207094639.GA30260@lst.de> <385101c719fa$80448100$e90d11ac@spb.in.rosprint.ru>
In-Reply-To: <385101c719fa$80448100$e90d11ac@spb.in.rosprint.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13398
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Alexander Voropay wrote:

>>> Import many updates from i386's i8259.c, especially genirq transitions.

>> Shouldn't we try to share i8259.c over the various architectures that
>> use this controller?  With the generic hardirq framework that should be
>> possible.

> The "i8259" should be under "ISA" or "EISA" Kconfig option.

    It's not really bus specific actually. I'm sure MCA systems had it as well.

> -- 
> -=AV=-

WBR, Sergei
