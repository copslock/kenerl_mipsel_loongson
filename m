Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 May 2004 00:34:59 +0100 (BST)
Received: from p508B6CA9.dip.t-dialin.net ([IPv6:::ffff:80.139.108.169]:44053
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225978AbUEMXe6>; Fri, 14 May 2004 00:34:58 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i4DNYJxT028314;
	Fri, 14 May 2004 01:34:19 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i4DNXwuD028312;
	Fri, 14 May 2004 01:33:58 +0200
Date: Fri, 14 May 2004 01:33:58 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Rujinschi Remus <deltha@analog.ro>
Cc: uclinux-dev@uclinux.org, linux-mips@linux-mips.org
Subject: Re: MSP2000-CB-A1
Message-ID: <20040513233358.GA26740@linux-mips.org>
References: <1972157758.20040513214403@analog.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1972157758.20040513214403@analog.ro>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4998
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, May 13, 2004 at 09:44:03PM +0300, Rujinschi Remus wrote:

>         Is there any attempt to port linux to Brecis MSP2000 MIPS32 4km
>         based SoC? Does anyone wanna provide any hint using
>         uClinux on it binutils gcc gdb, bootloader, drivers?
>         Is it a success using target=mipsisa32-elf as crosscompile
>         option?

No.  You'll need a mips-linux compiler configuration.

>  Template? Anything which not implies BRECIS proprietary licence?

  Ralf
