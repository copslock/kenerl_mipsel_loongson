Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Dec 2006 00:58:19 +0000 (GMT)
Received: from nf-out-0910.google.com ([64.233.182.191]:53426 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20039561AbWLLA6P (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 12 Dec 2006 00:58:15 +0000
Received: by nf-out-0910.google.com with SMTP id l24so73437nfc
        for <linux-mips@linux-mips.org>; Mon, 11 Dec 2006 16:58:07 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dter0MhAnz5/Mec/jkvYNqFLPzEic06efpxzTHZCJ7BPzevc7r4V20A31/ja4/Q7C5DcZcJquYMtD1FQdC5C7FEIxbHGSJXkDADheDIM7cL3HOxGV+T1dlj+AJBYl7v84hByv7s8K9c0qN2q9dnBxrR7PeYPaw+FH8tiMaMBAVY=
Received: by 10.82.105.13 with SMTP id d13mr1196885buc.1165885087427;
        Mon, 11 Dec 2006 16:58:07 -0800 (PST)
Received: by 10.82.178.4 with HTTP; Mon, 11 Dec 2006 16:58:06 -0800 (PST)
Message-ID: <50c9a2250612111658t50c5cdcdtd6831101d4316e2e@mail.gmail.com>
Date:	Tue, 12 Dec 2006 08:58:06 +0800
From:	zhuzhenhua <zzh.hust@gmail.com>
To:	"Philippe De Swert" <philippedeswert@scarlet.be>
Subject: Re: hwo to improve a video decoder program's timeslice
Cc:	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <JA4FU5$15B25B9E0AEC49C3D47C4ABD5469CF70@scarlet.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <JA4FU5$15B25B9E0AEC49C3D47C4ABD5469CF70@scarlet.be>
Return-Path: <zzh.hust@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13431
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zzh.hust@gmail.com
Precedence: bulk
X-list: linux-mips

On 12/12/06, Philippe De Swert <philippedeswert@scarlet.be> wrote:
> Hi,
>
> >  i have a video decoder program run as aplication
> > and i now have change the HZ from 1000 to 100, set the decoder program
> > priority as 99.
>
> Seems you are mixing things here... The HZ change will just change the
> interval of the timer tick. For some more explanations about this, look here :
> http://kerneltrap.org/node/464
>
> > if i want to the video decoder program to get more time to run, is
> > there any other way to improve it ?
>
> Maybe using nice? Try "man nice" in a terminal on your Linux box to get more
> explanations about this.
thanks, i have try nice already, there's not too much change.

>
> Cheers,
>
> Philippe---
> Scarlet ONE -  Combine ADSL with unlimited fixed phone and save 400 euros
> http://www.scarlet.be
>
>
