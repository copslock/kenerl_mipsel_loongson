Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Nov 2008 01:49:38 +0000 (GMT)
Received: from fk-out-0910.google.com ([209.85.128.189]:6826 "EHLO
	fk-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S23917183AbYKZBt0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 26 Nov 2008 01:49:26 +0000
Received: by fk-out-0910.google.com with SMTP id b27so198335fka.0
        for <linux-mips@linux-mips.org>; Tue, 25 Nov 2008 17:49:22 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=9QNa1Bqx7miJPeOUfFSuFbagZqGPHsDgf1jXQomvJ+E=;
        b=GcJ/BWlIDVWo+P2J296KDXeQPXhFIEWk5GOoaLWpQbiBx/4H705UEKbt9CM7Bt5FU6
         VUpX4S+Xkj9VwlFadennBDT0JFbJC9ZgEC2lQP6Vl7fLbyuRsYZ0XB2M86eTPmWeEAa1
         W5+0GzFvK5HgTsIA2ASGgozaBeihPwCEtQkqU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=bgBuFlMxYnbNa4zdq0Z8Y91vVk1Vfj/b38aCJozyQGM/pyHFQ7iziD2WjcfL7AfxrX
         EBL447O6P3Y6JrwZi9zUxLhrL4PFKLTc1Mxqlmvjlq8WkXVNztSjOpbcIPvigzl1ioKh
         ML4rHYBpzGe8b8DpaLGc0qqD98T637HoyaVSA=
Received: by 10.181.210.14 with SMTP id m14mr1741737bkq.163.1227664161604;
        Tue, 25 Nov 2008 17:49:21 -0800 (PST)
Received: by 10.180.239.14 with HTTP; Tue, 25 Nov 2008 17:49:21 -0800 (PST)
Message-ID: <90edad820811251749l59ac0aaam3eaa1cc26674bc91@mail.gmail.com>
Date:	Wed, 26 Nov 2008 03:49:21 +0200
From:	"Dmitri Vorobiev" <dmitri.vorobiev@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Looking for Extreme graphics technical documentation
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21441
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

I am looking for Extreme graphics technical documentation. Indigo2
PROM reports the graphics board as follows:

controller display SGI-GU1-Extreme key 0 ( ConsoleOut Output )
p: video(0)
  peripheral monitor key 0
  p: video(0)monitor(0)

So far I have been able to find (apart from a handful of marketing
documents) only the following two sources:

http://en.wikipedia.org/wiki/Extreme_Graphics
http://www.futuretech.blinkenlights.nl/i2sec5.html#5.6

These, however, do not seem to be enough to write a console driver.

Can anyone help, please?

Thanks,
Dmitri
