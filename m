Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jun 2007 14:54:00 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:31942 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022442AbXFONx6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 15 Jun 2007 14:53:58 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l5FDnm2t009566;
	Fri, 15 Jun 2007 14:50:13 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l5FDnmiL009565;
	Fri, 15 Jun 2007 14:49:48 +0100
Date:	Fri, 15 Jun 2007 14:49:48 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 3/5] Deforest the function pointer jungle in the time
	code.
Message-ID: <20070615134948.GB16133@linux-mips.org>
References: <11818164011355-git-send-email-fbuihuu@gmail.com> <11818164023940-git-send-email-fbuihuu@gmail.com> <20070614111748.GA8223@alpha.franken.de> <cda58cb80706140643g63c3bf34sbd5b843a15653c3d@mail.gmail.com> <Pine.LNX.4.64N.0706141501080.25868@blysk.ds.pg.gda.pl> <cda58cb80706140731j1b6e8e36l96d4423db1ffd9e7@mail.gmail.com> <Pine.LNX.4.64N.0706141648540.25868@blysk.ds.pg.gda.pl> <cda58cb80706150159j5c3d5b7p4293dc529d5ee97c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cda58cb80706150159j5c3d5b7p4293dc529d5ee97c@mail.gmail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15420
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jun 15, 2007 at 10:59:00AM +0200, Franck Bui-Huu wrote:

> > Please note that this generic calibration code may be used for
> >calibrating the CP0 timer too -- all that you need is defining
> 
> Actually the current patchset breaks it since it changes the calibration
> code to be used only for the cp0 hpt calibration. I'll change that.

To many this really fun it also needs to become possible to calibrate
each processor's clock individually - not all MIPS MP systems run their
clocks at the same rate.

  Ralf
