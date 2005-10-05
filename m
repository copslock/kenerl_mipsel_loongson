Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Oct 2005 18:17:38 +0100 (BST)
Received: from extgw-uk.mips.com ([62.254.210.129]:54810 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S3465669AbVJERRT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 5 Oct 2005 18:17:19 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j95HHDeA022959;
	Wed, 5 Oct 2005 18:17:13 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j95HHCPp022958;
	Wed, 5 Oct 2005 18:17:12 +0100
Date:	Wed, 5 Oct 2005 18:17:12 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@avtrex.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] fix warning in tlbex.c for CONFIG_32BIT
Message-ID: <20051005171712.GJ2699@linux-mips.org>
References: <4343586E.4030703@avtrex.com> <20051005105336.GH2699@linux-mips.org> <4343F5B2.3020509@avtrex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4343F5B2.3020509@avtrex.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9153
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 05, 2005 at 08:48:02AM -0700, David Daney wrote:

> Some people on this list are quite adamant that patches be in-line.
> 
> I was trying to see how my mailer (Thunderbird) handled this.  Obviously 
>  (in hindsight) it screws things up.
> 
> Sending as an attachment works well except some mailers (Not 
> Thunderbird) cannot quote attached patches with out jumping through hoops.
> 
> I don't really want to change the mailer that I am using, so I am in a 
> bit of a bind WRT submitting patches here.
> 
> FWIW other mailing lists (binutils, gcc) don't seem to have the same 
> trouble with attached patches.

Maybe a different style of work there.  The submission style we're asking
people to follow here is exactly the same as on linux-kernel, netdev or
other kernel-related lists.

I just asked somebody; this is the answer I got:

<snip>
  I have never had any luck getting mailers to send patches in a way that
  no one complained about. In the end, I used this
  http://www.speakeasy.org/~pj99/sgi/sendpatchset

  I found the best way is to have a directory with patches like
  001_part1.patch, 002_part2.patch etc with matching explainations in
  001_part1.mail 002_part2.mail . I have a script that generates the final
  mails and feeds them to sendpatchset
<snip>

The script may not be what you want but I guess I'll be something like it
to deal with the huge patchsets I'm sometimes fiddling with - like the
452 patch monster right now ...

  Ralf
