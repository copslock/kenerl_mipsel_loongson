Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 May 2010 20:02:20 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:37458 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491985Ab0ENSCP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 14 May 2010 20:02:15 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o4EI2BYi007574;
        Fri, 14 May 2010 19:02:13 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o4EI2B8L007572;
        Fri, 14 May 2010 19:02:11 +0100
Date:   Fri, 14 May 2010 19:02:11 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Yang Shi <yang.shi@windriver.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [Bug report] Got bus error when loading kernel module on SB1250
 Rev B2 board with 64 bit kernel
Message-ID: <20100514180211.GB32203@linux-mips.org>
References: <4BED25F3.4010809@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4BED25F3.4010809@windriver.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26723
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, May 14, 2010 at 06:29:07PM +0800, Yang Shi wrote:

> I'm running 2.6.34-rc7 mainline kernel on SB1250 (Rev B2) board. And, I
> use the default sb1250 kernel config (sb1250-swarm_defconfig). So, 64
> bit kernel is used. During kernel loading module got bus error, see
> below log:

Whops.  Fixes which were supposed to handle exactly this problem went
upstream for 2.6.34-rc3 and were tested successfully by others on their
systems.

I wonder if in arch/mips/sibyte/sb1250/setup.c you can instrument
the function sb1250_m3_workaround_needed() and print the values of
soc_type, soc_pass and the retun value of that function.  Then let's take
it from there.

  Ralf
