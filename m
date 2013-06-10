Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jun 2013 20:26:35 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:45685 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817177Ab3FJS02t5CeL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Jun 2013 20:26:28 +0200
Date:   Mon, 10 Jun 2013 19:26:28 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Alexis BRENON <abrenon@wyplay.com>
cc:     linux-mips@linux-mips.org
Subject: Re: Immediate branch offset
In-Reply-To: <51B57DA8.1010206@wyplay.com>
Message-ID: <alpine.LFD.2.03.1306101924420.18329@linux-mips.org>
References: <51B1B739.7080104@wyplay.com> <alpine.LFD.2.03.1306082206540.18329@linux-mips.org> <51B57DA8.1010206@wyplay.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36815
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Mon, 10 Jun 2013, Alexis BRENON wrote:

> > > To debug, I write a small program in the MARS MIPS simulator with this
> > > instruction. But when compiling, assembler says me that -8 is an operand
> > > of
> > > incorrect type.
> >   The instruction you quoted assembles for me successfully, what version of
> > binutils do you use and what exact error message do you get?
> 
> I didn't try to assemble it, but only to run it in the MARS simulator. If I
> assemble it with GNU AS, it assembles successfully.

 So what assembler have you been referring to above?

  Maciej
