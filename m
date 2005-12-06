Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Dec 2005 12:06:45 +0000 (GMT)
Received: from wproxy.gmail.com ([64.233.184.192]:9660 "EHLO wproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133453AbVLFMGZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 6 Dec 2005 12:06:25 +0000
Received: by wproxy.gmail.com with SMTP id i14so345923wra
        for <linux-mips@linux-mips.org>; Tue, 06 Dec 2005 04:06:06 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=bjrjNwd0cG3eDCDtBC8Jh2ZYZo3yVmfUd1WimlYOZB8GW2hhuuUsRslJLGkN71puDe0IDjJG/dxvz7grGw7zGk8rKVbFUE2KMxbiTBN3++yRH9ByBStd7plN5rEU2/pNi9OmHES9bAljYhrGMQeILib9IAPuo1csG6DN4dNw/v0=
Received: by 10.54.154.17 with SMTP id b17mr1674047wre;
        Tue, 06 Dec 2005 04:06:06 -0800 (PST)
Received: by 10.54.146.1 with HTTP; Tue, 6 Dec 2005 04:06:06 -0800 (PST)
Message-ID: <f69849430512060406x7f30a2f6k2c64f6cef383c175@mail.gmail.com>
Date:	Tue, 6 Dec 2005 04:06:06 -0800
From:	kernel coder <lhrkernelcoder@gmail.com>
To:	linux-mips@linux-mips.org
Subject: zero copy
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <lhrkernelcoder@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9609
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lhrkernelcoder@gmail.com
Precedence: bulk
X-list: linux-mips

hi,
    i'm trying to track the code flow of sendfile system call.Mine
ethernet card doesn't have scatter gather and checksum calculation
features.So stack should be making a copy of data.

Please tell me where in sendfile code flow,check for scatter gather
and cecksum features is made so that stack can decide whether to copy
data from user space or not.

lhrkernelcoder
