Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Jul 2006 15:47:49 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.173]:45071 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S8133530AbWGHOrj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 8 Jul 2006 15:47:39 +0100
Received: by ug-out-1314.google.com with SMTP id k3so2905928ugf
        for <linux-mips@linux-mips.org>; Sat, 08 Jul 2006 07:47:39 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gLqG7ppaQwyRZS1DHuyjaSSktwrHFOus3yEhxoROAX+H0/w/IyXLmtq6610GrMtC87uRUuV9VpabfqMycTW8bRnX8wAWkLk8o5O85syJf59r7odzWz1ZDJ1FlQtNcBs8popxQAyxyJTa2m+yQrl37SDeB5KmABbLHuZi167ZHDs=
Received: by 10.67.29.12 with SMTP id g12mr3098367ugj;
        Sat, 08 Jul 2006 07:47:39 -0700 (PDT)
Received: by 10.67.100.10 with HTTP; Sat, 8 Jul 2006 07:47:39 -0700 (PDT)
Message-ID: <cda58cb80607080747g66ac4357ya1f2cef89b4d868@mail.gmail.com>
Date:	Sat, 8 Jul 2006 16:47:39 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: [PATCH] sparsemem fix
Cc:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
In-Reply-To: <20060706173235.GA4739@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060705.012244.96686002.anemo@mba.ocn.ne.jp>
	 <44AB79D0.90002@innova-card.com>
	 <20060705.192054.128618288.nemoto@toshiba-tops.co.jp>
	 <20060706173235.GA4739@linux-mips.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11944
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

2006/7/6, Ralf Baechle <ralf@linux-mips.org>:
> On Wed, Jul 05, 2006 at 07:20:54PM +0900, Atsushi Nemoto wrote:
>
> > > For now it seems to be implemented only in sgi-ip27 machine. Maybe we should
> > > make things clear by adding:
> > >
> > > #ifdef CONFIG_SGI_IP27
> > > #define pfn_valid   [...]
> > > #else
>
> The fact that the code is only used on IP27 doesn't mean it is IP27-specific.
>

but the code seems to be in arch/mips/sgi-ip27, no ?

BTW, Ralf, are there any needs for MIPS to support platforms whose
memory start is not 0 ? I have made a patch for that, and wondering if
it's worth to post it on the list...

-- 
               Franck
