Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Oct 2004 18:33:36 +0100 (BST)
Received: from puzzle.sasl.smtp.pobox.com ([IPv6:::ffff:207.8.226.4]:35522
	"EHLO sasl.smtp.pobox.com") by linux-mips.org with ESMTP
	id <S8225262AbUJCRdc>; Sun, 3 Oct 2004 18:33:32 +0100
Received: from localhost.localdomain (localhost [127.0.0.1])
	by puzzle.pobox.com (Postfix) with ESMTP
	id 7BE7B138F0A; Sun,  3 Oct 2004 13:33:03 -0400 (EDT)
Received: from [192.168.0.3] (wbar2.sea1-4-5-062-153.sea1.dsl-verizon.net [4.5.62.153])
	by puzzle.pobox.com (Postfix) with ESMTP
	id 28814138F05; Sun,  3 Oct 2004 13:33:02 -0400 (EDT)
Subject: Re: [Kernel-janitors] [PATCH 2/6] janitor: net/gt96100eth:
	pci_find_device to pci_get_device
From: Scott Feldman <sfeldma@pobox.com>
Reply-To: sfeldma@pobox.com
To: Christoph Hellwig <hch@infradead.org>
Cc: kernel-janitors@lists.osdl.org, stevel@mvista.com,
	source@mvista.com, linux-mips@linux-mips.org
In-Reply-To: <20041003092942.A28174@infradead.org>
References: <1096784371.3819.157.camel@sfeldma-mobl2.dsl-verizon.net>
	 <20041003092942.A28174@infradead.org>
Content-Type: text/plain
Message-Id: <1096824809.3818.2.camel@sfeldma-mobl2.dsl-verizon.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 03 Oct 2004 10:33:29 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <sfeldma@pobox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5927
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sfeldma@pobox.com
Precedence: bulk
X-list: linux-mips

On Sun, 2004-10-03 at 01:29, Christoph Hellwig wrote:
> On Sat, Oct 02, 2004 at 11:19:31PM -0700, Scott Feldman wrote:
> > Replace pci_find_device with pci_get_device/pci_dev_put to plug
> > race with pci_find_device.
> 
> Shouldn't this use pci_dev_present?

No, because the dev pointer is needed later in the code if dev was
found.  pci_dev_present doesn't return the dev.

-scott
