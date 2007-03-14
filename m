Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Mar 2007 08:05:15 +0000 (GMT)
Received: from mail.blastwave.org ([147.87.98.10]:40654 "EHLO
	mail.blastwave.org") by ftp.linux-mips.org with ESMTP
	id S20022392AbXCNIFJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 14 Mar 2007 08:05:09 +0000
Received: from localhost (localhost [127.0.0.1])
	by mail.blastwave.org (Postfix) with ESMTP id 3D713F98A;
	Wed, 14 Mar 2007 09:04:38 +0100 (MET)
X-Virus-Scanned: amavisd-new at blastwave.org
Received: from mail.blastwave.org ([127.0.0.1])
	by localhost (enterprise.blastwave.org [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id gFDfVOIADTTK; Wed, 14 Mar 2007 09:04:29 +0100 (MET)
Received: from unknown (66-132.63-81.stat.fixnetdata.ch [81.63.132.66])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.blastwave.org (Postfix) with ESMTP id B2F58F99F;
	Wed, 14 Mar 2007 09:04:29 +0100 (MET)
Date:	Wed, 14 Mar 2007 09:04:27 +0100
From:	Attila Kinali <attila@kinali.ch>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: crash in first printk of start_kernel
Message-Id: <20070314090427.6998781c.attila@kinali.ch>
In-Reply-To: <20070313010252.GB26119@linux-mips.org>
References: <20070309191354.f962e57b.attila@kinali.ch>
	<20070313010252.GB26119@linux-mips.org>
Organization: NERV
X-Mailer: Sylpheed 2.3.0 (GTK+ 2.10.6; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <attila@kinali.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14463
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: attila@kinali.ch
Precedence: bulk
X-list: linux-mips

Hoi Ralf,

On Tue, 13 Mar 2007 01:02:52 +0000
Ralf Baechle <ralf@linux-mips.org> wrote:

> On Fri, Mar 09, 2007 at 07:13:54PM +0100, Attila Kinali wrote:
> > I'm using a 2.6.16.11 (an old snapshot from about last august,
> > when we started development of another board) that has slight
> > adjustments in various drivers to accomodate for our platform
> > specific stuff.
> 
> You may want to update anyway.  between the linux-2.6.16.11 tag of the
> linux-mips.org and the top of the linux-2.6.16-stable branch there are
> almost 58,000 lines of patch.  Even more if your compare the MIPS -stable
> branch to kernel.org's 2.6.16.11.  Iow a few metric buttloads.

That's already planned. But if first have to get past those
dead lines. After that i can look into makeing the whole
build system upgradeable and managable-

 
> > 0xffffffff80266134 <vsnprintf+76>:      beqz    v0,0x80266144 <vsnprintf+92>
> > 0xffffffff80266138 <vsnprintf+80>:      bltz    a0,0x802461c0 <jffs2_remount_fs+144>
> 
> A branch in the delay slot of another branch is forbidden by the MIPS
> architecture.  All processors I every tried this on missbehave in very
> unobvious ways when this is attempted.
> 
> You may want to compare that against your vmlinux file.  If the vmlinux
> binary also contains this bug, try building the affected source file with
> -S to find if the bug is cause by compiler or assembler.

It turned out to be a ground bounce problem. Interestingly the
"bug" was 100% reproducable, while normale ground problems are
totaly random. Thus i thought it has to be something in the
software.

> In single stepping mode your debugger probably executes branches by
> software emulation.  Chances are the emulation does something different
> for this illegal code sequence than actual hardware.

Oh.. nice to know. Thanks.
 
Thanks a lot for your answer and help,

			Attila Kinali
-- 
Praised are the Fountains of Shelieth, the silver harp of the waters,
But blest in my name forever this stream that stanched my thirst!
                         -- Deed of Morred
