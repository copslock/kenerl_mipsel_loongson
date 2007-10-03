Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Oct 2007 14:04:41 +0100 (BST)
Received: from el-out-1112.google.com ([209.85.162.182]:51629 "EHLO
	el-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20023983AbXJCNEc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 3 Oct 2007 14:04:32 +0100
Received: by el-out-1112.google.com with SMTP id n30so997981elf
        for <linux-mips@linux-mips.org>; Wed, 03 Oct 2007 06:03:30 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Vog8NQcvnqtL55mvMYvpNDHLvWw0uO8Z27PGwORJvR8=;
        b=RoiYGxZuWVtKka+QbGw+rD/LRDymQsjpdXstBtPhl0ZQlu6edgCabyFRyiz5r6LFCoHyXlCM/xf8kPn8r8IDVH6bVar+8LGz1g7hRviTwvr9RPPGgMV0QpoV6rMiam8HQUs5fFMuje7rXAEj4w4cCxO+Hl8z6HnHZAAzmW9E7eY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=di/Kk0iKARlmAUcONoKxin59v6OMjOOn/bk8cS9VNrlk5DGt4SEZCYEhmhx8a8kfj3vOEcp7iKUDB+zecPH0b6hLQ1gzzXZlGz1c8+OQE2mc2mSPJpPj1HsH2JU3a3wViuHO5o/oDNTyuX5rckqVVCtBQy2i4vHMjRMeldESFBs=
Received: by 10.142.111.14 with SMTP id j14mr664890wfc.1191416215487;
        Wed, 03 Oct 2007 05:56:55 -0700 (PDT)
Received: by 10.141.129.12 with HTTP; Wed, 3 Oct 2007 05:56:55 -0700 (PDT)
Message-ID: <41370a610710030556k5435b547sfc0e8210fe3966a5@mail.gmail.com>
Date:	Wed, 3 Oct 2007 07:56:55 -0500
From:	"Ed Stafford" <ed.stafford@gmail.com>
To:	Kumba <kumba@gentoo.org>
Subject: Re: What is the current state of the Octane/IP30 support?
Cc:	linux-mips@linux-mips.org
In-Reply-To: <47033156.7090703@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <41370a610710021341g749742dejec06b3a38477fd47@mail.gmail.com>
	 <47033156.7090703@gentoo.org>
Return-Path: <ed.stafford@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16823
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ed.stafford@gmail.com
Precedence: bulk
X-list: linux-mips

On 10/3/07, Kumba <kumba@gentoo.org> wrote:
> Right now, Gentoo does have the best support for them (mine is running
> 2.6.23-rc5 about 3.5ft from me as I type).  But I do believe the debian guys
> have been working on a debian install image for them too (tbm/ths, am I right on
> this?)
>
> For the most part, Impact-based systems run great.  You get X, unaccelerated, no
> 3D, and a framebuffer.  VPro, framebuffer, but no X.  USB kinda weorks if you
> have a PCI-Card Cage and a OHCI chipsets (UHCI is dead last I checked), and I
> think EHCI works fine.  Haven't tried much else beyond those PCI devices.

I had wondered about being able to use any PCI card in that cage..
I'll have to give that a shot.

> A lot of the other XIO Boards, outside of the Impact or Vpro boards, are wholly
> untested, and likely won't work at all.  Nor do I think dual head will work if
> you have a second Impact card kicking around.
>
> For gentoo, we have an "RC6" livecd.  I've played with building an RC7 several
> times, but that got sidetracked about 2-3 months ago.  I hope to resume work on
> it soon.  You can find that and the current netboots on your local gentoo
> mirror, in the experimental/mips sub-folders.
>
> Further gentoo questions regarding this system should be directed to the
> gentoo-mips ML; linux-mips here is more for distro-agnostic development.
>
> Have fun!  (and what Proc, btw?)

Single 195MHz.  I've been looking at a dual-360MHz, but it's tough to
win those auctions!

Ed
