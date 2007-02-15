Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Feb 2007 08:38:02 +0000 (GMT)
Received: from qb-out-0506.google.com ([72.14.204.235]:58385 "EHLO
	qb-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20037879AbXBOIh5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 15 Feb 2007 08:37:57 +0000
Received: by qb-out-0506.google.com with SMTP id e12so123916qba
        for <linux-mips@linux-mips.org>; Thu, 15 Feb 2007 00:36:56 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HC1/13Pykf4h5QPJIgIkD65qZrlRK6DbftFvBIPAElUXgc2xmGvPuxfaHPTomU0P3XDu9khlBCIfC9zNwgYq1K1kwta3WZbEQMgMSnaUBWlAn9nP1vuj3HAk9XUyO6nu8cvoh78lmM27f0tQu9rjLM+bduqsQz5SZSgRFZLIm/w=
Received: by 10.114.107.19 with SMTP id f19mr868106wac.1171528616148;
        Thu, 15 Feb 2007 00:36:56 -0800 (PST)
Received: by 10.114.136.11 with HTTP; Thu, 15 Feb 2007 00:36:56 -0800 (PST)
Message-ID: <cda58cb80702150036h6c7a05a5ya8b64250a6083f76@mail.gmail.com>
Date:	Thu, 15 Feb 2007 09:36:56 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH 2/3] Automatically set CONFIG_BUILD_ELF64
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	macro@linux-mips.org
In-Reply-To: <20070215.011420.15247947.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <cda58cb80702130909u2c0cbe8fg6929fc78ca8d3cb8@mail.gmail.com>
	 <20070214.102801.41198530.nemoto@toshiba-tops.co.jp>
	 <cda58cb80702140020l319b987agc88e87c3acaa5e07@mail.gmail.com>
	 <20070215.011420.15247947.anemo@mba.ocn.ne.jp>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14097
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 2/14/07, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> Same here.  I just think introducing one name is better than two name.
> I also feel "make KBUILD_SYM32=0" is more consistent.
>

Yes I agree KBUILD_SYM32 seems better for command line usage but I
think it won't be used widely unlike in code usage where
KBUILD_64BIT_SYM32 is better because it's really self explaned and not
ambigous: "build a 64 bits kernel with 32 bits symbols".

And I think it's more important.

-- 
               Franck
