Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 Oct 2004 19:17:57 +0000 (GMT)
Received: from quechua.inka.de ([IPv6:::ffff:193.197.184.2]:16618 "EHLO
	mail.inka.de") by linux-mips.org with ESMTP id <S8225200AbUJaTRx>;
	Sun, 31 Oct 2004 19:17:53 +0000
Received: from pcde.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1COLD6-0007bz-00; Sun, 31 Oct 2004 20:17:52 +0100
Received: by aton.pcde.inka.de (Postfix, from userid 1001)
	id EBF721E5C7; Sun, 31 Oct 2004 20:16:31 +0100 (CET)
Date: Sun, 31 Oct 2004 20:16:31 +0100
From: Dennis Grevenstein <dennis@pcde.inka.de>
To: linux-mips@linux-mips.org
Subject: Re: unable to handle kernel paging request
Message-ID: <20041031191631.GB11681@aton.pcde.inka.de>
References: <20041031184233.GA11120@aton.pcde.inka.de> <Pine.GSO.4.10.10410311947570.9753-100000@helios.et.put.poznan.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.10.10410311947570.9753-100000@helios.et.put.poznan.pl>
User-Agent: Mutt/1.4.2.1i
Return-Path: <dennis@pcde.inka.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6233
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dennis@pcde.inka.de
Precedence: bulk
X-list: linux-mips

On Sun, Oct 31, 2004 at 07:48:15PM +0100, Stanislaw Skowronek wrote:
> > <1>CPU 0 Unable to handle kernel paging request at\
> >  virtual address 00000000, epc == 8810da1c, ra == 8810e22c
> 
> Look into your System.map and tell us what is there.
 
At 8810da1c or 8810e22c? Nothing directly.
Closest thing is this:

8810d9b0 t ip22zilog_maybe_update_regs
8810d9fc t ip22zilog_receive_chars
8810dd18 t ip22zilog_status_handle
8810def0 t ip22zilog_transmit_chars
8810e0e0 t ip22zilog_interrupt
8810e26c t ip22zilog_tx_empty
8810e2e4 t ip22zilog_get_mctrl
8810e378 t ip22zilog_set_mctrl  
8810e3e0 t ip22zilog_stop_tx   
8810e3f0 t ip22zilog_start_tx
8810e508 t ip22zilog_stop_rx     
8810e544 t ip22zilog_enable_ms
8810e580 t ip22zilog_break_ctl
8810e628 t __ip22zilog_startup

mfg
Dennis

-- 
There is certainly no purpose in remaining in the dark
except long enough to clear from the mind
the illusion of ever having been in the light.
                                        T.S. Eliot
