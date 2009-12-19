Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Dec 2009 23:11:52 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:47009 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1495502AbZLSWLq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 19 Dec 2009 23:11:46 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nBJMBkeY023778;
        Sat, 19 Dec 2009 22:11:46 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nBJMBjc6023776;
        Sat, 19 Dec 2009 22:11:45 GMT
Date:   Sat, 19 Dec 2009 22:11:45 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Yoichi Yuasa <yuasa@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH resend] MIPS: more replace CL_SIZE by COMMAND_LINE_SIZE
Message-ID: <20091219221145.GA23763@linux-mips.org>
References: <20091208165844.ddd9106f.yuasa@linux-mips.org>
 <20091208172444.9e48afe7.yuasa@linux-mips.org>
 <20091208123657.GB20624@linux-mips.org>
 <alpine.LFD.2.00.0912122350550.14955@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0912122350550.14955@eddie.linux-mips.org>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25425
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Dec 12, 2009 at 11:55:47PM +0000, Maciej W. Rozycki wrote:

> > > Sorry, I forgot one more CL_SIZE.
> > > 
> > > Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
> > 
> > I fixed these in the pull tree for Linus a few days ago along with a few
> > other issues and I was planning to get these fixes into the main tree
> > indirectly by just pulling from Linus.
> 
>  Hmm, why do I have a feeling of deja vu?...  Must be this:
> 
> http://www.linux-mips.org/git?p=linux.git;a=commitdiff;h=97b7ae4257ef7ba8ed9b7944a4f56a49af3e8abb

Good memory - this time CL_SIZE is dead for good!

  Ralf
