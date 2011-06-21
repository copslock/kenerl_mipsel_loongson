Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Jun 2011 18:38:25 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:58525 "EHLO duck.linux-mips.net"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491158Ab1FUQiU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 21 Jun 2011 18:38:20 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p5LGcJR6026985;
        Tue, 21 Jun 2011 17:38:19 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p5LGcHR1026978;
        Tue, 21 Jun 2011 17:38:17 +0100
Date:   Tue, 21 Jun 2011 17:38:17 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Nick Clifton <nickc@redhat.com>
Cc:     Jayachandran C <jayachandranc@netlogicmicro.com>,
        linux-mips@linux-mips.org, binutils@sourceware.org
Subject: Re: XLR Linux/MIPS kernel build error
Message-ID: <20110621163817.GA23070@linux-mips.org>
References: <20110621144340.GA11931@linux-mips.org>
 <4E00B33E.8080307@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4E00B33E.8080307@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30478
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17326

On Tue, Jun 21, 2011 at 04:05:34PM +0100, Nick Clifton wrote:

> Hi Ralf,
> 
> >   AS      arch/mips/kernel/genex.o
> >/home/ralf/src/linux/upstream-linus/arch/mips/kernel/genex.S: Assembler messages:
> >/home/ralf/src/linux/upstream-linus/arch/mips/kernel/genex.S:524: Internal error!
> >Assertion failure in append_insn at ../../gas/config/tc-mips.c line 2867.
> 
> >Not sure what's blowin up there and I haven't had a chance to try other
> >binutils versions yet.  Is this something known?
> 
> Nope - it is a new one...
> 
> Please could you open a binutils bugzilla PR for this and include
> the genex.S file (preprocessed if necessary) and the assembler
> command line that causes gas to blow up ?

I've extracted a 5 line minimal test case and cooking receipe and filed
everything as http://sourceware.org/bugzilla/show_bug.cgi?id=12915

Cheers,

  Ralf
