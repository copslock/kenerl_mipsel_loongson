Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 27 Apr 2003 21:01:36 +0100 (BST)
Received: from h0000c06cf87e.ne.client2.attbi.com ([IPv6:::ffff:24.147.212.21]:38152
	"EHLO compaq.parker.boston.ma.us") by linux-mips.org with ESMTP
	id <S8225223AbTD0UBc>; Sun, 27 Apr 2003 21:01:32 +0100
Received: from p2.parker.boston.ma.us (p2 [192.245.5.16])
	by compaq.parker.boston.ma.us (8.11.6/8.11.6) with ESMTP id h3RK1SH17972;
	Sun, 27 Apr 2003 16:01:28 -0400
Received: from p2 (brad@localhost)
	by p2.parker.boston.ma.us (8.11.2/8.11.2) with ESMTP id h3RK1SV12204;
	Sun, 27 Apr 2003 16:01:28 -0400
Message-Id: <200304272001.h3RK1SV12204@p2.parker.boston.ma.us>
From: Brad Parker <brad@parker.boston.ma.us>
To: Chip Coldwell <coldwell@frank.harvard.edu>
cc: Brad Parker <brad@parker.boston.ma.us>, linux-mips@linux-mips.org
Subject: Re: NCD900 port? 
In-Reply-To: Message from Chip Coldwell <coldwell@frank.harvard.edu> 
   of "Thu, 24 Apr 2003 22:17:17 EDT." <Pine.LNX.4.44.0304242215050.20322-100000@frank.harvard.edu> 
X-Mailer: MH-E 7.2; nmh 1.0.4; GNU Emacs 20.7.1
Date: Sun, 27 Apr 2003 16:01:28 -0400
Return-Path: <brad@parker.boston.ma.us>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Spam-Checker-Version: SpamAssassin 2.50 (1.173-2003-02-20-exp)
X-archive-position: 2208
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brad@parker.boston.ma.us
Precedence: bulk
X-list: linux-mips


Chip Coldwell wrote:
>On Thu, 24 Apr 2003, Brad Parker wrote:
>> 
>> It it's anything like the explora 450 you should be able to get it going.
>> (oh my, did *I* say that?)
>> 
>> The 450 has those same two chips with a ppc403.  I managed to hack my
>> way into their undocumented pci bridge enough to get linux booted and
>> the ethernet working.  I have yet to get the s3 working but that's only
>> because I can find a pdf for the chip anywhere.  I can certainly talk to
>> the s3 (as well as the pcmcia space).
>
>That's very interesting.  When you say you don't have the S3 working,
>do you mean that you can't get a virtual terminal on the display or
>that you can't get X Windows working?  If the former, do you use a
>serial console?

I mean I can't get the existing S3 driver to talk to it at all.  The existing
driver assumes it's running on a real pc and I can't figure out the mapping.

current I use a serial console.

I can see the S3's pci space through the bridge, but I can't figure out
how to change the existing driver to talk it.

-brad
