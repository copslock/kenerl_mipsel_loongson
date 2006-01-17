Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2006 12:23:36 +0000 (GMT)
Received: from [62.38.115.213] ([62.38.115.213]:22196 "EHLO pfn3.pefnos")
	by ftp.linux-mips.org with ESMTP id S3465570AbWAQMXS (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 17 Jan 2006 12:23:18 +0000
Received: from xorhgos2.pefnos (xorhgos2.pefnos [192.168.0.3])
	by pfn3.pefnos (Postfix) with ESMTP id 649F51F31B;
	Tue, 17 Jan 2006 14:26:27 +0200 (EET)
From:	"P. Christeas" <p_christ@hol.gr>
To:	David Daney <ddaney@avtrex.com>
Subject: Re: gcc -3.4.4 and linux-2.4.32
Date:	Tue, 17 Jan 2006 14:26:08 +0200
User-Agent: KMail/1.9
Cc:	Kishore K <hellokishore@gmail.com>, linux-mips@linux-mips.org
References: <f07e6e0601160423h5ce1c0d7lcb7e38f8509c4116@mail.gmail.com> <43CBD91B.4020607@avtrex.com>
In-Reply-To: <43CBD91B.4020607@avtrex.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601171426.10317.p_christ@hol.gr>
Return-Path: <p_christ@hol.gr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9926
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: p_christ@hol.gr
Precedence: bulk
X-list: linux-mips

On Monday 16 January 2006 7:34 pm, David Daney wrote:
> Kishore K wrote:
> > hi
> > When 2.4.32 kernel (from linux-mips) is compiled with the tool chain
> > based on gcc 3.4.4 and binutils 2.16.1, the kernel crashes on malta
> > board. The crash file is enclosed along with the mail. If the same
> > kernel is compiled with the tool chain based on gcc 3.3.6, no problem is
> > observed.
> >
> > May I know, whether it is because of the changes in ABI in gcc 3.4.
>
> Not exactly.  It has to do with -funit-at-a-time.  In the 2.4.x kernel
> it is assumed that gcc will not reorder top level asm statements and
> functions.  For gcc-3.3.x and earlier this was a valid assumption.  With
> 3.4.x and later it is not.
>
Does that apply to gcc-4.0.2 as well? It is mentioned in linux documentation 
that -funit-at-a-time is safe as of gcc-4.x. Is there (I'm not a MIPS expert) 
a way to verify whether gcc produces wrong instructions?
I've had a similar problem (I only try with gcc 4, because I compile linux 
2.6) and is reduced when I use -fno-unit-at-a-time. Still, I have 
instability, which now appears less often.
I've tried the '-fno-unit-at-a-time' solution (for the whole kernel) and the 
'pop/push' at interrupt.h fix.

> > If
> > so, has any one got the patch to make 2.4.x kernels work with gcc 3.4
> > compilers? From the changelog, I can infer that, some changes have been
> > done in 2.4.28 kernel to work with gcc 3.4 for i386. If so, has the same
> > thing been done for MIPS as well.
>
> IIRC the patches were never applied to linux-mips.org.  If you search
> the archives of this list for messages that I sent, you can find the
> patches.
Can you please list the necessary patches? One line for each would do, as I 
want to check if I have them all. 

>
> David Daney.
