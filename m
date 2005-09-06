Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Sep 2005 18:46:42 +0100 (BST)
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.201]:43648 "EHLO
	wproxy.gmail.com") by linux-mips.org with ESMTP id <S8225744AbVIFRqZ> convert rfc822-to-8bit;
	Tue, 6 Sep 2005 18:46:25 +0100
Received: by wproxy.gmail.com with SMTP id i32so883580wra
        for <linux-mips@linux-mips.org>; Tue, 06 Sep 2005 10:53:13 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=h6cNjHGvnz+4NuoPAdR03n//9YhH5zW4ThwjMHaTKoDcJuRgF7BU0FqeKaCjmZIcBeb9vepE+IA1Hbpu/yYVJde00L/QMjiEc/ZM7Bz7vulPXvBQ9trUM5Symr2C0Scflmoe4/4Dr9+vvhWIULwuoFA4PfO5qlvF7y06CW+t5Yw=
Received: by 10.54.36.9 with SMTP id j9mr4492932wrj;
        Tue, 06 Sep 2005 10:53:13 -0700 (PDT)
Received: by 10.54.41.29 with HTTP; Tue, 6 Sep 2005 10:53:13 -0700 (PDT)
Message-ID: <ecb4efd1050906105332061e5a@mail.gmail.com>
Date:	Tue, 6 Sep 2005 13:53:13 -0400
From:	Clem Taylor <clem.taylor@gmail.com>
Reply-To: clem.taylor@gmail.com
To:	linux-mips <linux-mips@linux-mips.org>
Subject: Problems with CONFIG_CC_OPTIMIZE_FOR_SIZE?
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <clem.taylor@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8881
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clem.taylor@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

I recently configured my MIPS (Au1550) kernel to use
CONFIG_CC_OPTIMIZE_FOR_SIZE to match the way the rest of the system is
built and discovered that with this option enabled /sbin/reboot
stopped working, the system just hangs after printing 'Resetting
Integrated Peripherals'. I'm using gcc 3.4.4. I haven't noticed any
other problems (but I've only done minimal testing) and I was
wondering if anyone else is using CONFIG_CC_OPTIMIZE_FOR_SIZE?

                            Thanks,
                            Clem
