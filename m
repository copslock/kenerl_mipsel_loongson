Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jun 2005 22:00:18 +0100 (BST)
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.194]:3357 "EHLO
	wproxy.gmail.com") by linux-mips.org with ESMTP id <S8225552AbVFWVAA> convert rfc822-to-8bit;
	Thu, 23 Jun 2005 22:00:00 +0100
Received: by wproxy.gmail.com with SMTP id 57so1054688wri
        for <linux-mips@linux-mips.org>; Thu, 23 Jun 2005 13:58:58 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ppXBda/KwQysQ/ZQHL8hL00alzUJz03rzzNCvjgpGQcbRCJ5IWRciVaMBlsNOzd9NPOxBXeOqXj/oCLdNznsnKuztnu+rl7VCWKJfb3Gj/HFlO023BFzSn8Iopsvr+2Z+ugtKtvJ/Z/NRBWRVlG1lL3nEJvei+JYyFZ3zuHFgDg=
Received: by 10.54.31.70 with SMTP id e70mr1413928wre;
        Thu, 23 Jun 2005 13:58:58 -0700 (PDT)
Received: by 10.54.71.11 with HTTP; Thu, 23 Jun 2005 13:58:58 -0700 (PDT)
Message-ID: <2db32b72050623135829f8c4e3@mail.gmail.com>
Date:	Thu, 23 Jun 2005 13:58:58 -0700
From:	rolf liu <rolfliu@gmail.com>
Reply-To: rolf liu <rolfliu@gmail.com>
To:	linux-mips@linux-mips.org
Subject: keep getting "exec: Permission denied" at booting
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <rolfliu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8162
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rolfliu@gmail.com
Precedence: bulk
X-list: linux-mips

I am running 2.4.31 on ab1550. When the start-up comes at the network
config, ifup tries to bring up the ethernet interface. Then there
comes tons of "exec: Permission denied" message. the box just stop
there.

I am running through the NFS root filesystem got from redhat, possibly
7.1. pretty old. Is there a newer NFS available?

Any suggestion?

thanks
