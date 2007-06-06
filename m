Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jun 2007 07:33:50 +0100 (BST)
Received: from py-out-1112.google.com ([64.233.166.181]:58638 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20021435AbXFFGds (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 6 Jun 2007 07:33:48 +0100
Received: by py-out-1112.google.com with SMTP id f31so79514pyh
        for <linux-mips@linux-mips.org>; Tue, 05 Jun 2007 23:33:47 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aQVLoJx6qYHmrvXQLXpWztl2/zHl1RUK/tvRAxPpDA9rqqtgJEPF0WysuwadCwDozYiH5tAHucyUfmhYQnqwl1kXiVkM3uJSohfrCt8pv5dZJCIR9ExPn0+1c4F/lKLqGYyKI1zKfw97JGCd4zQJeRrUpE/46gOaMD9XbtPUz98=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DVL8/+Boat4cWTT1+ggSlwp48s2yvr/wmyWC80bHnFdxlmJVegw2Qf852WtgTb5vW4jvQ1aqr4xnBUy5DbUFruEhas2NjlDF25cbQ+djO4oRaUuqojgFxYLdW8MvT7rnTGJ4gFJq/oQaMiXHN6RrXnUpacqNEhA2M6FgUfdpyvg=
Received: by 10.65.239.14 with SMTP id q14mr313981qbr.1181111625981;
        Tue, 05 Jun 2007 23:33:45 -0700 (PDT)
Received: by 10.65.241.19 with HTTP; Tue, 5 Jun 2007 23:33:45 -0700 (PDT)
Message-ID: <cda58cb80706052333i3255943aw674028f4e5559249@mail.gmail.com>
Date:	Wed, 6 Jun 2007 08:33:45 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	Tian <tiansm@lemote.com>
Subject: Re: Mailing patches
Cc:	"Ralf Baechle" <ralf@linux-mips.org>, Kumba <kumba@gentoo.org>,
	linux-mips@linux-mips.org
In-Reply-To: <4666418C.9040401@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20070604133551.GA24405@linux-mips.org> <4664DB12.80906@gentoo.org>
	 <20070605152338.GA22937@linux-mips.org> <4666418C.9040401@lemote.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15279
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

On 6/6/07, Tian <tiansm@lemote.com> wrote:
>
> --no-chain-reply-to or --chain-reply-to ?

Usually "--no-chain-reply-to" is used and I think it's easier to
discuss on the patchset with this option.

>
> and.....should i resend the patches?

Does your patchset have order depedency ? if so, I think you should.

-- 
               Franck
