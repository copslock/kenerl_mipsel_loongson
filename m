Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Sep 2005 13:36:28 +0100 (BST)
Received: from zproxy.gmail.com ([64.233.162.203]:41666 "EHLO zproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S3465570AbVI3MgI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 30 Sep 2005 13:36:08 +0100
Received: by zproxy.gmail.com with SMTP id j2so458644nzf
        for <linux-mips@linux-mips.org>; Fri, 30 Sep 2005 05:36:02 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BbSQQa42LqM9mCY7TueEmSZ69KPJvQiiTz4gFg+0uXL2Z+MAnST4N7PXw7UXj2ilaf+S5lGB3eOJVsdB0loVpGCY1uziQJnhHE37cxRJU/+dg3E6TwPHJLI06qN3F3poNY+hEcGOX/f/oBW3ja1yF5b4bvEPPU1utP1aqx1jo+4=
Received: by 10.37.18.42 with SMTP id v42mr1412730nzi;
        Fri, 30 Sep 2005 05:36:02 -0700 (PDT)
Received: by 10.36.49.3 with HTTP; Fri, 30 Sep 2005 05:36:01 -0700 (PDT)
Message-ID: <cda58cb80509300536q42e9ddd4q@mail.gmail.com>
Date:	Fri, 30 Sep 2005 14:36:01 +0200
From:	Franck <vagabon.xyz@gmail.com>
Reply-To: Franck <vagabon.xyz@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] minor fix in asm-mips/module.h
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20050929234542.GB3983@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <cda58cb8050926000665f843dc@mail.gmail.com>
	 <20050926115539.GB3175@linux-mips.org>
	 <cda58cb805092605057f7cad7d@mail.gmail.com>
	 <20050929234542.GB3983@linux-mips.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9095
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi Ralf,

2005/9/30, Ralf Baechle <ralf@linux-mips.org>:
> There are no CONFIG_CPU_4KSC and CONFIG_CPU_4KSD configuration options.
> Did you really create this patch against the linux module of the CVS
> repository or was it a different tree?
>

The patch was created against linux-mips CVS repository. I added 4KSC
and 4KSD support in this tree. I thougth seeing reference of 4KSC
somewhere. Anyway, if you don't want to include them in your tree
that's ok.

Thanks
--
               Franck
