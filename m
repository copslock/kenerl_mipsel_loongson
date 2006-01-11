Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jan 2006 15:04:42 +0000 (GMT)
Received: from wproxy.gmail.com ([64.233.184.194]:36220 "EHLO wproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133542AbWAKPEU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 11 Jan 2006 15:04:20 +0000
Received: by wproxy.gmail.com with SMTP id 71so174746wri
        for <linux-mips@linux-mips.org>; Wed, 11 Jan 2006 07:07:26 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TjZf2N6P1+iBm60Ef1Bm67+hUa+ehDozsLkwHWax9t2eR3ZsUekaVRR/q0WcrLrnDurPfRsEqCuEs5J88lbU2WNaZpX7fficMt/mPxSGH2MskY4rS8mCvvJPzZf7mc5WRS6skid2fwJGLucPhuNh3EvTPJW6vgDnf30fvnk2D+A=
Received: by 10.54.83.7 with SMTP id g7mr998314wrb;
        Wed, 11 Jan 2006 07:07:25 -0800 (PST)
Received: by 10.54.69.5 with HTTP; Wed, 11 Jan 2006 07:07:25 -0800 (PST)
Message-ID: <a59861030601110707u16f5d366m@mail.gmail.com>
Date:	Wed, 11 Jan 2006 16:07:25 +0100
From:	Ivan Korzakow <ivan.korzakow@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: why the early_initcall(au1x00_setup) do not work?
Cc:	"P. Christeas" <p_christ@hol.gr>, linux-mips@linux-mips.org
In-Reply-To: <20060111112001.GA4403@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <50c9a2250601082159p238cacd6r930709da9305479e@mail.gmail.com>
	 <200601101757.45297.p_christ@hol.gr>
	 <a59861030601100838oa89ac84n@mail.gmail.com>
	 <200601101857.26978.p_christ@hol.gr>
	 <20060110215322.GA27577@linux-mips.org>
	 <a59861030601110310gca74f54o@mail.gmail.com>
	 <20060111112001.GA4403@linux-mips.org>
Return-Path: <ivan.korzakow@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9857
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ivan.korzakow@gmail.com
Precedence: bulk
X-list: linux-mips

2006/1/11, Ralf Baechle <ralf@linux-mips.org>:
> On Wed, Jan 11, 2006 at 12:10:05PM +0100, Ivan Korzakow wrote:
>
> > It would be great to be a little bit more explicit by giving some
> > _little_ examples ! Why not enlighting us directly instead of being so
> > vague.
>
> In books that kind of stuff is usually marked as "left as an exercise to
> the reader" ;-)

yeah, but we are chating on a forum ;0)

>
>   git-clone rsync://ftp.linux-mips.org/pub/scm/linux.git repository
>   cd repository
>   git-fetch git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6 master:linus
>   git-repack -a -d
>

I know that but you miss my point. GIT is a tool to ease work on linux
kernel, but the way you use it makes harder life of users of your
tree. For example your tree contains more than 350 000 objects ! That
makes a lot of git commands running slow...

Let's say I'm developing a net drivers on ARM platform. I'm actually
do not care about ARM development, but I do care about net tree. To do
that, I just need to clone net tree because I know that ARM should be
OK with this tree. What about MIPS ?

I'm just wondering why not asking to Linus to pull from your tree like
every others maintainers do ?

Ivan
