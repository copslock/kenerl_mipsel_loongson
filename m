Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jul 2007 16:29:27 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:25701 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20021593AbXGKP3Z (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 11 Jul 2007 16:29:25 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id B93EB3EC9; Wed, 11 Jul 2007 08:29:22 -0700 (PDT)
Message-ID: <4694F7CD.8040606@ru.mvista.com>
Date:	Wed, 11 Jul 2007 19:31:25 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	Songmao Tian <tiansm@lemote.com>, linuxbios@linuxbios.org,
	marc.jones@amd.com, linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: about cs5536 interrupt ack
References: <4694A495.1050006@lemote.com> <4694F5B8.50009@ru.mvista.com>
In-Reply-To: <4694F5B8.50009@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15698
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello, I wrote:

>> it's a problem that my northbridge didn't implement that! Fortunately 
>> we use a fpga as a northbridge.

>    Wait, CS5536 is a nortbridge itself!

    Apparently, it's only a south bridge. I must've mixed it with Geode itself.

WBR, Sergei
