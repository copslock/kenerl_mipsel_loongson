Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7FAmbS10286
	for linux-mips-outgoing; Wed, 15 Aug 2001 03:48:37 -0700
Received: from dea.waldorf-gmbh.de (u-233-19.karlsruhe.ipdial.viaginterkom.de [62.180.19.233])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7FAmAj10133
	for <linux-mips@oss.sgi.com>; Wed, 15 Aug 2001 03:48:21 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f7F8XET11987;
	Wed, 15 Aug 2001 10:33:14 +0200
Date: Wed, 15 Aug 2001 10:33:14 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: machael thailer <dony.he@huawei.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Virtual address to physical address mapping...
Message-ID: <20010815103314.A11966@bacchus.dhis.org>
References: <000701c12529$e1640580$8021690a@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <000701c12529$e1640580$8021690a@huawei.com>; from dony.he@huawei.com on Wed, Aug 15, 2001 at 09:30:34AM +0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Aug 15, 2001 at 09:30:34AM +0800, machael thailer wrote:

>    I am a newbie on linux-mips. I read the linux-mips sources codes and
> cannot  find where it builds the page tables (from Virtual address to
> physical address mapping).
> Can you point it out to me where I can find it?

It only comes in the commercial edition ;-)

Checkout the mm/ directory which contains most of the generic code.
include/asm-mips/pgtable.h and arch/mips/mm/ contain most of the
MIPS specific code.

  Ralf
