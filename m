Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Mar 2005 10:28:31 +0000 (GMT)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:536 "EHLO
	mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225260AbVCPK2Q>; Wed, 16 Mar 2005 10:28:16 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j2FLtdas027210;
	Tue, 15 Mar 2005 21:55:39 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j2FLtd9i027209;
	Tue, 15 Mar 2005 21:55:39 GMT
Date:	Tue, 15 Mar 2005 21:55:39 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Jim Gifford <maillist@jg555.com>
Cc:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: Current Build Warning Message
Message-ID: <20050315215538.GJ6025@linux-mips.org>
References: <42375617.3020002@jg555.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42375617.3020002@jg555.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7443
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Mar 15, 2005 at 01:39:35PM -0800, Jim Gifford wrote:
> Date:	Tue, 15 Mar 2005 13:39:35 -0800
> From:	Jim Gifford <maillist@jg555.com>
> To:	Linux MIPS List <linux-mips@linux-mips.org>
> Subject: Current Build Warning Message
> Content-Type: text/plain; charset=ISO-8859-1; format=flowed
> 
> I just tried doing a current build on a 2.6.11 systems. I get the 
> following warnings.
> 
> *** Warning: "pci_iounmap" [drivers/net/tulip/tulip.ko] undefined!
> *** Warning: "pci_iomap" [drivers/net/tulip/tulip.ko] undefined!
> 
> Any ideas on how to correct this?

Write pci_iounmap and pci_iomap :-)

(Recently an implementation was posted here but it's been broken as it
only did support a single PCI bus and will fail silently for additional
busses.)

  Ralf
