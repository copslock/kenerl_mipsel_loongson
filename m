Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jun 2007 08:49:45 +0100 (BST)
Received: from nz-out-0506.google.com ([64.233.162.225]:7598 "EHLO
	nz-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20022036AbXFFHtn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 6 Jun 2007 08:49:43 +0100
Received: by nz-out-0506.google.com with SMTP id z3so49912nzf
        for <linux-mips@linux-mips.org>; Wed, 06 Jun 2007 00:48:41 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=S6sPVJcDmAGTvmd8pUrbX5IwTo8AVMi6xBmN/RB3PmfIv0ZADGt5bXrLJYMGG/0I2DWB5+PL8zc3GgrR+BVKYOzfy0pb9scwZkhHGAdz8TS1FJxsy+dAvstHGENTibbla7Nc6rcBMH6Z35RmZiT+pDaWPHpXctpXPwXy8bFZLlk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Jw0TyTtCKLbQYp4yT4KQpVuOayGYT+P9gVR3W5L7TQI/rHwx0by5G1ZEzyCm+NiA/Kvaqc9UCPmQ0SzpraJrUv7mCROtqo/z/Hj8+eBDcvqaLMbyOxuvIhcxHgkPwZwj7b5G93TXtlvPMAg/+s1k5sBwE1tP4FnSApXdczPIfec=
Received: by 10.65.22.9 with SMTP id z9mr371252qbi.1181116121308;
        Wed, 06 Jun 2007 00:48:41 -0700 (PDT)
Received: by 10.65.241.19 with HTTP; Wed, 6 Jun 2007 00:48:41 -0700 (PDT)
Message-ID: <cda58cb80706060048t48b2252dk929394bb2b12ef3e@mail.gmail.com>
Date:	Wed, 6 Jun 2007 09:48:41 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	Tian <tiansm@lemote.com>
Subject: Re: Mailing patches
Cc:	"Ralf Baechle" <ralf@linux-mips.org>, Kumba <kumba@gentoo.org>,
	linux-mips@linux-mips.org
In-Reply-To: <4666613A.8090807@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20070604133551.GA24405@linux-mips.org> <4664DB12.80906@gentoo.org>
	 <20070605152338.GA22937@linux-mips.org> <4666418C.9040401@lemote.com>
	 <cda58cb80706052333i3255943aw674028f4e5559249@mail.gmail.com>
	 <4666613A.8090807@lemote.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15298
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 6/6/07, Tian <tiansm@lemote.com> wrote:
> thx for reply
>
> and would it be better if I use --thread when git-format-patch?
>

Well, since you're using git-send-email with "--compose" and
"--no-chain-reply-to" switches, you don't need it. Take a look at
git-send-email and git-format-patch man pages, it's well described.

-- 
               Franck
