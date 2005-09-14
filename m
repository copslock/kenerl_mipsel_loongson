Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Sep 2005 20:41:17 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:43025 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8224982AbVINTlC>; Wed, 14 Sep 2005 20:41:02 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j8EJeg4A010849;
	Wed, 14 Sep 2005 20:40:42 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j8EJecXV010820;
	Wed, 14 Sep 2005 20:40:39 +0100
Date:	Wed, 14 Sep 2005 20:40:38 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Alexey Dobriyan <adobriyan@gmail.com>
Cc:	Scott Feldman <sfeldma@pobox.com>, netdev@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] gt96100: stop using pci_find_device()
Message-ID: <20050914194038.GP3224@linux-mips.org>
References: <20050914185136.GE19491@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050914185136.GE19491@mipter.zuzino.mipt.ru>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8955
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Sep 14, 2005 at 10:51:37PM +0400, Alexey Dobriyan wrote:

> Replace pci_find_device with pci_get_device/pci_dev_put to plug race
> with pci_find_device.

The system is a little odd; the race condition probably doens't exist on
this particular chipset.

  Ralf
