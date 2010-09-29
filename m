Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Sep 2010 18:55:12 +0200 (CEST)
Received: from mail-px0-f177.google.com ([209.85.212.177]:32969 "EHLO
        mail-px0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491135Ab0I2QzK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Sep 2010 18:55:10 +0200
Received: by pxi4 with SMTP id 4so322849pxi.36
        for <linux-mips@linux-mips.org>; Wed, 29 Sep 2010 09:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type;
        bh=bW1FrFF/u43ji5Eu5SIDg5notApQ/JIXn8GyYZ8VPbw=;
        b=KLvpcMvJ+YGHjt2gsyuK0CfDyAsXZX0AenClPaS9L8NOfJSH+3pqB5I+3+7NXn/qGN
         yxLuepDcyWpSuSPaQTLtZlzDt96eNqNRvhO+s8IDfxLjuh27o6mZyj7p0cuCCdl8BeNS
         jTr8SD8MMzChL8CZnzY7bSfNW+llg30CicsZo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=EvRZn+rKtuL9I6F5CjL1yqWGbyhgVW7VW51lKZCM7yuS1jo8GX5o16UYS8cs0L4Ujm
         N6GV7e3Eq4fg/5prnJyq+8527byv3UczHq7rbOSL5VayN3MWVRmmsqF4lFkQGuk59gJg
         /TkWwyKHiwZoYVcBo2CgIAu0t+A0DJyQQZixI=
MIME-Version: 1.0
Received: by 10.142.246.10 with SMTP id t10mr1680006wfh.99.1285779299731; Wed,
 29 Sep 2010 09:54:59 -0700 (PDT)
Received: by 10.229.221.146 with HTTP; Wed, 29 Sep 2010 09:54:59 -0700 (PDT)
In-Reply-To: <20100929031018.GB7999@rcwf64-moto>
References: <AANLkTi==9kzfqq=Ubdo9Ms_9N=N+7rmcvg01500C4nuc@mail.gmail.com>
        <4CA21E5D.7080905@caviumnetworks.com>
        <AANLkTik6Uv_=G4NR41oiwTai=+pRvLy+t1U9rU3ZD=3c@mail.gmail.com>
        <20100929031018.GB7999@rcwf64-moto>
Date:   Thu, 30 Sep 2010 00:54:59 +0800
Message-ID: <AANLkTin-JXGy_qbiX=MZoORCHDyRJeuo2Kq2ew10zLwS@mail.gmail.com>
Subject: Re: Why mips eret failed?
From:   "wilbur.chan" <wilbur512@gmail.com>
To:     Adam Jiang <jiang.adam@gmail.com>,
        "wilbur.chan" <wilbur512@gmail.com>,
        David Daney <ddaney@caviumnetworks.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 27892
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wilbur512@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 23496

2010/9/29, Adam Jiang <jiang.adam@gmail.com>:
> Quick reply on top
>
> Take a look at
>
> https://www.ibm.com/developerworks/mydeveloperworks/blogs/ddou/tags/u-boot?lang=en
>
> This may help, I suppose. Why don't forward this message to uboot
> mailing list?
>
>

I found this article  useful ,and found  drawback in my implemtation


 That is , I've not fixed  gp before jump to do_IRQ.

   LEAF(handle_int)
        nop
        SAVE_ALL
        CLI
       /*haven't fix gp*/
        la     t9,do_IRQ
        nop
        jalr   t9
        nop
        RESTORE_ALL
       nop
  END(handle_int)
