Received:  by oss.sgi.com id <S42446AbQIFVOa>;
	Wed, 6 Sep 2000 14:14:30 -0700
Received: from u-48.karlsruhe.ipdial.viaginterkom.de ([62.180.20.48]:27652
        "EHLO u-48.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42444AbQIFVOW>; Wed, 6 Sep 2000 14:14:22 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S868997AbQIFIx3>;
        Wed, 6 Sep 2000 10:53:29 +0200
Date:   Wed, 6 Sep 2000 10:53:29 +0200
From:   Ralf Baechle <ralf@uni-koblenz.de>
To:     Rabeeh Khoury <rabeeh@galileo.co.il>
Cc:     linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: Re: modules in kernel 2.2.14
Message-ID: <20000906105329.B1246@bacchus.dhis.org>
References: <39B53DF0.80BE4104@galileo.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <39B53DF0.80BE4104@galileo.co.il>; from rabeeh@galileo.co.il on Tue, Sep 05, 2000 at 02:39:44PM -0400
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Sep 05, 2000 at 02:39:44PM -0400, Rabeeh Khoury wrote:

> module.o: unresolved symbol _gp_disp
> 
> Where this symbol missing, in the kernel or in the module ??!!

Nowhere - there should be no reference to it.

> Did any one encounter this kind of problem ? or have any alternative
> solution ?

Compile your module with the same flags as the kernel, especially use
-fno-pic -mno-abicalls.

  Ralf
