Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 May 2007 16:34:17 +0100 (BST)
Received: from wr-out-0506.google.com ([64.233.184.236]:4787 "EHLO
	wr-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20022059AbXEGPeQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 7 May 2007 16:34:16 +0100
Received: by wr-out-0506.google.com with SMTP id q50so1652044wrq
        for <linux-mips@linux-mips.org>; Mon, 07 May 2007 08:34:15 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=f3IpF2q+DwFTTTNfKgL5ZBv68lLY47O9Ptlup+Yg3ZA8Hdbtx5WGeC2/l8vdkrlWLVqQr5JtUfH4sp6EEG1Ywm40GLe3B9tLiWgNQtc1YK5xtOvH7nYSc5wDznSEEKvGxLODd2VQqyhl9K+NEXzuL4NNNT1mNhUhOddc3ioqXVQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cOD1/Gl50Faqeo6LzLhao7vyQ6uKbFr04xPznwokZdppB507oMp1TcMEV+bc0RsZI9bnYag1bWYoJ0kN+PW5jsFk7Up8vDNFYLra1dgtfTSAbYP8piMhh2mv1CVOPVr1z1KqAYGuPOGiwH6OpHhRqg3ZWYcPL9T5EnjcI3Z9Q6k=
Received: by 10.115.17.1 with SMTP id u1mr2166793wai.1178552053730;
        Mon, 07 May 2007 08:34:13 -0700 (PDT)
Received: by 10.115.94.16 with HTTP; Mon, 7 May 2007 08:34:13 -0700 (PDT)
Message-ID: <cda58cb80705070834m765a968ag528307bd5b60a8e1@mail.gmail.com>
Date:	Mon, 7 May 2007 17:34:13 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Re: [RFC 0/3] Remove Momentum Jaguar and Ocelot G board supports
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
In-Reply-To: <20070508.001714.126573516.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <11785362732731-git-send-email-fbuihuu@gmail.com>
	 <20070508.001714.126573516.anemo@mba.ocn.ne.jp>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14977
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 5/7/07, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
>
> include/asm-mips/mach-ja/ and some lines in include/asm-mips/serial.h
> can be zapped too. :-)

argh, I always forget to look into header file directories !

Rebuilding the patch serie...
-- 
               Franck
