Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Apr 2007 09:41:57 +0100 (BST)
Received: from gecko.sbs.de ([194.138.37.40]:15951 "EHLO gecko.sbs.de")
	by ftp.linux-mips.org with ESMTP id S20021616AbXD0Ilz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 27 Apr 2007 09:41:55 +0100
Received: from mail2.sbs.de (localhost [127.0.0.1])
	by gecko.sbs.de (8.12.6/8.12.6) with ESMTP id l3R8fnAT026886;
	Fri, 27 Apr 2007 10:41:49 +0200
Received: from fthw9xoa.ww002.siemens.net (fthw9xoa.ww002.siemens.net [157.163.133.201])
	by mail2.sbs.de (8.12.6/8.12.6) with ESMTP id l3R8fmxJ019684;
	Fri, 27 Apr 2007 10:41:48 +0200
Received: from stgw002a.ww002.siemens.net ([141.73.158.150]) by fthw9xoa.ww002.siemens.net with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 27 Apr 2007 10:41:48 +0200
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: pcmcia - failed to initialize IDE interface
Date:	Fri, 27 Apr 2007 10:42:31 +0200
Message-ID: <D7810733513F4840B4EBAAFA64D9C6A401307AC9@stgw002a.ww002.siemens.net>
In-Reply-To: <D7810733513F4840B4EBAAFA64D9C6A401307A69@stgw002a.ww002.siemens.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: pcmcia - failed to initialize IDE interface
Thread-Index: AceHqEmPYMhqH9+RSm+Ie3xgpMcxxgA9vZhwAAIIYDA=
From:	"Aeschbacher, Fabrice" <Fabrice.Aeschbacher@siemens.com>
To:	<linux-mips@linux-mips.org>
Cc:	<linux-pcmcia@lists.infradead.org>,
	"lkml" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 27 Apr 2007 08:41:48.0655 (UTC) FILETIME=[E5049FF0:01C788A7]
Return-Path: <Fabrice.Aeschbacher@siemens.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14923
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Fabrice.Aeschbacher@siemens.com
Precedence: bulk
X-list: linux-mips

> Which would be the correct way to make pcmcia_request_irq() 
> use the correct value of 40?

This is in drivers/pcmcia/au1000_db1x00.c:

db1x00_pcmcia_hw_init():

	skt->irq = AU1000_GPIO_8;  /* = 40 */

Now the CF is working fine.

Fabrice
