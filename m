Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Sep 2006 18:12:50 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.171]:17743 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20038770AbWIVRMq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 22 Sep 2006 18:12:46 +0100
Received: by ug-out-1314.google.com with SMTP id 40so327627uga
        for <linux-mips@linux-mips.org>; Fri, 22 Sep 2006 10:12:45 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tY56D9BCc2J3mFzijD2X6EtG9Wi0EQz9OhYoUd7g4Bp/R5hKLPS5L9mj4/vgigXDPle7YFbb1l+TyZ7z37mXR6ZWRXIH9f+TMYN8bLEXPedhSq2immi30HnP412OqkV9UA28+gL5L9FCwVyzaBZd2HitTVPIjGmU7Hi9XOGnaKw=
Received: by 10.66.221.6 with SMTP id t6mr758650ugg;
        Fri, 22 Sep 2006 10:12:45 -0700 (PDT)
Received: by 10.66.242.8 with HTTP; Fri, 22 Sep 2006 10:12:44 -0700 (PDT)
Message-ID: <816d36d30609221012j452e6b03raa1ef1c72bb494d@mail.gmail.com>
Date:	Fri, 22 Sep 2006 13:12:44 -0400
From:	"Ricardo Mendoza" <mendoza.ricardo@gmail.com>
To:	"Yoichi Yuasa" <yoichi_yuasa@tripeaks.co.jp>
Subject: Re: [PATCH] remove tx3912fb
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20060922020202.31b2b537.yoichi_yuasa@tripeaks.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060922020202.31b2b537.yoichi_yuasa@tripeaks.co.jp>
Return-Path: <mendoza.ricardo@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12632
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mendoza.ricardo@gmail.com
Precedence: bulk
X-list: linux-mips

On 9/21/06, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> wrote:
> Hi,
>
> NINO support has already dropped.
> Nothing is using tx3912fb.
>
> Yoichi
>
> Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
>
> ...

Hello Yoichi!

If you don't mind I would ask to keep this driver up, I will soon add
tx3912 support back up because I have a couple PDAs that use it, and
there are still a few boards that run on it.

If any, I'll catch Ralf on IRC later tonight.


     Ricardo
