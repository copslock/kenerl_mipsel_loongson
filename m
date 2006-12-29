Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Dec 2006 16:29:56 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:57833 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S28574966AbWL2Q3w (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 29 Dec 2006 16:29:52 +0000
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id F3A603EC9; Fri, 29 Dec 2006 08:29:28 -0800 (PST)
Message-ID: <45954261.9060502@ru.mvista.com>
Date:	Fri, 29 Dec 2006 19:29:21 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Manish Regmi <regmi.manish@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Linux latest kernel and Tosiba rbtx 4939 support
References: <652016d30612282134x4d16670fge82825356a091844@mail.gmail.com>
In-Reply-To: <652016d30612282134x4d16670fge82825356a091844@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13529
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Manish Regmi wrote:

>   Is tosiba rbtx 4939 supported in the latest Linux kernel?

    Yes but not completely (for examle, only 1 of 2 PCI busses is currently 
supported).

> I tried 2.6.19 and even 2.6.20-rc2 but i could not find support for that 
> board.

    How do you think what's in arch/mips/tx4938/toshiba_rbtx4938/ ?

> is it safe to use rbtx4938 support in rbtx4938?

    Well, at least it used to be. I was able to boot it before 2.6.19.

> Thanks in advance.

> PS: please cc me i am not subscribed to this list.

WBR, Sergei
