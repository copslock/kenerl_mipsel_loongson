Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Sep 2011 21:42:44 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:57165 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492121Ab1I1Tmk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Sep 2011 21:42:40 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p8SJhLBM017540;
        Wed, 28 Sep 2011 21:43:21 +0200
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p8SJhKZC017533;
        Wed, 28 Sep 2011 21:43:20 +0200
Date:   Wed, 28 Sep 2011 21:43:20 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul_Koning@Dell.com
Cc:     binutils@sourceware.org, linux-mips@linux-mips.org, dvdkhlng@gmx.de
Subject: Re: $ta0 .. $ta3 registers in O32 on MIPS
Message-ID: <20110928194319.GA17409@linux-mips.org>
References: <20110928123305.GA1971@linux-mips.org>
 <09787EF419216C41A903FD14EE5506DD030987ABAE@AUSX7MCPC103.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09787EF419216C41A903FD14EE5506DD030987ABAE@AUSX7MCPC103.AMER.DELL.COM>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31185
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 16936

On Wed, Sep 28, 2011 at 10:11:40AM -0500, Paul_Koning@Dell.com wrote:

> >I was expecting an error message and I'm wondering, was this intentional?
> 
> I would say so.  I call this a feature.  It makes it easier to write assembly code that assembles without change in both O32 and N32/N64.  Consider a function that has 4 or fewer arguments, but needs a pile of scratch registers.  It can use ta0-ta3 as four scratch registers, which is correct in all the ABIs.

Turns out that later IRIX version also retroactively introduced the
ta registers for O32 and I just never noticed.  So I'm going to change the
Linux kernel headers for consistence and compatibility with everybody else.

  Ralf
