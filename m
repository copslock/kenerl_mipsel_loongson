Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Nov 2005 09:14:05 +0000 (GMT)
Received: from zproxy.gmail.com ([64.233.162.194]:14399 "EHLO zproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133430AbVKIJNo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 9 Nov 2005 09:13:44 +0000
Received: by zproxy.gmail.com with SMTP id l8so120274nzf
        for <linux-mips@linux-mips.org>; Wed, 09 Nov 2005 01:15:07 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QOMqbZkvwGj7HpA4qDpH/fQmIMreowiBQxU1nNFZaOvSe2N8YQQNJhEGS6xJvfqqCtXtrI9BtFrCegnEoCHElxuXghICVN7Y1BH+gRKkcSLHlkivXRZQC2ucwqGq/+AiR6NT4N0ajemDsIcEVdbQmU+I2boS+Z2vxqjQGmJ/Z9Q=
Received: by 10.37.14.30 with SMTP id r30mr313733nzi;
        Wed, 09 Nov 2005 01:15:07 -0800 (PST)
Received: by 10.36.47.8 with HTTP; Wed, 9 Nov 2005 01:15:07 -0800 (PST)
Message-ID: <cda58cb80511090115h464b3e8fp@mail.gmail.com>
Date:	Wed, 9 Nov 2005 10:15:07 +0100
From:	Franck <vagabon.xyz@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: git and tags...
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20051108184521.GB2689@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <cda58cb80511080249w7d902821n@mail.gmail.com>
	 <20051108110134.GA2689@linux-mips.org>
	 <cda58cb80511080925l2d441604i@mail.gmail.com>
	 <20051108184521.GB2689@linux-mips.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9456
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

2005/11/8, Ralf Baechle <ralf@linux-mips.org>:
> On Tue, Nov 08, 2005 at 06:25:06PM +0100, Franck wrote:
>
> > OK, so tags have been renamed into "linux-2.6.x". Why not using the
> > same mainline name convention (v2.6.x) ?
>
> The same reason that some people like blue and others prefer green ;-)
>

yet, mips branch follows mainline coding style...Actually it's just
more convenient to remember only one tag name convention. Anyways....

> > I have another question (which is the first one in my previous email),
> > how can I make my working tree a kernel version 2.6.9 for example ?
>
> git-read-tree $(cat .git/refs/tags/linux-2.6.9)
> git-checkout-index -f -a -u -q
>

thanks for that

> > And the last question related to mips git repository, why does kernel
> > v2.2, v2.4, v2.6 are in the same repository ? Why not seperate
> > different major version of the kernel in a seperate repository ?
>
> The extra space consumption for all these historic versions in a
> compressed git repository is extremly little.
>

hmm...still I get:

# du linux-mips.git/.git
263M
# du linux-mainline.git/.git
104M

Thanks
--
               Franck
