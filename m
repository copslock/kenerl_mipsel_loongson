Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jan 2006 22:32:13 +0000 (GMT)
Received: from [62.38.115.213] ([62.38.115.213]:60569 "EHLO pfn3.pefnos")
	by ftp.linux-mips.org with ESMTP id S8133643AbWARWb4 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 18 Jan 2006 22:31:56 +0000
Received: from xorhgos2.pefnos (xorhgos2.pefnos [192.168.0.3])
	by pfn3.pefnos (Postfix) with ESMTP id E8F5F1F31B;
	Thu, 19 Jan 2006 00:35:34 +0200 (EET)
From:	"P. Christeas" <p_christ@hol.gr>
To:	David Daney <ddaney@avtrex.com>
Subject: Re: gcc -3.4.4 and linux-2.4.32
Date:	Thu, 19 Jan 2006 00:35:17 +0200
User-Agent: KMail/1.9
Cc:	Kishore K <hellokishore@gmail.com>, linux-mips@linux-mips.org
References: <f07e6e0601160423h5ce1c0d7lcb7e38f8509c4116@mail.gmail.com> <43CBD91B.4020607@avtrex.com> <200601171426.10317.p_christ@hol.gr>
In-Reply-To: <200601171426.10317.p_christ@hol.gr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601190035.19022.p_christ@hol.gr>
Return-Path: <p_christ@hol.gr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9972
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: p_christ@hol.gr
Precedence: bulk
X-list: linux-mips

On Tuesday 17 January 2006 2:26 pm, P. Christeas wrote:

>
> Does that apply to gcc-4.0.2 as well? It is mentioned in linux
> documentation that -funit-at-a-time is safe as of gcc-4.x. Is there (I'm
> not a MIPS expert) a way to verify whether gcc produces wrong instructions?
> I've had a similar problem (I only try with gcc 4, because I compile linux
> 2.6) and is reduced when I use -fno-unit-at-a-time. Still, I have
> instability, which now appears less often.
> I've tried the '-fno-unit-at-a-time' solution (for the whole kernel) and
> the 'pop/push' at interrupt.h fix.
>
Just to let you know:
In a very interesting twist, gcc4.0.2 produces a faulty kernel with the 2.4.31 
kernel (as the latter is provided from the hardware's manufacturer).
I'm validating gcc and binutils at the moment.
