Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Oct 2007 16:39:21 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:53638 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28576035AbXJaQjT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 31 Oct 2007 16:39:19 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9VGd1JU023505;
	Wed, 31 Oct 2007 16:39:01 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9VGd016023504;
	Wed, 31 Oct 2007 16:39:00 GMT
Date:	Wed, 31 Oct 2007 16:39:00 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: WAIT vs. tickless kernel
Message-ID: <20071031163900.GB22871@linux-mips.org>
References: <20071101.004906.106263529.anemo@mba.ocn.ne.jp> <20071031161333.GA22871@linux-mips.org> <20071101.013124.108121433.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071101.013124.108121433.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17337
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Nov 01, 2007 at 01:31:24AM +0900, Atsushi Nemoto wrote:

> On Wed, 31 Oct 2007 16:13:33 +0000, Ralf Baechle <ralf@linux-mips.org> wrote:
> > This one is definately playing with the fire.  Or alternatively requires
> > detailed knowledge of the pipeline and pipelines tend to change.  MIPS
> > Technologies does regular maintenance releases of its cores which also
> > add features and may change the pipelines in subtle way that may break
> > something like this.
> 
> Yes, I never think this is robust or guaranteed...
> 
> > The only safe but ugly workaround is to change the return from exception
> > code to detect if the EPC is in the range startin from the condition
> > check in the idle loop to including the WAIT instruction and if so to
> > patch the EPC to resume execution at the condition check or the
> > instruction following the WAIT.
> 
> I'm also thinking of this approach.  Still wondering if it is worth to
> implement.

The tickless kernel is very interesting for the low power fraction.  And
it's especially those users who would suffer most the loss of the ability
to use the WAIT instruction.  For a system running from two AAA cells the
tradeoff is clear ...  So I think it's become a must.

  Ralf
