Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Apr 2009 20:37:37 +0100 (BST)
Received: from mail-fx0-f175.google.com ([209.85.220.175]:16022 "EHLO
	mail-fx0-f175.google.com") by ftp.linux-mips.org with ESMTP
	id S20031470AbZDBTgn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 2 Apr 2009 20:36:43 +0100
Received: by fxm23 with SMTP id 23so742298fxm.0
        for <linux-mips@linux-mips.org>; Thu, 02 Apr 2009 12:36:37 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ZQfV31w9zuzkLmzA7XUgQERtFJttqpSdHX7v8wY990U=;
        b=JI6W0YWIbSPwNaZWA7uBSRy/SjuY6boxmv++eQMT6Z3tNiVXpn45LJHXZgCIsJ+tQa
         IeDJNGbbWPcGe3upWNYNjqdqlZfym4jC0+DRL7tYrGIHRZZ6qNB/rf3m0nXKaJ7qRvhP
         KiVOePfojQl0Jdh3YQgX2wUBJP5s73nhUAu2Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=kp2HqGfvk/OgoZ9tZHfE01ANGLjerVskrYfZMU30Fm2QeFXppEeCUbIJi2+G1slbEg
         iL4iaMBtJUmssggDSnt4h9SNTVl0686GiA4/WlHEnyY80le3TMxbklnqBlBRLJ6UxcDm
         G1Cq0CbqvCsbPnsR9vgoua+0JuJFWIZJhPFs8=
Received: by 10.103.134.8 with SMTP id l8mr109400mun.116.1238700997636;
        Thu, 02 Apr 2009 12:36:37 -0700 (PDT)
Received: from localhost.localdomain (chello089077051219.chello.pl [89.77.51.219])
        by mx.google.com with ESMTPS id 7sm848613mup.19.2009.04.02.12.36.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Apr 2009 12:36:37 -0700 (PDT)
From:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To:	Grant Grundler <grundler@google.com>
Subject: Re: [PATCH] tx4939ide: remove wmb()
Date:	Thu, 2 Apr 2009 21:18:52 +0200
User-Agent: KMail/1.11.1 (Linux/2.6.29-next-20090401; KDE/4.2.1; i686; ; )
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-ide@vger.kernel.org,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
References: <1238516136-15852-1-git-send-email-anemo@mba.ocn.ne.jp> <da824cf30903310936p75469518j9bb28421b1ee81b8@mail.gmail.com>
In-Reply-To: <da824cf30903310936p75469518j9bb28421b1ee81b8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200904022118.52909.bzolnier@gmail.com>
Return-Path: <bzolnier@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22250
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bzolnier@gmail.com
Precedence: bulk
X-list: linux-mips

On Tuesday 31 March 2009, Grant Grundler wrote:
> On Tue, Mar 31, 2009 at 9:15 AM, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> > * define CHECK_DMA_MASK
> > * remove use of wmb()
> >
> > Suggested-by: Grant Grundler <grundler@google.com>
> 
> Thank you for the attribution!
> 
> But I think proper header would be:
>     Reported-by: Grant Grundler <grundler@google.com>
> 
> But in this case, since i've looked at the code and am under the
> illusion I understand it, I'm comfortable with:
>     Reviewed-by: Grant Grundler <grundler@google.com>

Well, you can have both! ;)
