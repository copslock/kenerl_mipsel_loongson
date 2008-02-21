Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Feb 2008 22:40:40 +0000 (GMT)
Received: from gv-out-0910.google.com ([216.239.58.186]:61398 "EHLO
	gv-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S28576463AbYBUWki (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 21 Feb 2008 22:40:38 +0000
Received: by gv-out-0910.google.com with SMTP id i36so132953gve.2
        for <linux-mips@linux-mips.org>; Thu, 21 Feb 2008 14:40:37 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=13tz0i75ddpiyXhTC1wgeSo7Em7jxOA3nNgbyNRdJPs=;
        b=PIIjFxXjJw0WgJwof5C+mwLn87TN/OASPtmf3QqF/tD25kvRqLfe40v5iYzVCblnnxbmA9C8wFkjbbDIapoPklx3DUalCQIWhKaSMfz9eKXCerysYIxWGTQRfi7gKIe9MrzwC74tesl9J5paTb6XVQYgqYyQ7eIEpxhdv4PHJII=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=r02KIKANtC/SowI3zABubdNa3Ns+pXQ9IBUdDcqjpbKDnLa+lQ9UJsdFoA2Qk22FZiGlTlQwuD8EZe5lXFsn6BpTE1wekcqhi5g66LaV9NxhH2/CiEiR30xRYZulzl/0yr0u/BbU7d1KdZ7S1fKj/mMhfWlP/+8qkcK8lPcNf2o=
Received: by 10.151.41.14 with SMTP id t14mr3380793ybj.55.1203633636307;
        Thu, 21 Feb 2008 14:40:36 -0800 (PST)
Received: by 10.150.138.4 with HTTP; Thu, 21 Feb 2008 14:40:36 -0800 (PST)
Message-ID: <5a8aa6680802211440m1d17be4bsf7a33900c723625a@mail.gmail.com>
Date:	Fri, 22 Feb 2008 00:40:36 +0200
From:	"Michael Wood" <esiotrot@gmail.com>
To:	"Matteo Croce" <rootkit85@yahoo.it>
Subject: Re: Can't execute any MIPS binary
Cc:	linux-mips@linux-mips.org
In-Reply-To: <200802130034.25052.rootkit85@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200802130034.25052.rootkit85@yahoo.it>
Return-Path: <esiotrot@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18287
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: esiotrot@gmail.com
Precedence: bulk
X-list: linux-mips

Hi

On Wed, Feb 13, 2008 at 1:34 AM, Matteo Croce <rootkit85@yahoo.it> wrote:
> Hi,
>  I have a machine, an AR7 MIPS router I want to hack, but I'm unable
>  to run _any_ executable on that machine outside the ones in the firmware.
>  I tried building a static mips1 binary, but it fails so:
>
>  # /var/test.bin
>  /var/test.bin: 1: Syntax error: "(" unexpected

I had the exact same problem.

As far as I remember I had to make sure to build uclibc for MIPS-I,
because if I built a MIPS-I object file and linked it to a uclibc that
was not built for MIPS-I, it would give those errors.

I have just found my change to the OpenWrt wiki (on the WRTP54G page):
http://wiki.openwrt.org/OpenWrtDocs/Hardware/Linksys/WRTP54G?action=diff&rev2=171&rev1=170

-- 
Michael Wood <esiotrot@gmail.com>
