Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Oct 2007 20:05:59 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:42313 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S28574399AbXJ2UFu (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 29 Oct 2007 20:05:50 +0000
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 85D0A3ECB; Mon, 29 Oct 2007 13:05:46 -0700 (PDT)
Message-ID: <47263D22.80208@ru.mvista.com>
Date:	Mon, 29 Oct 2007 23:05:54 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Roel Kluin <12o3l@tiscali.nl>, linux-mips@linux-mips.org
Subject: Re: [PATCH] fix post-fence error
References: <47228018.8020202@tiscali.nl> <472328C2.4000002@ru.mvista.com> <47232C2D.8010002@tiscali.nl> <20071029150233.GA4165@linux-mips.org> <4725FDE5.70407@ru.mvista.com> <20071029191807.GA14710@linux-mips.org>
In-Reply-To: <20071029191807.GA14710@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17300
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:

>>   I'm afraid this new patch is wrong...

> Indeed.  Thanks for proofreading, even if after the fact ...

    You were too quick with commit. :-)
    Could also convert all of this construct to a proper kernel style:

         for (i = 0; i < _IRIX_NSIG_BPW; i++)

>   Ralf

WBR, Sergei
