Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 27 Apr 2003 21:08:27 +0100 (BST)
Received: from h0000c06cf87e.ne.client2.attbi.com ([IPv6:::ffff:24.147.212.21]:39688
	"EHLO compaq.parker.boston.ma.us") by linux-mips.org with ESMTP
	id <S8225223AbTD0UIZ>; Sun, 27 Apr 2003 21:08:25 +0100
Received: from p2.parker.boston.ma.us (p2 [192.245.5.16])
	by compaq.parker.boston.ma.us (8.11.6/8.11.6) with ESMTP id h3RK8GH17978;
	Sun, 27 Apr 2003 16:08:16 -0400
Received: from p2 (brad@localhost)
	by p2.parker.boston.ma.us (8.11.2/8.11.2) with ESMTP id h3RK8DL12356;
	Sun, 27 Apr 2003 16:08:13 -0400
Message-Id: <200304272008.h3RK8DL12356@p2.parker.boston.ma.us>
From: Brad Parker <brad@parker.boston.ma.us>
To: Chip Coldwell <coldwell@frank.harvard.edu>
cc: Dan Aizenstros <daizenstros@quicklogic.com>, kevink@mips.com,
	linux-mips@linux-mips.org
Subject: Re: NCD900 port? 
In-Reply-To: Message from Chip Coldwell <coldwell@frank.harvard.edu> 
   of "Fri, 25 Apr 2003 10:18:41 EDT." <Pine.LNX.4.44.0304251008550.23558-100000@frank.harvard.edu> 
X-Mailer: MH-E 7.2; nmh 1.0.4; GNU Emacs 20.7.1
Date: Sun, 27 Apr 2003 16:08:13 -0400
Return-Path: <brad@parker.boston.ma.us>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Spam-Checker-Version: SpamAssassin 2.50 (1.173-2003-02-20-exp)
X-archive-position: 2209
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brad@parker.boston.ma.us
Precedence: bulk
X-list: linux-mips


Chip Coldwell wrote:
>
>> Can you provide any information about the bootloader?
>> Does it support loading of ELF images?
>
>I really don't know.  If it doesn't, I suppose could give it a
>compressed kernel image.  Or would this require some monkeying around
>with head.S?

On the 450 I had to make a slight change to head.S and I hacked a program
which fools around with the ELF header to get the NCD boot loader to 
be happy.  I got this program originally from Dan Malek - I think it 
was originally intended to wake an ELF header for a VXWorks boot loader
(which the ncd boot loader, on the 450 at least, appears to be)

the source is on sourceforge or I can email the interesting bits.

(http://explora-linux.sourceforge.net)

-brad
