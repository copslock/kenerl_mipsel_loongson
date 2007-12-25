Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Dec 2007 17:18:54 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:58065 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S28576532AbXLYRSw (ORCPT
	<rfc822;linux-mips@ftp.linux-mips.org>);
	Tue, 25 Dec 2007 17:18:52 +0000
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id ADDAB3EC9; Tue, 25 Dec 2007 09:18:19 -0800 (PST)
Message-ID: <47713B7A.9050102@ru.mvista.com>
Date:	Tue, 25 Dec 2007 20:18:50 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Alon Bar-Lev <alon.barlev@gmail.com>
Cc:	linux-mips@ftp.linux-mips.org, LKML <linux-kernel@vger.kernel.org>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [MIPS] MEM_SDREFCFG is not defined for Alchemy DB1550 (compile
 fail)
References: <9e0cf0bf0712230733o3dfd54fcp4962ebf3f84cdff@mail.gmail.com>	 <4770DE51.5000205@ru.mvista.com> <9e0cf0bf0712250904t213d623bp977db54b6be5e3e@mail.gmail.com>
In-Reply-To: <9e0cf0bf0712250904t213d623bp977db54b6be5e3e@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@ftp.linux-mips.org
Original-Recipient: rfc822;linux-mips@ftp.linux-mips.org
X-archive-position: 17878
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Alon Bar-Lev wrote:

>>    PM code is generally broken and unmaintained, so no wonder. I don't
>>remember if anyone has fixed CPU context restoration code (it uses a "skewed"
>>stack frame).

> So suspend modes on these boards are not supported?
> Only "Always On" configuration is supported?

    Sleep mode is supported according to the code. But as I've said PM bits 
haven't been maintained -- probably since the submission.

> Best Regards,
> Alon Bar-Lev.

WBR, Sergei
