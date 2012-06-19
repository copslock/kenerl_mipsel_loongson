Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jun 2012 20:33:33 +0200 (CEST)
Received: from h9.dl5rb.org.uk ([81.2.74.9]:60591 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903567Ab2FSSd3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 19 Jun 2012 20:33:29 +0200
Received: from h5.dl5rb.org.uk (h5.dl5rb.org.uk [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.5/8.14.3) with ESMTP id q5JIXSHN025237;
        Tue, 19 Jun 2012 19:33:28 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.5/8.14.5/Submit) id q5JIXSlm025232;
        Tue, 19 Jun 2012 19:33:28 +0100
Date:   Tue, 19 Jun 2012 19:33:28 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Steven J. Hill" <sjhill@realitydiluted.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: MIPS: Fixup ordering of micro assembler instructions.
Message-ID: <20120619183327.GB597@linux-mips.org>
References: <S1903563Ab2E3UqG/20120530204607Z+6387@eddie.linux-mips.org>
 <4FD95599.9070708@realitydiluted.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4FD95599.9070708@realitydiluted.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 33726
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Wed, Jun 13, 2012 at 10:08:09PM -0500, Steven J. Hill wrote:

> On 05/30/2012 03:46 PM, linux-mips@linux-mips.org wrote:
> > Author: Steven J. Hill <sjhill@mips.com> Fri May 11 01:35:47 2012 -0500 
> > Comitter: Ralf Baechle <ralf@linux-mips.org> Wed May 30 21:37:16 2012
> > +0100 Commit: 6e3f8b69731d6dc03afdd47cfdddb0e479a6d2a9 Gitweb: 
> > http://git.linux-mips.org/g/ralf/linux/6e3f8b69731d Branch: master
> > 
> > A number of new instructions have been added to the micro assembler
> > causing the list to no longer be in alphabetical order. This patch fixes up
> > the name ordering.
> > 
> > Signed-off-by: Steven J. Hill <sjhill@mips.com> Cc: 
> > linux-mips@linux-mips.org Patchwork: 
> > https://patchwork.linux-mips.org/patch/3789/ Signed-off-by: Ralf Baechle 
> > <ralf@linux-mips.org>
> > 
> Ralf,
> 
> This patch is fscked. The lines for _bbit0 and _bbit1 are duplicated. Please
> commit a patch to remove the duplicate lines. Thanks.

Unfscked.  Sorry, I had so many conflicts with other patches as I was
juggling around this patch that it somehow got turned into green goo.

  Ralf 
