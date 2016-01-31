Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 Jan 2016 16:07:03 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:4226 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011382AbcAaPHBvBXhX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 31 Jan 2016 16:07:01 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 166DAE351FEB9;
        Sun, 31 Jan 2016 15:06:53 +0000 (GMT)
Received: from [10.100.200.149] (10.100.200.149) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.266.1; Sun, 31 Jan 2016
 15:06:55 +0000
Date:   Sun, 31 Jan 2016 15:05:49 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Alexander Kapshuk <alexander.kapshuk@gmail.com>
CC:     Daniel Sanders <Daniel.Sanders@imgtec.com>,
        James Hogan <James.Hogan@imgtec.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Marek <mmarek@suse.com>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] ld-version: fix it on Fedora
In-Reply-To: <alpine.DEB.2.00.1601301311170.5958@tp.orcam.me.uk>
Message-ID: <alpine.DEB.2.00.1601311445300.5958@tp.orcam.me.uk>
References: <1452189189-31188-1-git-send-email-mst@redhat.com> <CAAG0J995iCNwdN6PpuJfzo+TVWNXR3UVqS9v-4HXbryyvMn+=w@mail.gmail.com> <E484D272A3A61B4880CDF2E712E9279F45D04AA7@HHMAIL01.hh.imgtec.org> <CAJ1xhMWth4kNuEkuVEUiUEz=d_9dmKxh0+Z_GrRcKB+F72W91w@mail.gmail.com>
 <E484D272A3A61B4880CDF2E712E9279F45D179FA@HHMAIL01.hh.imgtec.org> <CAJ1xhMVbxoag7psNg+5L6AmL4WYXKyBYNuVGjJcfqe6Km_10SQ@mail.gmail.com> <alpine.DEB.2.00.1601301311170.5958@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.100.200.149]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51553
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

On Sat, 30 Jan 2016, Maciej W. Rozycki wrote:

> > % echo 2.24.51.20140217 | ld-version.sh
> > 22451000
> 
>  So the above version is a non-release snapshot from the development tree 
> as the repository trunk is switched to x.y+1.51 once a release branch for 
> x.y has been made.  Then the release branch is switched to x.y-1.90 for 
> prereleases, before settling on x.y or x.y.0 (this hasn't been consistent) 
> for the actual base release.  Any subsequent maintenance releases will 
> then have their version set to x.y.1, x.y.2, and so on.  We shouldn't ever 
> rely on versions that are not proper releases.

 I need to correct myself here for unclear notation or off-by-one errors, 
the flow is of course as follows:

    trunk
   x.y-1.51
      |
      |
      |
release branchpoint
      |      \
    x.y.51 x.y-1.90
      |   prerelease
      |       |
      |       |
      v    x.y-1.91
      .   prerelease
      .       |
      .       |
              |
           x.y-1.92
          prerelease
              .
              .
              .
            x.y.0
         base release
              |
              |
              |
            x.y.1
      maintenance release
              |
              |
              |
            x.y.2
      maintenance release
              |
              v
              .
              .
              .

 The revision number is sometimes bumped up on trunk as well, to 52, 53, 
etc., though the criteria are not completely clear to me; perhaps to make 
a trunk snapshot "release".

 And last but not least for non-release builds the snapshot date is 
automatically appended to the version number reported, as seen above.

  Maciej
