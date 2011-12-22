Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Dec 2011 13:47:07 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:59729 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903608Ab1LVMrD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 22 Dec 2011 13:47:03 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id pBMCl1U8008892;
        Thu, 22 Dec 2011 12:47:01 GMT
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id pBMCl1GF008890;
        Thu, 22 Dec 2011 12:47:01 GMT
Date:   Thu, 22 Dec 2011 12:47:01 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Harsha Chenji <cjkernel@gmail.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: Power management on ar71xx
Message-ID: <20111222124701.GA7072@linux-mips.org>
References: <CAMB9WxLyQ9kFV96rquZDNL+86hDjtTh=0sydwQWyuUaAzm5dgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMB9WxLyQ9kFV96rquZDNL+86hDjtTh=0sydwQWyuUaAzm5dgA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 32153
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 18048

On Wed, Dec 21, 2011 at 05:25:17PM -0600, Harsha Chenji wrote:

> I was trying to get some power savings working on my AR7161 chipset
> using OpenWRT, but I was unsuccessful.
> 
> Since mips24kc supports the wait instruction, shouldn't sleeping be
> supported too? Is anyone working on this platform currently?

The two things are pretty much unrelated.  The WAIT instruction is used
by the architecture specific code when there is no process available
that could use the CPU.  The power managment code deals with all other
aspects of power saving.  The two don't even know about each other.

  Ralf
