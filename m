Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2008 19:36:05 +0000 (GMT)
Received: from gv-out-0910.google.com ([216.239.58.187]:27403 "EHLO
	gv-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S22677151AbYJ2Tf6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 29 Oct 2008 19:35:58 +0000
Received: by gv-out-0910.google.com with SMTP id e6so108405gvc.2
        for <linux-mips@linux-mips.org>; Wed, 29 Oct 2008 12:35:55 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=COGo7nlDIuYZ3g+FoQRlzrIHPMaJMLC12eAFKcJLTT8=;
        b=yC4KzEZ4+CjyWI0+a9xzScNf0v/zyoBUIGyss/yGiMn2VrX05gLVeq0cDNp083vleD
         oUVu4ENK3VO/jM+xqGuap0BDbohOZcCl/JiNyhRfdm82tIgqsGJi86FkSAwDmuUX6me/
         tacdWYiO/rriFT1v70OXz3ie4uSSoUUEmBQkw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=HhIc+rUGw4SS7Z96UfzEI9hccYKz2VmDRqWV6LpUKiOwg7qHqo2VdzWgtQrf5e9ERO
         miOTwCiQWXUbVv8jkYHKDcv2OvlG4FvVRJaaG1pqifpMW0RMimDAVHEGvLXRSHQmEnwC
         CSLm1R4xtNXKVeS7NxsTfo1tyNkSrdbOAOC2g=
Received: by 10.103.244.19 with SMTP id w19mr4402139mur.68.1225308531576;
        Wed, 29 Oct 2008 12:28:51 -0700 (PDT)
Received: from ?192.168.123.7? (chello089077041080.chello.pl [89.77.41.80])
        by mx.google.com with ESMTPS id j10sm599903mue.17.2008.10.29.12.28.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 29 Oct 2008 12:28:50 -0700 (PDT)
From:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/2] tx4938ide: Do not call devm_ioremap for whole 128KB
Date:	Wed, 29 Oct 2008 20:12:32 +0100
User-Agent: KMail/1.9.10
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org,
	linux-ide@vger.kernel.org, ralf@linux-mips.org
References: <20081027.223939.59650930.anemo@mba.ocn.ne.jp> <4906542A.9090905@ru.mvista.com>
In-Reply-To: <4906542A.9090905@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200810292012.33069.bzolnier@gmail.com>
Return-Path: <bzolnier@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21089
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bzolnier@gmail.com
Precedence: bulk
X-list: linux-mips

On Tuesday 28 October 2008, Sergei Shtylyov wrote:
> Hello.
> 
> Atsushi Nemoto wrote:
> > Call devm_ioremap() for CS0 and CS1 separetely.
> > And some style cleanups.
> >
> > Suggested-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> > Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> >   
> 
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied
