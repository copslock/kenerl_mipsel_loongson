Received:  by oss.sgi.com id <S42208AbQF2VUR>;
	Thu, 29 Jun 2000 14:20:17 -0700
Received: from u-241.karlsruhe.ipdial.viaginterkom.de ([62.180.10.241]:37638
        "EHLO u-241.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42202AbQF2VUE>; Thu, 29 Jun 2000 14:20:04 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S1405589AbQF2NSz>;
        Thu, 29 Jun 2000 15:18:55 +0200
Date:   Thu, 29 Jun 2000 15:18:55 +0200
From:   Ralf Baechle <ralf@uni-koblenz.de>
To:     Daniel BROCARD <daniel.brocard@xcom-mc.fr>
Cc:     linux-mips@oss.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: Linux port on R3000
Message-ID: <20000629151855.B15084@bacchus.dhis.org>
References: <395AFC1D.BF3EB1D2@xcom-mc.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <395AFC1D.BF3EB1D2@xcom-mc.fr>; from daniel.brocard@xcom-mc.fr on Thu, Jun 29, 2000 at 09:34:53AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, Jun 29, 2000 at 09:34:53AM +0200, Daniel BROCARD wrote:

> your Linux/MIPS FAQ is dated of 26 janv 98 so,

Wrong FAQ error.  See http://oss.sgi.com/mips/mips-howto.html.

> I'd like know the status of any R3000 port and pointers related on.
> 
> Our hardware platform is based on LSI logic SC2000 chip.
> This chip is used for DVB/MPEG decoding and  the core is a TinyRISC
> EZ4102 a "flavor" of R3000 (big endian) BUT without MMU.

No TLB, no (real) Linux.

  Ralf
