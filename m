Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Dec 2009 14:10:40 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:47902 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1493836AbZLGNKh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 7 Dec 2009 14:10:37 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nB7DAZaO021002;
        Mon, 7 Dec 2009 13:10:35 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nB7DAYjv021000;
        Mon, 7 Dec 2009 13:10:34 GMT
Date:   Mon, 7 Dec 2009 13:10:34 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Dennis.Yxun" <dennis.yxun@gmail.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: Question: about Physical Address mapping
Message-ID: <20091207131034.GA5119@linux-mips.org>
References: <7b09df4c0912062339g418f432cr28d92c18ed273d2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b09df4c0912062339g418f432cr28d92c18ed273d2@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25349
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Dec 07, 2009 at 03:39:15PM +0800, Dennis.Yxun wrote:

> HI ALL:
>    I have a problem, that our MIPS hardware put registers location from
> 0x7000,0000 -0x7040,0000.
> So, I need to init TLB to access those registers.
>    My question is: can I map those range to Kseg2 (mapped,uncached)? I found
> "add_wired_entry" sit in
> kernel code, seems I should use this function.
> 
>    I found code in arch/mips/jazz/irq.c, and the comment tells me
> /* Map 0xe4000000 -> 0x0:600005C0, 0xe4100000 -> 400005C0 */
>    add_wired_entry(0x01800017, 0x01000017, 0xe4000000, PM_4M);
> 
> does that mean after add_wired_entry, virtual address 0xe400,0000 map to
> physical address 0x600005C0?
> why the address is 0x6000,05C0, not 0x6000,0000

I probably knew 15 years ago when I wrote this code :)

add_wired_entry() is a very awkard API and its use in the Jazz code is
broken so I suggest you use ioremap() instead.

  Ralf
