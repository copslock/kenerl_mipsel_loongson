Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jun 2007 16:39:50 +0100 (BST)
Received: from py-out-1112.google.com ([64.233.166.176]:38674 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20023203AbXFRPjs (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 18 Jun 2007 16:39:48 +0100
Received: by py-out-1112.google.com with SMTP id f31so3321791pyh
        for <linux-mips@linux-mips.org>; Mon, 18 Jun 2007 08:38:47 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tQw9RS7MzcT9mlGuxj/yLzLLS+CvOwVSi38yBM/nRQiPLoGLh1kqIXhBrW9ZDwZumf3ESj6vWf+rq4AVAcKadQySSy+FXGB7HzMSgzFWFrVvuFaeysLjgmBpqJ+0kmvYqrBJYIG9Ub4GMGsDRTb59AxgsbFaUxQWdfXP9eLwfcs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ns39vvcQWUC7OjXN+eQzbmsooW4wxnuWGnar/GLsQNKJiPB2CvMVrQmos9oKcB2iEZUOgx7J96mAP+mj9sycBxn2QNRN1y2AxUDfykyJrPchSBVfsER9BAzcSUgz/Cmd6+zPL7hMFaBRB0rkjUu5/ws9pmmiyXCFx4CFN9fht3U=
Received: by 10.65.251.17 with SMTP id d17mr9633028qbs.1182181127159;
        Mon, 18 Jun 2007 08:38:47 -0700 (PDT)
Received: by 10.65.204.8 with HTTP; Mon, 18 Jun 2007 08:38:47 -0700 (PDT)
Message-ID: <cda58cb80706180838t4b51c3e4v1392ab4c76773d43@mail.gmail.com>
Date:	Mon, 18 Jun 2007 17:38:47 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: [PATCH 5/5] Implement clockevents for R4000-style cp0 timer
Cc:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
In-Reply-To: <20070618151422.GA4864@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <11818164011355-git-send-email-fbuihuu@gmail.com>
	 <11818164024053-git-send-email-fbuihuu@gmail.com>
	 <20070614.212913.82089068.nemoto@toshiba-tops.co.jp>
	 <20070617000448.GA30807@linux-mips.org>
	 <cda58cb80706180722n18e79a49vfa61450526e6af76@mail.gmail.com>
	 <20070618151422.GA4864@linux-mips.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15450
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi Ralf,

On 6/18/07, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Mon, Jun 18, 2007 at 04:22:39PM +0200, Franck Bui-Huu wrote:
>
> > were an interface for _generic_ rtc only. But all the following
> > platforms don't seem to use the generic rtc though it initialises
> > these function pointers... Any idea why ?
>
> Because unless drivers/char/Kconfig is getting changed to prevent that is
> is possible to enable CONFIG_GEN_RTC, so this code was necessary for
> correctness.

Sorry I don't understand...

> Aside I think it did simply propagate through cutnpaste.
> That at least was the reason in the 2.4 days when the old kernel
> configuration language made it way to painful to deal with such
> configurations.  These days I think we should rather get rid of genrtc.

I think so...

> Genrtc used to be nice candy but like most sweets long term it results in
> caries ;-)

:)

-- 
               Franck
