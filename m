Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Oct 2009 03:53:58 +0100 (CET)
Received: from mail-gx0-f210.google.com ([209.85.217.210]:41658 "EHLO
	mail-gx0-f210.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1491892AbZJ3Cxw (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 30 Oct 2009 03:53:52 +0100
Received: by gxk2 with SMTP id 2so1896106gxk.4
        for <linux-mips@linux-mips.org>; Thu, 29 Oct 2009 19:53:43 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=wBm07KGaWYhFXGidDGupSZfrNKJQgP2TSy5wLxyBcpg=;
        b=O2g7HR1abuar89n9GOsYNU3ixOnU5+GTpr4EVGn0SRAdWjw1ZUfq4KqIKDALgOFKC1
         XRQUw8BESq/xImxEjRKID2fwRRR87MuMypeBNK03kmnI5w6OBd7IE92rus0b817doFUF
         ikVtsaVQMcP/UnqfnaPVrGPPWfDvYoBkmXifc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=PaK/iMTKyDammhOYayyNGsIJ2upKLoft+5RF4sMo4kYHdrDN3i6SAVVrrfViZXzDmS
         4luT4OVcQi/IHwd4kuRs1shxqomxvWoe4033RieP4jrrPefxe0p1E+TpkRAjj1mGbElr
         xBGw7NGW7kdzA/yLmLHAZBbmZWHzixP4Cx3kM=
Received: by 10.91.203.25 with SMTP id f25mr2825753agq.13.1256871223681;
        Thu, 29 Oct 2009 19:53:43 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 6sm1181035yxg.48.2009.10.29.19.53.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 29 Oct 2009 19:53:43 -0700 (PDT)
Subject: Re: [PATCH -v1] MIPS: a few of fixups and cleanups for the
 compressed  kernel support
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Chih-hung Lu <winfred.lu@gmail.com>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>
In-Reply-To: <a2dc26810910291916x1556eb21uecaa8bdeeb98baae@mail.gmail.com>
References: <1256797212-7794-1-git-send-email-wuzhangjin@gmail.com>
	 <a2dc26810910291916x1556eb21uecaa8bdeeb98baae@mail.gmail.com>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Fri, 30 Oct 2009 10:53:36 +0800
Message-Id: <1256871216.5444.34.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24586
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Fri, 2009-10-30 at 10:16 +0800, Chih-hung Lu wrote:
> 2009/10/29 Wu Zhangjin <wuzhangjin@gmail.com>:
> > From: Wu Zhangjin <wuzhangjin@gmail.com>
> >
> > This patch indents the instructions in the delay slot of the file which
> > has a ".set noreorder" added.
> >
> > and also, the "addu a0, 4" instruction is replaced by "addiu a0, a0, 4".
> Hi,
> 
> May I ask a question,
> what is the difference between "addu a0, 4" and "addiu a0, a0, 4"?
> They look same to me.

Hello,

Although they function the same under gas("addu a0, 4" will be assembled
to "addiu a0, a0, 4"), but herein is exactly an immediate data
operation, I just keep it be what it is! only a "cleanup" here.

Thanks & Regards,
	Wu Zhangjin
