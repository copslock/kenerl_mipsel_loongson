Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Jun 2005 00:33:44 +0100 (BST)
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.195]:61494 "EHLO
	wproxy.gmail.com") by linux-mips.org with ESMTP id <S8225560AbVFWXd0> convert rfc822-to-8bit;
	Fri, 24 Jun 2005 00:33:26 +0100
Received: by wproxy.gmail.com with SMTP id 57so1107862wri
        for <linux-mips@linux-mips.org>; Thu, 23 Jun 2005 16:32:29 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=pLgPRUbqi3doreKUV91AuzIKwxW/3ApEcpsN58BQZ4kHJLqF/APucN6rOk0IR+NijaWy7vcK7g/qQwnEB9E/PH102TGP7CFzgsPkkFA+40vaBQbOd8c8/ylvUNO8ldAxIT5zisOCOMM/QS8Uwg0cYM+wMuW1oWOa9JCfbYUzM8g=
Received: by 10.54.36.64 with SMTP id j64mr1485554wrj;
        Thu, 23 Jun 2005 16:32:29 -0700 (PDT)
Received: by 10.54.71.11 with HTTP; Thu, 23 Jun 2005 16:32:29 -0700 (PDT)
Message-ID: <2db32b72050623163268d54ecf@mail.gmail.com>
Date:	Thu, 23 Jun 2005 16:32:29 -0700
From:	rolf liu <rolfliu@gmail.com>
Reply-To: rolf liu <rolfliu@gmail.com>
To:	linux-mips@linux-mips.org
Subject: how to bring up the second ether on db1550?
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <rolfliu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8170
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rolfliu@gmail.com
Precedence: bulk
X-list: linux-mips

LInux 2.4.31 is running on the db1550, but only with 1 ether
interface, eth0. the eth1 does not seem working. Any idea to bring it
up?

thanks
