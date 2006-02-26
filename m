Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 26 Feb 2006 02:24:24 +0000 (GMT)
Received: from nproxy.gmail.com ([64.233.182.207]:50891 "EHLO nproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133606AbWBZCYQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 26 Feb 2006 02:24:16 +0000
Received: by nproxy.gmail.com with SMTP id k27so396607nfc
        for <linux-mips@linux-mips.org>; Sat, 25 Feb 2006 18:31:45 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=gyt3yng+IkS0h0JSwncnGCrr+JtQJE3jGwxUSkCkL9qbuIcRkqO2XFGIGQbftLHyieM9EQnAY+5fPS2hMYzampknrhHh6ywINnMRjaAJ0NVuko5FgnalvSRVBvc4IcaqnVUEaDc6+Nds6slvtR6jE8Pka52FOrsN/pPM2i80NeY=
Received: by 10.48.240.15 with SMTP id n15mr2608095nfh;
        Sat, 25 Feb 2006 18:31:44 -0800 (PST)
Received: by 10.48.249.14 with HTTP; Sat, 25 Feb 2006 18:31:44 -0800 (PST)
Message-ID: <50c9a2250602251831n27d11b5ar7a309c9716a8683a@mail.gmail.com>
Date:	Sun, 26 Feb 2006 10:31:44 +0800
From:	zhuzhenhua <zzh.hust@gmail.com>
To:	linux-mips <linux-mips@linux-mips.org>
Subject: bogus packet in ei_receive of 8390.c
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <zzh.hust@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10648
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zzh.hust@gmail.com
Precedence: bulk
X-list: linux-mips

i use a rtl8019as ethernet card for my board, and now the driver can
boot up with nfs root, it also can run helloworld via nfs, but if i
run a big application,or something like vi, it will get
messages like that
"eth0: bogus packet: status=0x0 nxpg=0x65 size=102"
and i find it is in ei_receive of 8390.c caused by uncorrect status of
receive in the 8390_hdr, does someone meet this situation?
what may cause this? hardware or uncorrect driver?

thanks for any hints

Best regards

zhuzhenhua
