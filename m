Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Jan 2011 14:08:51 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:52232 "EHLO
        duck.linux-mips.net" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491815Ab1AaNIr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 31 Jan 2011 14:08:47 +0100
Received: from duck.linux-mips.net (duck [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p0VD8MDb028729;
        Mon, 31 Jan 2011 14:08:22 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p0VD8Kf7028727;
        Mon, 31 Jan 2011 14:08:20 +0100
Date:   Mon, 31 Jan 2011 14:08:20 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Himanshu Aggarwal <lkml.himanshu@gmail.com>
Cc:     David Daney <ddaney@caviumnetworks.com>,
        naveen yadav <yad.naveen@gmail.com>,
        kernelnewbies@nl.linux.org, linux-mips@linux-mips.org
Subject: Re: page size change on MIPS
Message-ID: <20110131130820.GB26217@linux-mips.org>
References: <AANLkTik+vpiWR4Xk4Pu+uCHq3XO=BZMGVka8-B9vuQew@mail.gmail.com>
 <4D3DCB5A.6060107@caviumnetworks.com>
 <AANLkTin6GkKeJATbafP-k9YNcSTHeT8ohDpUD2RLDZ1J@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AANLkTin6GkKeJATbafP-k9YNcSTHeT8ohDpUD2RLDZ1J@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@localhost.localdomain>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29117
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Jan 30, 2011 at 08:32:43PM +0530, Himanshu Aggarwal wrote:

> Why should the application or the toolchains depend on pagesize? I am
> not very clear on this. Can someone explain it?

To allow loading directly with mmap the executable file's layout must
be such that it's it's segments are on offsets that are a multiple of
the page size so in turn the linker must know that alignment.

  Ralf
