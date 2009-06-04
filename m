Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jun 2009 17:06:26 +0100 (WEST)
Received: from mail-pz0-f202.google.com ([209.85.222.202]:45489 "EHLO
	mail-pz0-f202.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20022524AbZFDQGS (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 4 Jun 2009 17:06:18 +0100
Received: by pzk40 with SMTP id 40so880401pzk.22
        for <multiple recipients>; Thu, 04 Jun 2009 09:06:10 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=uDK6YOE/i5aEXqWgWJHb2WhLJN/mFXjTxufD66/EDgw=;
        b=lYxeZ/PVZB+qlPjymsTKAHXB653INosLqRVg/mAL0obn8uiZxViLN9OZ4bTCGBjOC1
         sJjpNvdj+jwFb6kbDgYSAsDi82WK0S+gLNHTg8LCPKkdOnr+NB5kgpKCQ4roZMwJ9g/c
         +VWJWM9N6aMEJz53zFyiFpPRwhRf2/Q/xUeDU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=uDFzSTvSmi4xLDoQwczUt7HhCVjuW+iMIsmejcB80VTM9dMiFxD9AQaMAEiyORxAMQ
         Z4bmSguxBK0mOSdoPh+dHJEbth4Nrgg3uJh3xAQphwGDkiYT3L75BkIeG/+ucHpXuZ64
         jIHfHf5lG6H1nXdlU7vKUJlvTH4xyq0L6FgIQ=
Received: by 10.114.88.1 with SMTP id l1mr3668618wab.97.1244131570421;
        Thu, 04 Jun 2009 09:06:10 -0700 (PDT)
Received: from ?192.168.2.239? ([202.201.14.140])
        by mx.google.com with ESMTPS id m6sm11395726wag.14.2009.06.04.09.06.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Jun 2009 09:06:09 -0700 (PDT)
Subject: Re: [PATCH-v2] Hibernation Support in mips system
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	apatard@mandriva.com, yanh@lemote.com, zhangfx@lemote.com,
	pavel@ucw.cz, huhb@lemote.com
In-Reply-To: <20090605.002833.39155438.anemo@mba.ocn.ne.jp>
References: <9c9bc070f3c272c41254304537e9dec398245b94.1244118419.git.wuzj@lemote.com>
	 <20090605.002833.39155438.anemo@mba.ocn.ne.jp>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Fri, 05 Jun 2009 00:06:02 +0800
Message-Id: <1244131562.32116.19.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23286
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Fri, 2009-06-05 at 00:28 +0900, Atsushi Nemoto wrote:
> On Thu,  4 Jun 2009 20:27:10 +0800, wuzhangjin@gmail.com wrote:
> > From: Wu Zhangjin <wuzj@lemote.com>
> > 
> > This is pulled from the to-mips branch of
> > http://dev.lemote.com/code/linux_loongson, the original author is Hu
> > Hongbing from www.lemote.com
> 
> I have successfully suspended to disk on malta qemu.  Thanks!

thanks very much for your testing :-)

Wu Zhangjin
