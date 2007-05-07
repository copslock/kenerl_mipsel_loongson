Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 May 2007 11:09:08 +0100 (BST)
Received: from wr-out-0506.google.com ([64.233.184.224]:48216 "EHLO
	wr-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20021928AbXEGKJG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 7 May 2007 11:09:06 +0100
Received: by wr-out-0506.google.com with SMTP id q50so1555911wrq
        for <linux-mips@linux-mips.org>; Mon, 07 May 2007 03:08:05 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=j0dAkv4fnT1g01eKe4/0j7u2jLnnlc6VtTpIXhrUJ0x3cO2/0oXwhSjfdPrFHCYzmVekX0eA0tfh20gZt2mbK6HXM9PEbHG+Hbphpn/3IV15+9n/xXYaPe+O/Yskbdd6pDg/Qx2RmxpRNmLeLhJA1aamtn1Jx0gB6TVkyixc61M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=raAbReImDrvq6GS1qMrUQbOSRURo2Xo4ypbjyi0hsaVc9AVKCBXibKirGCWHhwT/StjaNYFoXQQqL/XuZvShAWrW+gzY/oLDpBw6UPM00ZN118giiu8HgOn06HBjNpzGp5X/WE2I0MzWfFTH1Je/D/cvk+BJn4fjFVnaiatgg8Q=
Received: by 10.114.75.1 with SMTP id x1mr140829waa.1178532485029;
        Mon, 07 May 2007 03:08:05 -0700 (PDT)
Received: by 10.115.94.16 with HTTP; Mon, 7 May 2007 03:08:04 -0700 (PDT)
Message-ID: <cda58cb80705070308g7ac76ef2o79bec6fd5f6f8fb1@mail.gmail.com>
Date:	Mon, 7 May 2007 12:08:04 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH 2/3] time: replace board_time_init() by plat_clk_setup()
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
In-Reply-To: <20070507.182837.126143175.nemoto@toshiba-tops.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <11782930063123-git-send-email-fbuihuu@gmail.com>
	 <20070506.010313.41199101.anemo@mba.ocn.ne.jp>
	 <cda58cb80705070150u75165c47n252a664fc92646f3@mail.gmail.com>
	 <20070507.182837.126143175.nemoto@toshiba-tops.co.jp>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14971
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 5/7/07, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
>
> Well, I have not looked closer those hackish board_time_init functions
> yet.  Maybe we can do the cleanups, but frankly, now I think it is a
> time for removal of them.
>

Amen.

Unfortunately I don't know and don't have any idea if it's now a good
thing to get rid of these 2 board supports...

Maybe submitting a patch to linux-mips which does that could be a good start...

Let's see...
-- 
               Franck
