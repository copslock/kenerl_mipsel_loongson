Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Feb 2004 08:37:02 +0000 (GMT)
Received: from brilsmurf.chem.tue.nl ([IPv6:::ffff:131.155.84.68]:21480 "EHLO
	brilsmurf.chem.tue.nl") by linux-mips.org with ESMTP
	id <S8225216AbUBMIhB>; Fri, 13 Feb 2004 08:37:01 +0000
Received: from brilsmurf.chem.tue.nl (localhost [127.0.0.1])
	by brilsmurf.chem.tue.nl (8.12.3/8.12.3/Debian-6.6) with ESMTP id i1D8b0vI017075
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <linux-mips@linux-mips.org>; Fri, 13 Feb 2004 09:37:01 +0100
Received: from localhost (joost@localhost)
	by brilsmurf.chem.tue.nl (8.12.3/8.12.3/Debian-6.6) with ESMTP id i1D8b0Ku019041
	for <linux-mips@linux-mips.org>; Fri, 13 Feb 2004 09:37:00 +0100
X-Authentication-Warning: brilsmurf.chem.tue.nl: joost owned process doing -bs
Date: Fri, 13 Feb 2004 09:37:00 +0100 (CET)
From: Joost <Joost@stack.nl>
X-X-Sender: joost@brilsmurf.chem.tue.nl
To: linux-mips@linux-mips.org
Subject: Re: indy r4000FPC kernel?
In-Reply-To: <20040212201020.GA942@bogon.ms20.nix>
Message-ID: <Pine.LNX.4.58.0402130928570.15140@brilsmurf.chem.tue.nl>
References: <Pine.LNX.4.58.0402121652410.24037@brilsmurf.chem.tue.nl>
 <20040212174822.GD1280@bogon.ms20.nix> <Pine.LNX.4.58.0402121943180.3067@brilsmurf.chem.tue.nl>
 <20040212201020.GA942@bogon.ms20.nix>
ReplyTo: Joost@stack.nl
User-Agent: 007
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <Joost@stack.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4348
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Joost@stack.nl
Precedence: bulk
X-list: linux-mips

On Thu, 12 Feb 2004, Guido Guenther wrote:
> On Thu, Feb 12, 2004 at 07:46:36PM +0100, Joost wrote:
> > On Thu, 12 Feb 2004, Guido Guenther wrote:
> > > On Thu, Feb 12, 2004 at 05:12:58PM +0100, Joost wrote:
> > > > seems to be as far as it will go. The 2.4.22 that comes with
> > > > debian testing gives an error while booting so i decided
> > > What kind of error?
> > It might have been the "can't load elf" problem. I'm very new
> > to all of this so at the time (yesterday :-) I didn't know a
> > solution existed. If it's important to you I could check again
> > tomorow?
> Yes please do. Thanks.
After running elf2ecoff on it, the kernel from debian testing
(kernel-image-2.4.22-r4k-ip22) seems to run just fine.
The linux_2_4 cvs that compiled this night also works ok.

Many thanks for all your help!

Joost.
-- 
"Love is the delusion that one woman differs from another." -- HL Mencken
