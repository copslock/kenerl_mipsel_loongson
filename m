Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Apr 2009 09:44:19 +0100 (BST)
Received: from yx-out-1718.google.com ([74.125.44.153]:47345 "EHLO
	yx-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S20033851AbZDJIny convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 10 Apr 2009 09:43:54 +0100
Received: by yx-out-1718.google.com with SMTP id 3so644326yxi.24
        for <linux-mips@linux-mips.org>; Fri, 10 Apr 2009 01:43:52 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=o5onoiv1lUBvhkQ2heOCm3mmC7eQxRLtfnhiKCvbMAg=;
        b=trDCpJ6ZztS/P3UqvkwwWmDR9q29MVDt7cxgp0HTwaEmc0zArW2blRX9yHUBsmAjyU
         YwD7HPnxTrLjVEwY1wCkx8E2ERXlAbNe+thnzMc9fsxrCsn6KCWI+cN/Q9ukS0AvC6t2
         V97L4R4P7DD81iSIz0MEkA7xCJ7LubdtNSSoI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=wV+Nihq8xvI8HbRqKf7zxOPOPkd2Qn26SfYOlboHV/6zFSgIu9ceXNnadxm7ERxWwJ
         iPFCrjC07Qt4Tbz9NYCok57Aa2ejNPFoZhzT38Jti53E6S86RTWG3d22MXd3keTmoPJ+
         k63LovIpFJN2uPifwvNchZcOvf2RBVfVonXdM=
Received: by 10.101.70.14 with SMTP id x14mr1878117ank.131.1239353032782;
        Fri, 10 Apr 2009 01:43:52 -0700 (PDT)
Received: from florian.lab.openpattern.org (lab.openpattern.org [82.240.16.241])
        by mx.google.com with ESMTPS id b37sm4595272ana.19.2009.04.10.01.43.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 10 Apr 2009 01:43:52 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: Re: [PATCH v3 2/2] Alchemy: remove unused au1000_gpio.h header
Date:	Fri, 10 Apr 2009 10:43:44 +0200
User-Agent: KMail/1.9.9
Cc:	Linux-MIPS <linux-mips@linux-mips.org>
References: <1239299363-28762-1-git-send-email-mano@roarinelk.homelinux.net> <1239299363-28762-2-git-send-email-mano@roarinelk.homelinux.net>
In-Reply-To: <1239299363-28762-2-git-send-email-mano@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200904101043.45615.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22323
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Le Thursday 09 April 2009 19:49:23 Manuel Lauss, vous avez écrit :
> Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>

Acked-by: Florian Fainelli <florian@openwrt.org>

-- 
Best regards, Florian Fainelli
Email : florian@openwrt.org
http://openwrt.org
-------------------------------
