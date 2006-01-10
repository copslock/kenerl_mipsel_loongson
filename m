Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Jan 2006 06:00:34 +0000 (GMT)
Received: from wproxy.gmail.com ([64.233.184.206]:43376 "EHLO wproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133398AbWAJGAQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 10 Jan 2006 06:00:16 +0000
Received: by wproxy.gmail.com with SMTP id 36so96011wra
        for <linux-mips@linux-mips.org>; Mon, 09 Jan 2006 22:03:19 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=CnjSUQSGiictdoYY6r8TPbMHWb/4A2a5FnDv9iX+eJR4b/SjNaCZJBx84dtjYBwlCWtyDWpRYIdnn4hRnET07U23rXupT8YgDT9xU2kGqcmU49XQEkmabl1JcHYiZ2xFYCssE5ubPPC9yceFa+gsJ/mWNiM/+1rnNJlOWbX3Nlw=
Received: by 10.54.151.9 with SMTP id y9mr442986wrd;
        Mon, 09 Jan 2006 22:03:19 -0800 (PST)
Received: by 10.54.156.1 with HTTP; Mon, 9 Jan 2006 22:03:19 -0800 (PST)
Message-ID: <50c9a2250601092203y2cd68d65rf712174e31d41806@mail.gmail.com>
Date:	Tue, 10 Jan 2006 14:03:19 +0800
From:	zhuzhenhua <zzh.hust@gmail.com>
To:	linux-mips <linux-mips@linux-mips.org>
Subject: how to make zImage in linux 2.6?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <zzh.hust@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9833
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zzh.hust@gmail.com
Precedence: bulk
X-list: linux-mips

i download a 2.6.14 kernel, i find it can compile vmlinux,
vmlinux.srec, but i can't find how to make zImage.
In 2.4.x, there is a arch/mips/zboot/ to add board-special code to make zImage.
and i do not find similiar codes in 2.6.does the 2.6 support zImage?

Best regards

zhuzhenhua
