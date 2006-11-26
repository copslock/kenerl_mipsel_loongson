Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 26 Nov 2006 22:46:22 +0000 (GMT)
Received: from ug-out-1314.google.com ([66.249.92.173]:59845 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20037637AbWKZWqS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 26 Nov 2006 22:46:18 +0000
Received: by ug-out-1314.google.com with SMTP id 40so1073062uga
        for <linux-mips@linux-mips.org>; Sun, 26 Nov 2006 14:46:17 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=tSMciPfm/lbiIGo1HF+9yVBq7MCeFk8LRHXyDtHIwhsyqeEVbk79d5H2UWFudVaNYRjPFDb6OhkLS7EiTAu3ZFI52ScdF9mOQILXTPsb7FPKL1GROZMJXleI0DqdD9uyuKfDDnUKn7uhxCfmhWDPuEAYVq4j5YHOPPhCwpWmcVA=
Received: by 10.67.103.7 with SMTP id f7mr11269243ugm.1164581177242;
        Sun, 26 Nov 2006 14:46:17 -0800 (PST)
Received: by 10.67.100.15 with HTTP; Sun, 26 Nov 2006 14:46:16 -0800 (PST)
Message-ID: <598f0650611261446k145aa973nade5595d056bdc28@mail.gmail.com>
Date:	Mon, 27 Nov 2006 00:46:16 +0200
From:	"Andras Joo" <jooa3000@gmail.com>
To:	linux-mips@linux-mips.org
Subject: ndv8601: boy, this is phantom
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <jooa3000@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13258
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jooa3000@gmail.com
Precedence: bulk
X-list: linux-mips

Hi all,

I'm looking for information about the Mediamatics (National
Semiconductor) ndv8601.
This is a dvd-player SoC, with some nice features. I have it in a
Mivoc DSX-8500 dvd player which, btw, is a phantom too. The problem is
that so far I was unable to locate any useful information about
it/them. The Mivoc's site doesn't exist, and on Natsemi's I can't find
anything but some features list. I searched their site, in datasheet
archives and google, but there is only a general description of the
chip, or the player. OK, they are a little old, but still. I'd like to
port/run Linux to/on it, but the single useful information I found is
that it has a MIPS core. That's all. Hence I'm here.
If someone has some info about these I'd really appreciate it.
Actually, about any of the ndv84xx, ndv85xx or ndv86xx families of
chips. I think, if I could retrieve the firmware from the flash it
would help, but not knowing the pinout I am unable to locate the EJTAG
port (if it has any). Any ideas?

Best regards,
Joo Andras
