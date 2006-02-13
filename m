Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Feb 2006 01:32:37 +0000 (GMT)
Received: from uproxy.gmail.com ([66.249.92.199]:17165 "EHLO uproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S3465649AbWBMBca convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 13 Feb 2006 01:32:30 +0000
Received: by uproxy.gmail.com with SMTP id q2so848241uge
        for <linux-mips@linux-mips.org>; Sun, 12 Feb 2006 17:38:43 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=aBb9w7khtCmwrhDZ9LBq6aBa2DngRDIhKZwOnHhvqXzWTNmoMdVppgjP05IPj0iX3lWDNnYnaJVECmLXvtDDxHljniU593gt+5TmcOJg7tlDIafjNIrAp57MOT1CAT/CFyAoGtbZErMcEh8m6ocWBGKLxb5euD1rtS/EjcNotgs=
Received: by 10.49.38.11 with SMTP id q11mr636785nfj;
        Sun, 12 Feb 2006 17:38:42 -0800 (PST)
Received: by 10.48.143.19 with HTTP; Sun, 12 Feb 2006 17:38:42 -0800 (PST)
Message-ID: <50c9a2250602121738r59f5fed0s800e43f9d232c6eb@mail.gmail.com>
Date:	Mon, 13 Feb 2006 09:38:42 +0800
From:	zhuzhenhua <zzh.hust@gmail.com>
To:	linux-mips <linux-mips@linux-mips.org>
Subject: does any other cross-tool support UID instruction?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <zzh.hust@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10410
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zzh.hust@gmail.com
Precedence: bulk
X-list: linux-mips

i want to use the UID instruction in my application or library, but
the sde toolchain on support to compile bootloader or kernel.
how to use it to compile a application or library?
or does any other cross-tool support UID instruction?
thanks for any hints

Best regards

zhuzhenhua
