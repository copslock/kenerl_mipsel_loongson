Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Dec 2009 18:19:33 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:48966 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1493472AbZLBRTa (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 2 Dec 2009 18:19:30 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nB2HJSu5000373;
        Wed, 2 Dec 2009 17:19:28 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nB2HJRuK000371;
        Wed, 2 Dec 2009 17:19:27 GMT
Date:   Wed, 2 Dec 2009 17:19:27 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Ales Mulej <Ales.Mulej@HSTX.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: Reserved instruction in kernel code
Message-ID: <20091202171927.GB13441@linux-mips.org>
References: <C5BD21D6E1A3114C8765C8FBBD0087BA330A85@exchtxuk2.HSTX.global.vpn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C5BD21D6E1A3114C8765C8FBBD0087BA330A85@exchtxuk2.HSTX.global.vpn>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25278
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Dec 02, 2009 at 11:15:06AM -0000, Ales Mulej wrote:

> 
> I'm porting linux(2.6.31.6) to the Wintegra WINHDP2 refrence board.
> 
> As a refrence I already have an old BSP from Wintegra based on kernel
> 2.6.10.
> 
>  
> 
> During the kernel start up process I receive following error:
> 
>  
> 
> Reserved instruction in kernel code[#1]:

The CPU is taking an exception because of an instruction it doesn't know.
One reason for this might be an incorrect CPU type setting in the kernel
configuration resulting in the generation of such code.

  Ralf
