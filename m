Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Oct 2009 07:54:08 +0200 (CEST)
Received: from mail-px0-f187.google.com ([209.85.216.187]:64316 "EHLO
	mail-px0-f187.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492048AbZJOFyB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 15 Oct 2009 07:54:01 +0200
Received: by pxi17 with SMTP id 17so597896pxi.21
        for <multiple recipients>; Wed, 14 Oct 2009 22:53:53 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=PvrDVXLI052dFvzyzX5zhhof2R4cGnajjXlh+bE7Vhs=;
        b=f8+Ur9I6OGfJAzSgCenmOpPGvgY7DG2ZoMSSpYBY1ClFBbYRP9ZdWJTFBCgEXuoxtE
         CGxhMsiQ5bZLxYChjSXw58SFQCfzDR1XsN7Rk3J2DFk976+3l5zCB/aKadhd1nPCLRsv
         cdufLAwAJ8Txi87nLl6hpI1neE+8g38irkV7k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=jEvPNqXQGZtHT4TBOwbVqdukdsTJ1PtEGOCCTiYzDIUBFVEJmL2tlpdY/rtEA1YTQy
         hvd4jveJd0pSvvftZU+GgHQlHhbNXO9Q7T+cKi5+V26tTq7RAXS7BbL9tBBquyQcdZ7Q
         Wt9s4fsfh+w42burYDQDiv9Wjd3QyDalwkcjM=
Received: by 10.114.250.2 with SMTP id x2mr6530838wah.7.1255586033891;
        Wed, 14 Oct 2009 22:53:53 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 23sm56065pxi.9.2009.10.14.22.53.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 14 Oct 2009 22:53:50 -0700 (PDT)
Subject: Re: [PATCH] MIPS: zboot: make the vmlinuz be fresh all the time
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Manuel Lauss <manuel.lauss@googlemail.com>,
	linux-mips@linux-mips.org
In-Reply-To: <20091014114403.GA28514@linux-mips.org>
References: <1255518712-14666-1-git-send-email-wuzhangjin@gmail.com>
	 <20091014114403.GA28514@linux-mips.org>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Thu, 15 Oct 2009 13:53:39 +0800
Message-Id: <1255586019.11221.5.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24336
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi Ralf,

I have updated my git repository to your master branch, and plan to push
the basic support of fuloong2f to you and also the linux-mips mailing
list, is it okay? any suggestion?

and of course, will not push a bunch of them, only 3 or 5 patches one
time.

Thanks & Regards,
	Wu Zhangjin 

On Wed, 2009-10-14 at 13:44 +0200, Ralf Baechle wrote:
> On Wed, Oct 14, 2009 at 07:11:52PM +0800, Wu Zhangjin wrote:
> 
> Thanks, folded into the existing compression patch.
> 
>   Ralf
