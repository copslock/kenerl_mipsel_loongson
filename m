Received:  by oss.sgi.com id <S42252AbQJKWnc>;
	Wed, 11 Oct 2000 15:43:32 -0700
Received: from u-252.karlsruhe.ipdial.viaginterkom.de ([62.180.18.252]:6663
        "EHLO u-252.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42249AbQJKWnF>; Wed, 11 Oct 2000 15:43:05 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S870103AbQJKPbR>;
        Wed, 11 Oct 2000 17:31:17 +0200
Date:   Wed, 11 Oct 2000 17:31:17 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Cort Dougan <cort@fsmlabs.com>
Cc:     linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: Re: modutils bug?  'if' clause executes incorrectly
Message-ID: <20001011173117.D19105@bacchus.dhis.org>
References: <20001010224317.I733@hq.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001010224317.I733@hq.fsmlabs.com>; from cort@fsmlabs.com on Tue, Oct 10, 2000 at 10:43:17PM -0600
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Oct 10, 2000 at 10:43:17PM -0600, Cort Dougan wrote:

> This is with GCC version egcs-2.90.29 980515 (egcs-1.0.3 release) and
> binutils 2.8.1 (with BFD 2.8.1).
> 
> The asm in this routine looks good and I can keep the code from failing by
> removing the request_irq() and replacing it with something else that
> doesn't call into the kernel.  I can't reproduce this in user-code or in
> kernel code.
> 
> Does anyone have any suggestions?  Perhaps a suggestion for modutils
> version?

I have an idea what's going wrong, maybe it's related to something that
Brady Brown recently discovered.  Are the object files you are trying to
load generated by the assembler?  If so, try to do a relocatable link
on them with ld -r module-out.o module-in.o.

  Ralf
