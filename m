Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jul 2007 18:42:19 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:58557 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20023031AbXGTRmR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 20 Jul 2007 18:42:17 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id E396C3EC9; Fri, 20 Jul 2007 10:41:42 -0700 (PDT)
Message-ID: <46A0F453.60005@ru.mvista.com>
Date:	Fri, 20 Jul 2007 21:43:47 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Christoph Hellwig <hch@infradead.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org,
	"James E.J. Bottomley" <James.Bottomley@SteelEye.com>,
	linux-scsi@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [patch 3/3] scsi: wd33c93 needs <asm/irq.h>
References: <20070720164043.523003359@mail.of.borg> <20070720164324.097994947@mail.of.borg> <20070720173132.GB19424@linux-mips.org> <20070720173359.GA22423@infradead.org>
In-Reply-To: <20070720173359.GA22423@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15838
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello Christoph:

>>>+#include <asm/irq.h>

>>These days that should probably be <linux/irq.h>.

> Not at all, linux/irq.h is something entirely different.

    Actually, <linux/interrupt.h>

WBR, Sergei
