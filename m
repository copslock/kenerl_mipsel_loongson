Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Feb 2006 11:49:49 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:5124 "EHLO
	bacchus.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133588AbWBJLtl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 10 Feb 2006 11:49:41 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.4/8.13.4) with ESMTP id k1ABtPWs006118;
	Fri, 10 Feb 2006 11:55:25 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k1ABtPme006117;
	Fri, 10 Feb 2006 11:55:25 GMT
Date:	Fri, 10 Feb 2006 11:55:25 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Don Imus <donimus@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Rogue Branch - can git help here?
Message-ID: <20060210115525.GA5195@linux-mips.org>
References: <43EC03F4.4040805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43EC03F4.4040805@gmail.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10392
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Feb 09, 2006 at 10:09:40PM -0500, Don Imus wrote:

> I've got an old Linux 2.4.18 source tree I downloaded from a vendor who 
> sells devices using MIPS processors with embedded Linux running on them.
> 
> There are clearly places in the code where the vendor has made changes. 
>  Unfotunately, the vendor used their own CVS and every tagged file 
> shows revision 1.1.1.1.
> 
> Can GIT help me determine on which date the vendor's tree was originally 
> pulled?
> 
> I thought of a script call GIT to diff the file against all revisions in 
> the repo, possibly creating patch files, and then I could look at the 
> number of changes for each as a measure of "closeness".  Doing this for 
> several files and finding commonality in the dates would increase the 
> probability of finding the right one.
> 
> If I copy the vendor source tree into the local GIT tree and commit a 
> new branch are there any facilitites in GIT that would tell me which 
> older revision, prior to a given date, is the best "match" on the files 
> in the tree?

Nothing straight of the shelf, unfortunately.

> I just started using GIT and maybe the question is better for the GIT 
> mailing list but I figured I'd ask it here first and see if anyone has 
> already done something like this.
> 
> In case anyone's wondering the device ships with a binary-only device 
> driver module that will only work with a 2.4.18 kernel and that's why 
> I'm stuck in the past on this.

The crude ad-hoc method would be to write a quick shell scripts that
creates a diff between every revision between linux-2.4.18..linux-2.4.19
but that would be slow.  And it's a just too common problem (I last faced
it less than a week ago ...) so may deserve a better solution in git than
just an ad-hoc script, so I suggest you indeed take this to the git
mailing list.

  Ralf
