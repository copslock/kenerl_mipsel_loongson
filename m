Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Dec 2009 00:55:51 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:60365 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493715AbZLLXzr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 13 Dec 2009 00:55:47 +0100
Date:   Sat, 12 Dec 2009 23:55:47 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     Yoichi Yuasa <yuasa@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH resend] MIPS: more replace CL_SIZE by COMMAND_LINE_SIZE
In-Reply-To: <20091208123657.GB20624@linux-mips.org>
Message-ID: <alpine.LFD.2.00.0912122350550.14955@eddie.linux-mips.org>
References: <20091208165844.ddd9106f.yuasa@linux-mips.org> <20091208172444.9e48afe7.yuasa@linux-mips.org> <20091208123657.GB20624@linux-mips.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25396
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 8 Dec 2009, Ralf Baechle wrote:

> > Sorry, I forgot one more CL_SIZE.
> > 
> > Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
> 
> I fixed these in the pull tree for Linus a few days ago along with a few
> other issues and I was planning to get these fixes into the main tree
> indirectly by just pulling from Linus.

 Hmm, why do I have a feeling of deja vu?...  Must be this:

http://www.linux-mips.org/git?p=linux.git;a=commitdiff;h=97b7ae4257ef7ba8ed9b7944a4f56a49af3e8abb

  Maciej
