Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Feb 2006 00:32:28 +0000 (GMT)
Received: from nproxy.gmail.com ([64.233.182.200]:22724 "EHLO nproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133532AbWB1AcV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 28 Feb 2006 00:32:21 +0000
Received: by nproxy.gmail.com with SMTP id l36so650594nfa
        for <linux-mips@linux-mips.org>; Mon, 27 Feb 2006 16:40:01 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Cs5mtQyb0Wcle4gB5YEMF+HOGLkegKDbkd+ph369d+bprbGRTGdO2uDjl9BVSpC02J5ek+JM4bMy000vPagoeXkbca6af7FiXVo9Gv1OnbIYrY9eElngGvLU/ifxC/YbJqqIqAGxCGGORuFfIba+k5Kk+5ewtIg1c/xGtZKiCko=
Received: by 10.49.17.2 with SMTP id u2mr403310nfi;
        Mon, 27 Feb 2006 16:40:00 -0800 (PST)
Received: by 10.48.249.14 with HTTP; Mon, 27 Feb 2006 16:40:00 -0800 (PST)
Message-ID: <50c9a2250602271640n719af36vbb28b2a55da73617@mail.gmail.com>
Date:	Tue, 28 Feb 2006 08:40:00 +0800
From:	zhuzhenhua <zzh.hust@gmail.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Re: bogus packet in ei_receive of 8390.c
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20060227.224045.93021902.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <50c9a2250602261729q543eb515hff7af85153ac779@mail.gmail.com>
	 <20060227.111020.74752419.nemoto@toshiba-tops.co.jp>
	 <50c9a2250602261910t2241cd14ue877361310e29136@mail.gmail.com>
	 <20060227.224045.93021902.anemo@mba.ocn.ne.jp>
Return-Path: <zzh.hust@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10668
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zzh.hust@gmail.com
Precedence: bulk
X-list: linux-mips

On 2/27/06, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> >>>>> On Mon, 27 Feb 2006 11:10:50 +0800, zhuzhenhua <zzh.hust@gmail.com> said:
>
> >> Even if it is not true ISA, your FPGA should drive ISA-like signals
> >> for the chip.  AC timings of these signals should meet the
> >> requirements of the chip.  I do not know they are configurable or
> >> not.  Do cross-check the 8019 datasheet and the FPGA specification.
>
> zzh> the ethernet just use the sram interface to control IO
>
> So you can check the sram interface's timing satisfy the ethernet
> chip's AC timings.  I have no more idea ...
>
> ---
> Atsushi Nemoto
>

thanks for your advice
i add wsize,rsize =1024 to nfs option now.
though it get bogus packet sometimes, it can work at most time now, i
can run my qt demo via nfs.

zhuzhenhua
