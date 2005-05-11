Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 May 2005 15:06:21 +0100 (BST)
Received: from [IPv6:::ffff:81.2.110.250] ([IPv6:::ffff:81.2.110.250]:42683
	"EHLO lxorguk.ukuu.org.uk") by linux-mips.org with ESMTP
	id <S8225847AbVEKOGG>; Wed, 11 May 2005 15:06:06 +0100
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.12.11/8.12.11) with ESMTP id j4BE4fEj010515;
	Wed, 11 May 2005 15:04:41 +0100
Received: (from alan@localhost)
	by localhost.localdomain (8.12.11/8.12.11/Submit) id j4BE4dxn010514;
	Wed, 11 May 2005 15:04:40 +0100
X-Authentication-Warning: localhost.localdomain: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: CompactFlash/ATA on Au1100 misses interrupts
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <200505111434.39601.eckhardt@satorlaser.com>
References: <200505111434.39601.eckhardt@satorlaser.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1115820274.26693.246.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date:	Wed, 11 May 2005 15:04:35 +0100
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7904
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Mer, 2005-05-11 at 13:34, Ulrich Eckhardt wrote:
> Another thing I was wondering about is the boot message that it's "Assuming 
> 50MHz system bus speed". Can/should I specify this differently?

That is only used for a few obscure old controllers so should be
irrelevant. 
