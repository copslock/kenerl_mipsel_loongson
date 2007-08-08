Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Aug 2007 16:10:00 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:965 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20026909AbXHHPJ5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 8 Aug 2007 16:09:57 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l78F9kW7016253;
	Wed, 8 Aug 2007 16:09:46 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l78F9iAC016252;
	Wed, 8 Aug 2007 16:09:44 +0100
Date:	Wed, 8 Aug 2007 16:09:44 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Mohamed Bamakhrama <bamakhrama@gmail.com>
Cc:	"Steven J. Hill" <sjhill@realitydiluted.com>,
	Alex Gonzalez <langabe@gmail.com>,
	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
Subject: Re: Problems with NFS boot
Message-ID: <20070808150944.GB13803@linux-mips.org>
References: <40378e40708080318w7dc0f0b7s4c94c98acd72ec2c@mail.gmail.com> <20070808132116.GB12598@real.realitydiluted.com> <40378e40708080755j79967334i5ef1146b88334c88@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40378e40708080755j79967334i5ef1146b88334c88@mail.gmail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16136
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Aug 08, 2007 at 04:55:42PM +0200, Mohamed Bamakhrama wrote:

> I tried all the different combinations of passing the kernel command
> line arguments but in vain. Moreover, I started a sniffer on the
> server to see if it is able to get the packets from the kernel but it
> turned out that it doesn't recv. anything!

The Malta needs CONFIG_PCNET32 for the network driver which I don't see
in your config.

  Ralf
