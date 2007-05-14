Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 May 2007 08:55:04 +0100 (BST)
Received: from py-out-1112.google.com ([64.233.166.176]:45783 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20022639AbXENHzC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 14 May 2007 08:55:02 +0100
Received: by py-out-1112.google.com with SMTP id u52so1380685pyb
        for <linux-mips@linux-mips.org>; Mon, 14 May 2007 00:55:01 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=b4HU3aiKXEhUWwEpowd5HfH49QsqDlKVW5qbw/4RciwkOfqeqTk1Lyn81E34GjeHiIzkDq9FaIPnSX36yv1mgTapTmuetiq9pMIhHq7a7pLEIzR2t2aHxrSCGkiOFBtnMD3UsqINOImK+Q148eg5VzsazmYCFguifEHQaKIkXgc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tPub4Tu6FBPb8y5jZRj7Xs7lmQCZ3LpsD7T+CHHjal34+bIFJPIw9M1T2rB/L2dLFpezDuLvfNF84w0dXcgrkHz1H3Rq5gC84BCgNlKfQfDXrN+xBqhDqFHEOZ/flWh5Z6VsPcf24jB/DnCUkLbzQFNXeAuxjoioRYm3bCxBhIk=
Received: by 10.65.248.19 with SMTP id a19mr9768430qbs.1179129301373;
        Mon, 14 May 2007 00:55:01 -0700 (PDT)
Received: by 10.65.241.19 with HTTP; Mon, 14 May 2007 00:55:01 -0700 (PDT)
Message-ID: <cda58cb80705140055r1c3d8431v7be5f805d7dea1db@mail.gmail.com>
Date:	Mon, 14 May 2007 09:55:01 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] MIPS: Run checksyscalls for N32 and O32 ABI
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org, sam@ravnborg.org
In-Reply-To: <20070514.164650.126759873.nemoto@toshiba-tops.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <cda58cb80705111223y5e94eafcy710b878517c48c48@mail.gmail.com>
	 <20070513.014713.74753298.anemo@mba.ocn.ne.jp>
	 <cda58cb80705140023w2829d86y662e6fa957b3734c@mail.gmail.com>
	 <20070514.164650.126759873.nemoto@toshiba-tops.co.jp>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15056
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 5/14/07, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> On Mon, 14 May 2007 09:23:08 +0200, "Franck Bui-Huu" <vagabon.xyz@gmail.com> wrote:
> > > +arch-missing-syscalls: prepare1
> >
> > Why did you add 'prepare1' dependency ?
>
> Without that, fresh build will fail because missing-syscalls target
> requires include/asm, etc.
>

yes but from top makefile, we already have this depedency:

        $ grep archprepare: Makefile
        archprepare: prepare1 scripts_basic

-- 
               Franck
