Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Sep 2006 05:57:45 +0100 (BST)
Received: from py-out-1112.google.com ([64.233.166.178]:36248 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20037572AbWIDE5N (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 4 Sep 2006 05:57:13 +0100
Received: by py-out-1112.google.com with SMTP id i49so1910184pyi
        for <linux-mips@linux-mips.org>; Sun, 03 Sep 2006 21:57:12 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=s4zDVTjuyoiXzs2gRMvkom/LJEzVGC1CqE3xS22wXLDrr/7/ELnqHhsKAjHjqxoTF0AlZAiIcTJp5HsHXR1uOBmOtHGvfPZEGamM7akM+ToTdExRPJi1FZhxTvExxVe9dZhit0lD+DYjU1l3LjL1zkeAjK42o2/ZiPKJSeGMNS8=
Received: by 10.65.116.7 with SMTP id t7mr2613811qbm;
        Sun, 03 Sep 2006 21:57:12 -0700 (PDT)
Received: by 10.65.126.5 with HTTP; Sun, 3 Sep 2006 21:57:12 -0700 (PDT)
Message-ID: <b01966ec0609032157s35d8c0bdx900956f214c5337b@mail.gmail.com>
Date:	Mon, 4 Sep 2006 10:27:12 +0530
From:	"Nida M" <nidajm@gmail.com>
To:	"Kevin D. Kissell" <KevinK@mips.com>
Subject: Re: single step in MIPS
Cc:	linux-mips@linux-mips.org
In-Reply-To: <000b01c6cea8$7d480fa0$a803a8c0@Ulysses>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <b01966ec0609020445m693b53cfj87d31a4957627f1a@mail.gmail.com>
	 <000b01c6cea8$7d480fa0$a803a8c0@Ulysses>
Return-Path: <nidajm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12509
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nidajm@gmail.com
Precedence: bulk
X-list: linux-mips

On 9/2/06, Kevin D. Kissell <KevinK@mips.com> wrote:
> As Alan indicted, mechanisms for emulating single step
> behavior have long existed for MIPS and Linux.  Newer
> MIPS parts which implement the EJTAG debug system
> do have a single-step mode, but they trap to Debug mode,
> rather than to the kernel - this allows kernel code to be
> single-stepped using an EJTAG probe.  If the system
> allows for it - one needs to have ROM at the right location
> which transfers Debug mode control back to the kernel - it
> is possible to exploit EJTAG debug features from an OS
> kernel. We''ve prototyped this to prove that it works, but
> never went so far as to wire up EJTAG signle-step mode
> to a ptrace or other debug API.  If for some strange reason
> the standard emulation mechanism isn't adequate for you
> (e.g. if your applicaiton is executing out of ROM), you
> do have this as a potential alternative.  But it would not
> be a trivial hack.


Well this is ok ..but I am trying to implement kenel debugger..
something like system tap.
And I have started with kprobe..
where the kernel code execution will be stopped at user specified
address using break, how do i single step that instruction to decode
the instruction and print the registers value..?


~Nida
