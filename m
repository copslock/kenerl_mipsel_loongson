Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Aug 2006 18:59:52 +0100 (BST)
Received: from buzzloop.caiaq.de ([212.112.241.133]:64519 "EHLO
	buzzloop.caiaq.de") by ftp.linux-mips.org with ESMTP
	id S20039481AbWH2R7r (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 29 Aug 2006 18:59:47 +0100
Received: from localhost (localhost [127.0.0.1])
	by buzzloop.caiaq.de (Postfix) with ESMTP id CD5EB7F4039;
	Tue, 29 Aug 2006 19:59:43 +0200 (CEST)
Received: from buzzloop.caiaq.de ([127.0.0.1])
	by localhost (buzzloop [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 28201-09; Tue, 29 Aug 2006 19:59:43 +0200 (CEST)
Received: from [192.168.1.140] (port-83-236-238-37.static.qsc.de [83.236.238.37])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by buzzloop.caiaq.de (Postfix) with ESMTP id 491E47F4024;
	Tue, 29 Aug 2006 19:59:43 +0200 (CEST)
In-Reply-To: <20060804082736.GX31105@domen.ultra.si>
References: <2F5D781B-2119-4942-82C1-70B5037F5622@caiaq.de> <20060714161128.GB15427@linux-mips.org> <20060715005747.GA21358@ipxXXXXX> <20060715043941.GA3587@linux-mips.org> <20060715091614.GB21737@ipxXXXXX> <20060727023204.GA28793@ipxXXXXX> <20060804082736.GX31105@domen.ultra.si>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4A12CAB6-0237-498D-A1D3-A9DFD4BD50F1@caiaq.de>
Cc:	linux-mips@linux-mips.org, Domen Puncer <domen.puncer@ultra.si>
Content-Transfer-Encoding: 7bit
From:	Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH] fix irq_chip struct for Pb1200/Db1200 platform
Date:	Tue, 29 Aug 2006 19:59:39 +0200
To:	Ralf Baechle <ralf@linux-mips.org>
X-Mailer: Apple Mail (2.752.2)
Return-Path: <daniel@caiaq.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12468
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel@caiaq.de
Precedence: bulk
X-list: linux-mips

Hi,

On Aug 4, 2006, at 10:27 AM, Domen Puncer wrote:

>> http://caiaq.org/linux-mips/patches/irq_chip_pb1200.patch
>
> Ralf, can you please apply this.
> We don't want 2.6.18 greeting pb1200/db1200 users with an oops, do we?

Is there any change to get this into 2.6.18?

> It applies and works here. Thanks!

Greets,
Daniel
