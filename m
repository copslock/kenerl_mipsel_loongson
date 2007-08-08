Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Aug 2007 11:21:27 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:36818 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20026861AbXHHKVZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 8 Aug 2007 11:21:25 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l78ALCJt005692;
	Wed, 8 Aug 2007 11:21:14 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l78ALBT9005691;
	Wed, 8 Aug 2007 11:21:11 +0100
Date:	Wed, 8 Aug 2007 11:21:11 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Mohamed Bamakhrama <bamakhrama@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: ELF to S-Record convertor
Message-ID: <20070808102111.GA5622@linux-mips.org>
References: <40378e40708070832g1aa613fcg7e486d0d778bb84f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40378e40708070832g1aa613fcg7e486d0d778bb84f@mail.gmail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16124
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Aug 07, 2007 at 05:32:00PM +0200, Mohamed Bamakhrama wrote:

> Does anyone know of any open source tool for converting ELF images to
> S-Record images?
> I am using Malta board with MIPS32 core.

The default for malta is to generate an SREC bootfile in
arch/mips/boot/vmlinux.srec.

  Ralf
