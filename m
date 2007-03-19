Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Mar 2007 13:57:54 +0000 (GMT)
Received: from ag-out-0708.google.com ([72.14.246.245]:34116 "EHLO
	ag-out-0708.google.com") by ftp.linux-mips.org with ESMTP
	id S20021871AbXCSN5t (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 19 Mar 2007 13:57:49 +0000
Received: by ag-out-0708.google.com with SMTP id 22so8234970agd
        for <linux-mips@linux-mips.org>; Mon, 19 Mar 2007 06:57:44 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=p3lIg3+lKJvW96Mtqya3n3+jxwj5OAKkufyM845X7wEScRHbrlZLJCIn3iqSVqsNkSfu6pzC/Fa+gpbqFIX2a3Um65/r3Chkm2xb2BSHKi0DZGF5DhSQGbaO8vVDYmVgpGJREk14IqR81sGnBGT6IMycYJLrvsp5g68pfdQIzPc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FO2yenGz1+DqLFOWUEFXBf73Z7lYsrc44YAuzWRonDeEolpr88apSKoXC7yoHslsbF003FCAgUCkKBFhYJIon6bt3nRYQa0puZvAJRpohALxxK9mHSPktEOooNnWtSfLGxxIjZfbQ6Ozu1b3On8//Bmktvr4gQFIkeXlABeKeRQ=
Received: by 10.90.113.20 with SMTP id l20mr3947637agc.1174312663826;
        Mon, 19 Mar 2007 06:57:43 -0700 (PDT)
Received: by 10.114.136.11 with HTTP; Mon, 19 Mar 2007 06:57:43 -0700 (PDT)
Message-ID: <cda58cb80703190657x7f33f9ffx80982c2591e2e11@mail.gmail.com>
Date:	Mon, 19 Mar 2007 14:57:43 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	Kumba <kumba@gentoo.org>
Subject: Re: IP32 prom crashes due to __pa() funkiness
Cc:	post@pfrst.de, "Linux MIPS List" <linux-mips@linux-mips.org>
In-Reply-To: <45FDC0E0.1050609@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45D8B070.7070405@gentoo.org>
	 <cda58cb80703010139y3e5bbb8eqa4d25b75ba658a22@mail.gmail.com>
	 <45FC3923.2080207@gentoo.org>
	 <Pine.LNX.4.58.0703181006450.396@Indigo2.Peter>
	 <45FDC0E0.1050609@gentoo.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14548
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 3/18/07, Kumba <kumba@gentoo.org> wrote:
>
> Backported the patches that bring in PHYS_OFFSET and tried both with and without
> Frank's patches to remove CONFIG_BUILD_ELF64 from the Makefile, plus this
> change, and still no go.  W/o CONFIG_BUILD_ELF64, both the vmlinux and
> vmlinux.32 targets just silently hang.  With CONFIG_BUILD_ELF64 in the Makefile,
> the same Prom crash.
>

wait wait wait. PHYS_OFFSET has nothing to do in this case. You are
obvioulsy not using it by default.

-- 
               Franck
