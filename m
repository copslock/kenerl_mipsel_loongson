Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Mar 2007 13:11:08 +0000 (GMT)
Received: from ug-out-1314.google.com ([66.249.92.174]:61536 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20022281AbXCLNLA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 12 Mar 2007 13:11:00 +0000
Received: by ug-out-1314.google.com with SMTP id 40so2511987uga
        for <linux-mips@linux-mips.org>; Mon, 12 Mar 2007 06:09:57 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=PEBY4NiJd+IdC2nXRTU7A1toBoWxo1kfX+nGlUz6HRbplSEJvEEfwuR/oGeOcL/X2udVdzbf85qYXM+V7BYu2Hymob8efZU0kuqI/EHA7MnEglhk6jq0WrgdFd/fbJdv152LiIoW0kxG45h2twpO3J+0ezYj62S7dyaA/7SJCb0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=KMLeDofdZeErdKqsuMc+EqzPirpl15u5EkTv9BZf8FfzyvpRdjHJ0yuaXReWe1lD9SrdSgA5SfVJdkL30XoZv4hyB/qGupHzYCz6TvBHlmeOejE0jG7fbJZjHX0xqKW3d2WrlBEbR7SGo1bsLhQ5NpZSVtQJuGzLoi5KG91fIqg=
Received: by 10.114.60.19 with SMTP id i19mr1494050waa.1173704996106;
        Mon, 12 Mar 2007 06:09:56 -0700 (PDT)
Received: by 10.114.80.18 with HTTP; Mon, 12 Mar 2007 06:09:55 -0700 (PDT)
Message-ID: <d459bb380703120609i7d3a9e1dwf7f4fa431a9631e5@mail.gmail.com>
Date:	Mon, 12 Mar 2007 14:09:55 +0100
From:	"Marco Braga" <marco.braga@gmail.com>
To:	"Domen Puncer" <domen.puncer@telargo.com>
Subject: Re: Trouble with sound/mips/au1x00.c AC97 driver
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20070312103927.GC14658@moe.telargo.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_450_25467147.1173704995987"
References: <20070307104930.GD25248@dusktilldawn.nl>
	 <d459bb380703082322r18879381ma4c57149a8b7adfe@mail.gmail.com>
	 <45F350E9.3020208@cooper-street.com>
	 <d459bb380703120157wb3dde00p4c232e300e82fd3d@mail.gmail.com>
	 <d459bb380703120259r53889966xd8af623ff01ef297@mail.gmail.com>
	 <20070312103927.GC14658@moe.telargo.com>
Return-Path: <marco.braga@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14433
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marco.braga@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_450_25467147.1173704995987
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

2007/3/12, Domen Puncer <domen.puncer@telargo.com>:
>
> It might be ignorance on my part, but aren't au_sync()'s needed here?



My ignorance too.. What's au_sync()? Something to writeback/invalidate the
cache?

------=_Part_450_25467147.1173704995987
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div><span class="gmail_quote">2007/3/12, Domen Puncer &lt;<a href="mailto:domen.puncer@telargo.com">domen.puncer@telargo.com</a>&gt;:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
It might be ignorance on my part, but aren&#39;t au_sync()&#39;s needed here?</blockquote><div><br><br>My ignorance too.. What&#39;s au_sync()? Something to writeback/invalidate the cache?<br><br></div><br></div>

------=_Part_450_25467147.1173704995987--
