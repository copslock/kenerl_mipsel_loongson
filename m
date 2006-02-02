Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Feb 2006 18:38:21 +0000 (GMT)
Received: from rtsoft2.corbina.net ([85.21.88.2]:6335 "HELO mail.dev.rtsoft.ru")
	by ftp.linux-mips.org with SMTP id S3465652AbWBBSh6 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 2 Feb 2006 18:37:58 +0000
Received: (qmail 22599 invoked from network); 2 Feb 2006 18:43:09 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 2 Feb 2006 18:43:09 -0000
Message-ID: <43E25381.4060309@ru.mvista.com>
Date:	Thu, 02 Feb 2006 21:46:25 +0300
From:	Sergei Shtylylov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] TX49 MFC0 bug workaround
References: <20060203.013401.41198517.anemo@mba.ocn.ne.jp>
In-Reply-To: <20060203.013401.41198517.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10314
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Atsushi Nemoto wrote:
> If mfc0 $12 follows store and the mfc0 is last instruction of a
> page and fetching the next instruction causes TLB miss, the result
> of the mfc0 might wrongly contain EXL bit.

    Hmm, a TLB miss in fetching from KSEG0?!

> ERT-TX49H2-027, ERT-TX49H3-012, ERT-TX49HL3-006, ERT-TX49H4-008
> 
> Workaround: mask EXL bit of the result or place a nop before mfc0.

    Is this workaround really needed?

> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

WBR, Sergei
