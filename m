Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Oct 2005 16:27:10 +0100 (BST)
Received: from 209-232-97-206.ded.pacbell.net ([209.232.97.206]:16821 "EHLO
	dns0.mips.com") by ftp.linux-mips.org with ESMTP id S8133578AbVJQP0z
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 17 Oct 2005 16:26:55 +0100
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id j9HFQd3R015454;
	Mon, 17 Oct 2005 08:26:40 -0700 (PDT)
Received: from Ulysses ([192.168.2.3])
	by mercury.mips.com (8.12.9/8.12.11) with SMTP id j9HFQa17001581;
	Mon, 17 Oct 2005 08:26:37 -0700 (PDT)
Message-ID: <00b201c5d32e$2de780b0$0302a8c0@Ulysses>
From:	"Kevin D. Kissell" <KevinK@mips.com>
To:	"Stuart Longland" <redhatter@gentoo.org>,
	"kernel coder" <lhrkernelcoder@gmail.com>
Cc:	<linux-mips@linux-mips.org>
References: <f69849430510170429t2735ed0fo3caa862c1dfea83a@mail.gmail.com> <43539ADF.6040504@gentoo.org>
Subject: Re: How to improve performance of 2.6 kernel
Date:	Mon, 17 Oct 2005 17:19:31 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1506
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
X-Scanned-By: MIMEDefang 2.39
Return-Path: <KevinK@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9242
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: KevinK@mips.com
Precedence: bulk
X-list: linux-mips

>kernel coder wrote:
>> I am also attaching the benchmarks I took for both the kernels. Is
>> there any way I can improve 2.6's performance? Thanks.
>
>Hi,
> Don't mean to nitpick... but do you think it wise to use a proprietry
>format like Microsoft Excel on a prodominantly Linux-user list? :-)
>Tab-delimited would probably be better for distribution on a mailing list.

There are 2D data plots that are hard to do as ASCII art. ;o)
It opened fine for me in Open Office - there was one set of graphs
that looked to be empty, but I couldn't tell if that was OO screwing
up or the way the spreadsheet went out.  But the raw data was
legible and troubling.

> How much slower are we talking here?  And in what regards?

Memory copy, network I/O, and disk I/O, by factors ranging from
about 10% to almost 50% - I'd say about 25% on the average.
If this can't be explained by a configuration error, we have a real
problem here, but if that's the case, I'm surprised no one has raised
a red flag earlier.

        Regards,

        Kevin K.
