Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Feb 2016 14:00:36 +0100 (CET)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27012512AbcBKNAcCrZkJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Feb 2016 14:00:32 +0100
Date:   Thu, 11 Feb 2016 13:00:32 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org, Michal Marek <mmarek@suse.com>,
        linux-kbuild@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH] ld-version: fix it on Fedora
In-Reply-To: <20160107181920.GE17031@linux-mips.org>
Message-ID: <alpine.LFD.2.20.1602111249400.2715@eddie.linux-mips.org>
References: <1452189189-31188-1-git-send-email-mst@redhat.com> <20160107181920.GE17031@linux-mips.org>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52002
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

On Thu, 7 Jan 2016, Ralf Baechle wrote:

> > GNU ld version 2.25-15.fc23
> > 
> > But ld-version.sh fails to parse this, so e.g.  mips build fails to
> > enable VDSO, printing a warning that binutils >= 2.24 is required.
> > 
> > To fix, teach ld-version to parse this format.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> > 
> > Which tree should this be merged through? Mine? MIPS?
> 
> MIPS is the sole user of ld-ifversion at this time and taking this through
> the MIPS tree will avoid possible merge conflicts with James Hogan's
> pending d5ece1cb074b2c7082c9a2948ac598dd0ad40657 fix ("Fix ld-version.sh to
> handle large 3rd version part").  So I think I should take this through
> the MIPS tree.

 FYI, I'm still getting a failure here, with:

$ mips64el-linux-ld --version
GNU ld (GNU Binutils) 2.20.1.20100303
[...]
$

-- so this is a plain upstream development snapshot as these have their 
date appended.  Can we just get rid of the subversion components beyond 
the third, as I already suggested?  I.e. stop on the third point and in 
any case on a non-point-non-digit.

 I'll post a minimal fix shortly, feel free to enhance it if needed.

  Maciej
