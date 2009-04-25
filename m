Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Apr 2009 09:38:37 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:52623 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20021549AbZDYIie (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 25 Apr 2009 09:38:34 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n3P8cUdt028080;
	Sat, 25 Apr 2009 10:38:31 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n3P8cPIq028075;
	Sat, 25 Apr 2009 10:38:25 +0200
Date:	Sat, 25 Apr 2009 10:38:25 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>,
	Magnus Damm <damm@igel.co.jp>
Subject: Re: [PATCH] Alchemy: time.c build fix
Message-ID: <20090425083825.GA15043@linux-mips.org>
References: <20090422060435.GA20061@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090422060435.GA20061@roarinelk.homelinux.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22477
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Apr 22, 2009 at 08:04:35AM +0200, Manuel Lauss wrote:

> >From c866124136ee90dbf42fbf2bc2a308574fa84576 Mon Sep 17 00:00:00 2001
> From: Manuel Lauss <mano@roarinelk.homelinux.net>
> Date: Wed, 22 Apr 2009 08:01:48 +0200
> Subject: [PATCH] MIPS: Alchemy: timer build fix
> 
> Fix breakage introduced by 8e19608e8b5c001e4a66ce482edc474f05fb7355.
> 
> Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>

Thanks, applied.

  Ralf
