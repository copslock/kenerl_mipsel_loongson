Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Jan 2008 16:29:31 +0000 (GMT)
Received: from nz-out-0506.google.com ([64.233.162.239]:48233 "EHLO
	nz-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20036242AbYACQ3W (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 3 Jan 2008 16:29:22 +0000
Received: by nz-out-0506.google.com with SMTP id n1so1073262nzf.24
        for <linux-mips@linux-mips.org>; Thu, 03 Jan 2008 08:29:21 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=7iGJZYtd3Oxd1dI5P+I+PCP38pQm1rSPWGpq3ZtQrrY=;
        b=EMaaw4yv+1SImmmu5EiVsVqGtV6hSR+PL9ktx1czeXXBfFmfKVQqJLHSG4T82umDGwf7uWGxQFwnsXg2VEgfqeM8SnRnkQDW+f4z8x77gBuOxSK6ExOquZD9lDq4YPDBhTgXz1pJ2aBDVTyEFFkJo13DSf0Q+/DRyW5AIwotmss=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KbP8wUaQZ+xyqxgBYivIcnVf9oITYZBVeQwEOLJASqatHwj0sSNmj0HWmTqryfdhxpLIwDyv5nsiAv4eR0EyCcLLqzQKa8yv+QoTXEN+nKNiom9FF4qmzfWJUjmJL9NR8ZBlNOJnBxv6Ou43/VszfKHamFeyAWSP3N+VvskMivw=
Received: by 10.142.214.5 with SMTP id m5mr4617053wfg.143.1199377761040;
        Thu, 03 Jan 2008 08:29:21 -0800 (PST)
Received: by 10.142.104.1 with HTTP; Thu, 3 Jan 2008 08:29:21 -0800 (PST)
Message-ID: <767364c50801030829qd4e1be9g5f14d3d1814816d7@mail.gmail.com>
Date:	Thu, 3 Jan 2008 17:29:21 +0100
From:	"Sunil Amitkumar Janki" <devel.sjanki@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Re: 2.6.24-rc6 ssb build error
In-Reply-To: <767364c50801030815t1be0a58hd13af6a05b7ca3c5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <767364c50801030815t1be0a58hd13af6a05b7ca3c5@mail.gmail.com>
Return-Path: <devel.sjanki@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17908
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: devel.sjanki@gmail.com
Precedence: bulk
X-list: linux-mips

On Jan 3, 2008 5:15 PM, Sunil Amitkumar Janki <devel.sjanki@gmail.com> wrote:
> I've built 2.6.24-rc6 for 32-bit MIPS and got the following error when
> building the ssb driver, probably because it has only been tested on
> x86. I will disable the driver for now and rebuild.
>

I forgot to include the error message:

ERROR: "pcibios_enable_device" [drivers/ssb/ssb.ko] undefined!
ERROR: "register_pci_controller" [drivers/ssb/ssb.ko] undefined!
make[1]: *** [__modpost] Error 1
make: *** [modules] Error 2

Regards,
Sunil
