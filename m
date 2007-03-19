Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Mar 2007 14:46:30 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:35775 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20021775AbXCSOqZ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 19 Mar 2007 14:46:25 +0000
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id DA8933ED1; Mon, 19 Mar 2007 07:45:51 -0700 (PDT)
Message-ID: <45FEA214.3000805@ru.mvista.com>
Date:	Mon, 19 Mar 2007 17:45:40 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Marco Braga <marco.braga@gmail.com>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: Au1500 and TI PCI1510 cardbus
References: <d459bb380703161129l769d3f48w744ba0bfdf04fc91@mail.gmail.com>	 <45FBB9C7.9060800@cubic.org>	 <d459bb380703170554l3fb40d60h6f68b70472ad7cb@mail.gmail.com>	 <45FBF0F1.70302@cubic.org>	 <d459bb380703180617i6e50539bx13ad405fb306fe44@mail.gmail.com>	 <45FE83B6.3040100@ru.mvista.com> <d459bb380703190741w3d0bef6fw101c64da8d81d422@mail.gmail.com>
In-Reply-To: <d459bb380703190741w3d0bef6fw101c64da8d81d422@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14554
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Marco Braga wrote:

> Michael sent me a more elaborate answer from AMD. It seems indeed that 
> there
> is no way to make the Cardbus work without locking. I think we'll try 
> better
> luck with USB 2.0. Regarding to this, has anyone had any success with EHCI
> controllers and Au1500?

    Au1500 dosn't support USB 2.0 and therefore EHCI. You may want to use Au1200.

> Thanks!

WBR, Sergei
