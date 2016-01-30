Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Jan 2016 14:38:14 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:16187 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009614AbcA3NiNN20mP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Jan 2016 14:38:13 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id B6A6A42E170A7;
        Sat, 30 Jan 2016 13:38:04 +0000 (GMT)
Received: from [10.100.200.149] (10.100.200.149) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.235.1; Sat, 30 Jan 2016
 13:38:06 +0000
Date:   Sat, 30 Jan 2016 13:38:03 +0000
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
In-Reply-To: <CAJ1xhMVbxoag7psNg+5L6AmL4WYXKyBYNuVGjJcfqe6Km_10SQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1601301311170.5958@tp.orcam.me.uk>
References: <1452189189-31188-1-git-send-email-mst@redhat.com> <CAAG0J995iCNwdN6PpuJfzo+TVWNXR3UVqS9v-4HXbryyvMn+=w@mail.gmail.com> <E484D272A3A61B4880CDF2E712E9279F45D04AA7@HHMAIL01.hh.imgtec.org> <CAJ1xhMWth4kNuEkuVEUiUEz=d_9dmKxh0+Z_GrRcKB+F72W91w@mail.gmail.com>
 <E484D272A3A61B4880CDF2E712E9279F45D179FA@HHMAIL01.hh.imgtec.org> <CAJ1xhMVbxoag7psNg+5L6AmL4WYXKyBYNuVGjJcfqe6Km_10SQ@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.100.200.149]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51549
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

On Mon, 25 Jan 2016, Alexander Kapshuk wrote:

> > > At the moment, I'm wondering whether we really need to handle more 
> > > than three version number components. Another thought is that the 
> > > comparison could be inside ld-version.sh (or a replacement) so that 
> > > it can compare the array of version components directly instead of 
> > > using a constructed integer as a proxy.

 I don't think going beyond three version number components makes sense, 
to be honest.  Any such numbers will be non-standard third-party releases.  
Upstream binutils use a three-component versioning scheme.  Even the third 
component only makes sense because sometime we may actually rely on a bug 
fix first available with a maintenance release; these reach single-digit 
numbers only and hardly ever above 1 actually as another base release is 
usually made quickly enough (the usual schedule was annual, although as 
from 2.26, out last Monday, it has been switched to a semi-annual cycle).

> I put the latter of the two methods that worked for you it into a
> script, shown below:
> 
> #!/usr/bin/awk -f
> # extract linker version number from stdin and turn into single number
> 
> /[0-9]+([.]?[0-9]+)+/ && !/not found$/{
>     match($0, /[0-9]+([.]?[0-9]+)+/)
>     ver=substr($0,RSTART,RLENGTH)
>     split(ver, a, ".")
>     print a[1]*10000000 + a[2]*100000 + a[3]*1000
>     exit
> }
> 
> And tried it out on the following input:
> 
> % echo 2.24.51.20140217 | ld-version.sh
> 22451000

 So the above version is a non-release snapshot from the development tree 
as the repository trunk is switched to x.y+1.51 once a release branch for 
x.y has been made.  Then the release branch is switched to x.y-1.90 for 
prereleases, before settling on x.y or x.y.0 (this hasn't been consistent) 
for the actual base release.  Any subsequent maintenance releases will 
then have their version set to x.y.1, x.y.2, and so on.  We shouldn't ever 
rely on versions that are not proper releases.

> % echo 'GNU ld version 2.25-15.fc23' | ld-version.sh
> 22500000

 So this is a base 2.25 release (obviously with vendor patches, hopefully 
not breaking what we might rely on).

 FWIW,

  Maciej
