Received:  by oss.sgi.com id <S553989AbQKFLlr>;
	Mon, 6 Nov 2000 03:41:47 -0800
Received: from chmls20.mediaone.net ([24.147.1.156]:58872 "EHLO
        chmls20.mediaone.net") by oss.sgi.com with ESMTP id <S553844AbQKFLlb>;
	Mon, 6 Nov 2000 03:41:31 -0800
Received: from decoy (h00a0cc39f081.ne.mediaone.net [24.218.248.129])
	by chmls20.mediaone.net (8.8.7/8.8.7) with SMTP id GAA08431;
	Mon, 6 Nov 2000 06:41:24 -0500 (EST)
From:   "Jay Carlson" <nop@nop.com>
To:     <linux-mips@fnet.fr>, <linux-mips@oss.sgi.com>
Subject: RE: The initial results (Re: stable binutils, gcc, glibc ...
Date:   Mon, 6 Nov 2000 06:43:25 -0500
Message-ID: <KEEOIBGCMINLAHMMNDJNIEDGCAAA.nop@nop.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <39ED2166.9B5F970@mvista.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

> I also had success with latest binutils CVS tree.  I gave a try to the
> latest gcc, but did not look into it further.
>
> http://sourceware.cygnus.com/binutils
> cvs -z 9 -d :pserver:anoncvs@anoncvs.cygnus.com:/cvs/src co -D "Oct 13,
> 2000" binutils

OK, I've decided to bite the bullet and try to get current on everything.
Most of the patches I've seen lying around have been integrated into
binutils and gcc.  Congratulations!

However, there's still this lingering issue with binutils.  The ulfc patches
haven't been integrated, and I'm worried that I'm going to run into the
"binutils generate busted relocs" problem as a result.  What's the
resolution of that issue?  Patch still needed?  Patch not needed if the only
two binutils ever used are 2.8.1 and current-cvs (>2.10)?

Jay
