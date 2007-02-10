Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Feb 2007 16:16:02 +0000 (GMT)
Received: from mail02.hansenet.de ([213.191.73.62]:35022 "EHLO
	webmail.hansenet.de") by ftp.linux-mips.org with ESMTP
	id S20039020AbXBJQP4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 10 Feb 2007 16:15:56 +0000
Received: from [213.39.184.171] (213.39.184.171) by webmail.hansenet.de (7.2.074) (authenticated as mbx20228207@koeller-hh.org)
        id 45CB2B4F000EC08F; Sat, 10 Feb 2007 17:11:48 +0100
Received: from localhost.koeller.dyndns.org (localhost.koeller.dyndns.org [127.0.0.1])
	by mail.koeller.dyndns.org (Postfix) with ESMTP id 4B2FC479CA;
	Sat, 10 Feb 2007 17:11:47 +0100 (CET)
From:	Thomas Koeller <thomas@koeller.dyndns.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] RM9000 serial driver
Date:	Sat, 10 Feb 2007 17:11:46 +0100
User-Agent: KMail/1.9.6
Cc:	Russell King <rmk@arm.linux.org.uk>, linux-serial@vger.kernel.org,
	ralf@linux-mips.org, linux-mips@linux-mips.org
References: <200608102318.52143.thomas.koeller@baslerweb.com> <20060830121216.GA25699@flint.arm.linux.org.uk> <44F5C1BB.7010205@ru.mvista.com>
In-Reply-To: <44F5C1BB.7010205@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200702101711.46826.thomas@koeller.dyndns.org>
Return-Path: <thomas@koeller.dyndns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14027
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas@koeller.dyndns.org
Precedence: bulk
X-list: linux-mips

On Mittwoch, 30. August 2006, Sergei Shtylyov wrote:
>
> Russell King wrote:
> >>I would like to return to the port type vs. iotype  stuff once again.
> >
> >From what you wrote I seem to understand that the iotype is not just
> >
> >>a method of accessing device registers, but also the primary means of
> >>discrimination between different h/w implementations, and hence every
> >>code to support a nonstandard device must define an iotype of its own,
> >>even though one of the existing iotypes would work just fine?
> >
> > iotype is all about the access method used to access the registers of
> > the device, be it by byte or word, and it also takes account of any
> > variance in the addressing of the registers.
> >
> > It does not refer to features or bugs in any particular implementation.
>
>     Well, the introduction of the UPIO_TSI case seems to contradict this --
> it's exactly about the bugs in the particular UART implementation
> (otherwise well described by UPIO_MEM). Its only function was to mask 2
> hardware issues. And the UUE bit workaround seems like an abuse to me. The
> driver could just skip the UUE test altogether based on iotype == UPIO_TSI
> (or at least not to ignore writes with UUE set completely like it does but
> just mask off UUE bit). With no provision to pass the implicit UART type
> for platform devices (and skip the autoconfiguation), the introduction of
> UPIO_TSI seems again the necessary evil. Otherwise, we could have this
> handled with a distinct TSI UART type...
>
> WBR, Sergei

Hi,

after a long delay (for which I apologize) I would like to return to
this topic. Since so much time has passed since the discussion ceased, I
think I should summarize its state at that point:

1. In the RM9000 serial driver patch I submitted, I had introduced a new
   port type PORT_RM9000. I set the iotype to UPIO_MEM32. Wherever I
   needed to handle any peculiarities of the RM9000 h/w, I did so based
   upon the port type. AFAICT this is in agreement with Russel's view as
   quoted above.

2. Sergei says this is wrong, I need to introduce a new iotype instead,
   and make the code conditional upon that, like the AU1000 does (UPIO_AU).
   The reason he gives (see quote above) is that there is no way to pass
   the port type along with a platform device. Is this argument still valid?
   What about including the port type in the information attached to
   platform_device.platform_data?

Btw., I had a look ath the existing code dealing with platform
devices. Is there a particular reason for not using the standard
platform_device.resource mechanism of passing mem/io/irq resources from
the platform to the driver?

Another topic discussed was the use (or abuse) of dl_serial_read()/
dl_serial_write() to get/set the divisor registers.

3. Russel says (qoute from an earlier mail),
   > It's worse than that - this code is there to read the ID from the divisor
   > registers implemented in some UARTs. If it isn't one of those UARTs,
   > it's expected to return zero.

4. I followed the AU1X00 code in this case, using the functions to read/write
   the divisor value. My hardware has its UART_DLL and UART_DLM registers at
   nonstandard addresses, and so the only other option would have been to
   monitor every write to the LCR register for setting or clearing the DLAB
   bit, and to switch between different mapping tables accordingly. In the
   light of this, would it still be unacceptable to use the dl_*() functions
   tho access the divisor registers?

Once these issues have been resolved, I will submit an updated version of
my patch.

tk

-- 
Thomas Koeller
thomas@koeller.dyndns.org
