Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Feb 2004 17:03:39 +0000 (GMT)
Received: from brilsmurf.chem.tue.nl ([IPv6:::ffff:131.155.84.68]:45794 "EHLO
	brilsmurf.chem.tue.nl") by linux-mips.org with ESMTP
	id <S8224991AbUBLRDj>; Thu, 12 Feb 2004 17:03:39 +0000
Received: from brilsmurf.chem.tue.nl (localhost [127.0.0.1])
	by brilsmurf.chem.tue.nl (8.12.3/8.12.3/Debian-6.6) with ESMTP id i1CH3ZvI013836
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <linux-mips@linux-mips.org>; Thu, 12 Feb 2004 18:03:35 +0100
Received: from localhost (joost@localhost)
	by brilsmurf.chem.tue.nl (8.12.3/8.12.3/Debian-6.6) with ESMTP id i1CH3ZIR005123
	for <linux-mips@linux-mips.org>; Thu, 12 Feb 2004 18:03:35 +0100
X-Authentication-Warning: brilsmurf.chem.tue.nl: joost owned process doing -bs
Date: Thu, 12 Feb 2004 18:03:35 +0100 (CET)
From: Joost <Joost@stack.nl>
X-X-Sender: joost@brilsmurf.chem.tue.nl
To: linux-mips@linux-mips.org
Subject: Re: indy r4000FPC kernel?
In-Reply-To: <20040212164204.GC7586@icm.edu.pl>
Message-ID: <Pine.LNX.4.58.0402121802210.24037@brilsmurf.chem.tue.nl>
References: <Pine.LNX.4.58.0402121652410.24037@brilsmurf.chem.tue.nl>
 <20040212164204.GC7586@icm.edu.pl>
ReplyTo: Joost@stack.nl
User-Agent: 007
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <Joost@stack.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4343
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Joost@stack.nl
Precedence: bulk
X-list: linux-mips

On Thu, 12 Feb 2004, Dominik 'Rathann' Mierzejewski wrote:
> Get a current version (branch linux_2_4) from linux-mips.org's CVS
> and try that one. There have been some trouble with r4k processors
> lately, but they seem to be resolved now. I'm running 2.4.25-pre6
> at the moment. Oh, and use arcboot - it saves a lot of hassle.
> You don't have to upload your kernel to volume header and you can
> boot any ELF kernel image that is on any ext2/3 partition on your
> system.
Thank you!
I will give it a try right now, should be finished by dawn :-)

Joost.
-- 
When I was a child I could remember anything...
Whether it happened or not. -- Mark Twain
