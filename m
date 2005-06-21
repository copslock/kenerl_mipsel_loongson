Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Jun 2005 18:49:18 +0100 (BST)
Received: from zproxy.gmail.com ([IPv6:::ffff:64.233.162.202]:10527 "EHLO
	zproxy.gmail.com") by linux-mips.org with ESMTP id <S8224791AbVFURtD> convert rfc822-to-8bit;
	Tue, 21 Jun 2005 18:49:03 +0100
Received: by zproxy.gmail.com with SMTP id 13so21627nzp
        for <linux-mips@linux-mips.org>; Tue, 21 Jun 2005 10:48:55 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=tZAmUPyH9k8eJkj/WujoW6b5dGENY6EmWWJUxfadlp+VFsoXAoKsRLvD55EMz/dw4jazxTakFV0M5s9ysfXVVpxQuSAXCUS45QgOzKXbg6v7ODImFZFmM41wkeRbnYY6iHmeDBGy1hZ1YhMcBgEFare+P9If03+cm4JKKoTsGJM=
Received: by 10.36.222.3 with SMTP id u3mr3120254nzg;
        Tue, 21 Jun 2005 10:48:55 -0700 (PDT)
Received: by 10.36.68.6 with HTTP; Tue, 21 Jun 2005 10:48:55 -0700 (PDT)
Message-ID: <6097c4905062110482288b0a8@mail.gmail.com>
Date:	Tue, 21 Jun 2005 21:48:55 +0400
From:	Maxim Osipov <maxim.osipov@gmail.com>
Reply-To: maxim@mox.ru
To:	linux-mips@linux-mips.org
Subject: strace n64 support
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <maxim.osipov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8123
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maxim.osipov@gmail.com
Precedence: bulk
X-list: linux-mips

Hello,

I was looking at strace-4.5.12 and noticed, that
linux/mips/syscallent.h has syscall numbers only for o32. Are n32 and
n64 supported? Google doesn't help ;(

Maxim
