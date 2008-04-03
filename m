Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Apr 2008 18:57:16 +0200 (CEST)
Received: from h155.mvista.com ([63.81.120.155]:64450 "EHLO imap.sh.mvista.com")
	by lappi.linux-mips.net with ESMTP id S533777AbYDCPqq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 3 Apr 2008 17:46:46 +0200
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 0FE1B3EC9; Thu,  3 Apr 2008 08:46:13 -0700 (PDT)
Message-ID: <47F4FB9A.6070005@ru.mvista.com>
Date:	Thu, 03 Apr 2008 19:45:30 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] PbAu1200: fix header breakage
References: <200804022353.19379.sshtylyov@ru.mvista.com>
In-Reply-To: <200804022353.19379.sshtylyov@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18784
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello, I wrote:

> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

    Er, the boards are called Pb1x00, not PbAu1x00, so Ralf please change the 
summary before comitting (if you feel inclined :-).
    (Luckily, DBAu1200 uses its own header, so it wasn't hurt by this error.)

WBR, Sergei
