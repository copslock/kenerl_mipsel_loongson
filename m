Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Nov 2002 05:13:53 +0100 (CET)
Received: from pizda.ninka.net ([216.101.162.242]:11467 "EHLO pizda.ninka.net")
	by linux-mips.org with ESMTP id <S1122118AbSKNENw>;
	Thu, 14 Nov 2002 05:13:52 +0100
Received: from localhost (IDENT:davem@localhost.localdomain [127.0.0.1])
	by pizda.ninka.net (8.9.3/8.9.3) with ESMTP id UAA10224;
	Wed, 13 Nov 2002 20:11:56 -0800
Date: Wed, 13 Nov 2002 20:11:55 -0800 (PST)
Message-Id: <20021113.201155.106013477.davem@redhat.com>
To: carstenl@mips.com
Cc: jgarzik@pobox.com, ralf@linux-mips.org, linux-mips@linux-mips.org,
	tsbogend@alpha.franken.de, linux-net@vger.kernel.org,
	kevink@mips.com
Subject: Re: BUG in the PCNET32 ethernet driver
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3DD2B128.62DFB392@mips.com>
References: <3DD254F8.14DE20EA@mips.com>
	<3DD280FB.7070907@pobox.com>
	<3DD2B128.62DFB392@mips.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <davem@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 637
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@redhat.com
Precedence: bulk
X-list: linux-mips

   From: Carsten Langgaard <carstenl@mips.com>
   Date: Wed, 13 Nov 2002 21:08:08 +0100

   Jeff Garzik wrote:
   
   > Why does this line not reference PKT_BUF_SZ when all the others do?
   
   In this case we know the size of the packet and therefore only need to handle that.
   In the other cases we don't know have big the receiving packet is going to be, so we has to
   take care of the whole buffer.

When you unmap a DMA buffer, which is a resource so this is just like
freeing memory, you must specify the exact size you used when creating
the mapping to begin with.

Franks a lot,
David S. Miller
davem@redhat.com
