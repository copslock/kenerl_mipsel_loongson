Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 May 2006 09:37:19 +0200 (CEST)
Received: from nf-out-0910.google.com ([64.233.182.188]:59758 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S8133487AbWEaHhM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 31 May 2006 09:37:12 +0200
Received: by nf-out-0910.google.com with SMTP id b2so139367nfe
        for <linux-mips@linux-mips.org>; Wed, 31 May 2006 00:37:06 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KTvnLEpzBkGsePsh6W6/xPxSC2ryphw/2eOxc0pv53ueJQaqI4vB72N3fQSeDgnVOHKL79KEW+HmcKchfTEU49E0NI1//+htAGCbqJDJQsE3q2dPQMArj+tENYoWd88xc2TlyiFmaGdCbDhIZIZ64nRDmyhNFR65NcY2wppwwOQ=
Received: by 10.48.225.3 with SMTP id x3mr523173nfg;
        Wed, 31 May 2006 00:35:42 -0700 (PDT)
Received: by 10.66.241.4 with HTTP; Wed, 31 May 2006 00:37:04 -0700 (PDT)
Message-ID: <50c9a2250605310037n42dd6ddct2238cf9c56eac40d@mail.gmail.com>
Date:	Wed, 31 May 2006 15:37:04 +0800
From:	zhuzhenhua <zzh.hust@gmail.com>
To:	"Kevin D. Kissell" <KevinK@mips.com>
Subject: Re: how to disable interrupt in application?
Cc:	"Bin Chen" <binary.chen@gmail.com>,
	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <002a01c6847f$98409480$0602a8c0@Ulysses>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <50c9a2250605301733t788c16f9k739c17e4a6a4efee@mail.gmail.com>
	 <5800c1cc0605302311p2d1f024bm96ac6e08cda1bc2f@mail.gmail.com>
	 <002a01c6847f$98409480$0602a8c0@Ulysses>
Return-Path: <zzh.hust@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11614
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zzh.hust@gmail.com
Precedence: bulk
X-list: linux-mips

On 5/31/06, Kevin D. Kissell <KevinK@mips.com> wrote:
> sigprocmask manages signals, which are user-mode abstractions
> of exceptions.  It does not affect hardware interrupt behavior.
> If by "uninterruptable", ZhuZhenHua means that the decoder
> process will not get switched out in favor of another user-mode
> process, then getpriority()/setpriority() provide some control
> that may be sufficient.  If what is desired is that hardware interrupts
> are actually masked during some critical sequence, the critical
> sequence must be executed with kenel privilege - you need to
> look at putting the critical sequence into a driver or other loadable
> kernel module that can be invoked by the application code.
>
>             Regards,
>
>             Kevin K.
>
> ----- Original Message -----
> From: "Bin Chen" <binary.chen@gmail.com>
> To: "zhuzhenhua" <zzh.hust@gmail.com>
> Cc: "linux-mips" <linux-mips@linux-mips.org>
> Sent: Wednesday, May 31, 2006 8:11 AM
> Subject: Re: how to disable interrupt in application?
>
>
> > man sigprocmask
> >
> > On 5/31/06, zhuzhenhua <zzh.hust@gmail.com> wrote:
> > > our project have a video decoder code run as application. there is
> > > some short code want to be run uninterruptable. is there anyway to do
> > > it?
> > > thanks for any hints
> > > Best Regards
> > >
> > >
> > > zhuzhenhua
> > >
> > >
> >
> >
>

actually i don't want the pipelining be interrupted while run our user
define instructions.
