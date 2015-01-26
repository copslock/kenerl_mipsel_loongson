Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Jan 2015 09:06:38 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:49970 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006629AbbAZIGfyOhjw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Jan 2015 09:06:35 +0100
Date:   Mon, 26 Jan 2015 08:06:35 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Joshua Kinard <kumba@gentoo.org>
cc:     David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Display CPU byteorder in /proc/cpuinfo
In-Reply-To: <54BF12B9.8000507@gentoo.org>
Message-ID: <alpine.LFD.2.11.1501210347180.28301@eddie.linux-mips.org>
References: <54BCC827.3020806@gentoo.org> <54BEDF3C.6040105@gmail.com> <54BF12B9.8000507@gentoo.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45470
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

On Tue, 20 Jan 2015, Joshua Kinard wrote:

> > Userspace C code doesn't need this as it has its own standard ways of
> > determining endianness.
> > 
> > If you need to know as a user you can do:
> > 
> >    readelf -h /bin/sh | grep Data | cut -d, -f2

 I tend to use `file /sbin/init' if I need to check it for some reason -- 
less typing. ;)

> This would only tell you the endianness of the userland binary, not of the
> kernel.  While they should be one and the same (otherwise, you're not going to
> get very far anyways), they are, technically, distinctly different properties.

 Well, several MIPS processors can reverse the user-mode endianness via 
the CP0.Status.RE bit; though as you may be aware it has never been 
implemented for Linux.  Otherwise it would obviously have to be a 
per-process property (and execve(2) could flip it back).

 What you may find more interesting, we actually used to include this 
information in /proc/cpuinfo, long ago, and I believe it was removed for 
the very reason of the existence of this reverse-endianness feature.  
Which I find sort of weak an argument given that we don't support this 
stuff anyway, but given the simple ways to extract this information from 
elsewhere (/proc/config.gz is another candidate place) I have doubts if 
having it in /proc/cpuinfo adds any value too.  Not that I'd object it 
strongly either though.

 See:

commit 874124ebb6309433a2e1acf1deb95baa1c34db0b
Author: Ralf Baechle <ralf@linux-mips.org>
Date:   Sun Dec 2 11:34:32 2001 +0000

    Merge with Linux 2.4.15.

-- which actually makes me wonder what happened here as Linus's 2.4.15 
change does not include any of this stuff.  Only 2.4.19 does, 8 months 
later -- a CVS to GIT conversion problem?

  Maciej
