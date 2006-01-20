Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jan 2006 12:53:26 +0000 (GMT)
Received: from uproxy.gmail.com ([66.249.92.201]:48877 "EHLO uproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S3458549AbWATMxG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 20 Jan 2006 12:53:06 +0000
Received: by uproxy.gmail.com with SMTP id m3so233488uge
        for <linux-mips@linux-mips.org>; Fri, 20 Jan 2006 04:57:01 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=T6FAXLiktbJ3/wmnFvVBAVsR2xcOVlYssFWHqtGvO9X76gpl7yWIhDYDZcvXC3dLy1mkwncYOrG1DJmPsyhFQDa6xx8E7WH6iIdXXVjfbezVs+29fXOTXbaBlpcLeCL+VrXhlarE+eW+3BB9tbwGxYNv2gxznbhGvBKxhJz6KW8=
Received: by 10.49.40.4 with SMTP id s4mr51865nfj;
        Fri, 20 Jan 2006 04:57:01 -0800 (PST)
Received: by 10.48.243.16 with HTTP; Fri, 20 Jan 2006 04:57:01 -0800 (PST)
Message-ID: <38dc7fce0601200457t574a293bxbfaf8c7b73d65378@mail.gmail.com>
Date:	Fri, 20 Jan 2006 21:57:01 +0900
From:	Youngduk Goo <ydgoo9@gmail.com>
To:	linux-mips@linux-mips.org
Subject: IDE Inteface on the AMD AU1200
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <ydgoo9@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10013
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ydgoo9@gmail.com
Precedence: bulk
X-list: linux-mips

Hello,all

The DBAu1200 evaluation board from AMD use the Xilinx's CPLD,
and Ethernet, IDE, BCSR... address line comes out from it.
BCSR(Board Configuration & Status Register) in CPLD have many
function like Enable/Disable the Interrupt and else.
I don't understand exactly why they are used and what they do in the system.

I just wonder if I don't use this and connect the IDE interface to the
static bus of Au1200 directly, I am not sure it is working well or
not.

Is there anyone who use the IDE interface directly to the AU1200?
Please give me the advice.


Thanks,
