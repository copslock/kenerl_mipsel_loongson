Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Apr 2015 01:11:29 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27010083AbbDGXL0ucELg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Apr 2015 01:11:26 +0200
Date:   Wed, 8 Apr 2015 00:11:26 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 46/48] MIPS: math-emu: Make ABS.fmt and NEG.fmt arithmetic
 again
In-Reply-To: <20150407173136.GB27914@linux-mips.org>
Message-ID: <alpine.LFD.2.11.1504072302370.21028@eddie.linux-mips.org>
References: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org> <alpine.LFD.2.11.1504032201480.21028@eddie.linux-mips.org> <alpine.LFD.2.11.1504071620230.21028@eddie.linux-mips.org> <20150407173136.GB27914@linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46828
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

On Tue, 7 Apr 2015, Ralf Baechle wrote:

> >  One point to make here is the use of `ieee754dp_sub' and `ieee754dp_add' 
> > makes emulated ABS.fmt and NEG.fmt respect FCSR.FS for denormals just as 
> > hardware does.  I should have noted that in the commit message, perhaps it 
> > can be retrofitted?
> 
> Yes, it can.  Just send the new commit message.

 I take it back, the FLUSHXSP and FLUSHXDP macros the old implementation 
had did handle FCSR.FS.  So the original message is good.  Sorry for the 
confusion.

  Maciej
