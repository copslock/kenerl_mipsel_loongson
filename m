Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jun 2005 22:50:00 +0100 (BST)
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.206]:59003 "EHLO
	wproxy.gmail.com") by linux-mips.org with ESMTP id <S8225552AbVFWVto> convert rfc822-to-8bit;
	Thu, 23 Jun 2005 22:49:44 +0100
Received: by wproxy.gmail.com with SMTP id 57so1074815wri
        for <linux-mips@linux-mips.org>; Thu, 23 Jun 2005 14:48:47 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JtfpXtvIuNb1gs/7I+ezYsE70uyDBzfIxDp+0ppY5BUBKkdQsPl54yFo1c/kx4edOH3AlpWLqo3vb9CHkpLt3NT0LTqrZBwYGE2G980smsGshv9M160m7KoVAJD/7xxmWSpOLISTQqlaIsm1JrMUd9gnoCZeykb9l5idSehJsXw=
Received: by 10.54.24.34 with SMTP id 34mr1239956wrx;
        Thu, 23 Jun 2005 14:48:46 -0700 (PDT)
Received: by 10.54.41.29 with HTTP; Thu, 23 Jun 2005 14:48:46 -0700 (PDT)
Message-ID: <ecb4efd1050623144816f7f528@mail.gmail.com>
Date:	Thu, 23 Jun 2005 17:48:46 -0400
From:	Clem Taylor <clem.taylor@gmail.com>
Reply-To: Clem Taylor <clem.taylor@gmail.com>
To:	rolf liu <rolfliu@gmail.com>
Subject: Re: which 2.6 kernel can be run on db1550?
Cc:	linux-mips@linux-mips.org
In-Reply-To: <2db32b72050623133731f7b098@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <2db32b72050623133731f7b098@mail.gmail.com>
Return-Path: <clem.taylor@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8163
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clem.taylor@gmail.com
Precedence: bulk
X-list: linux-mips

On 6/23/05, rolf liu <rolfliu@gmail.com> wrote:
> I just compiled 2.4.31 and run that on db1550. It works through a NFS
> root file system. I am thinking of running of 2.6 on db1550. 

I haven't switched over to 2.6.12, but I'm running 2.6.11 (checked out
from linux-mips on 2005.03.18) on a Au1550 based board. When I was
porting to my hardware, the default kernel worked just fine on the
DBAu1550. I'm using gcc 3.4.3 and 2.15.94.0.2.2 bintools.

> Which one can be compiled by SDE and run this box?

I'm not sure what SDE is. I used buildroot to compile my toolchain and
make my root image.

> I tried 2.6.12 and tried 2.6.12-rc6, but got no luck. They just don't compile.

I haven't had a chance to try 2.6.12 yet.

                                --Clem
