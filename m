Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Dec 2005 07:09:20 +0000 (GMT)
Received: from wproxy.gmail.com ([64.233.184.203]:58473 "EHLO wproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133536AbVLBHJB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 2 Dec 2005 07:09:01 +0000
Received: by wproxy.gmail.com with SMTP id i11so6275wra
        for <linux-mips@linux-mips.org>; Thu, 01 Dec 2005 23:12:35 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=d0ntXKGDNs96c1K3P3C3NbsChfQz9FhL2+3NW+RihgoBL3X85Tqg/7QsSpWSsBG1CtdsnmalRj65+M2kFyanWNh5miud16Rz9WPT3s/wFF9dkbe+4m8/CvAiqGsQAM07Gt0cS5JJqCCoC6kfS/QP+VPXEXzKswbqINhglA3Afdo=
Received: by 10.54.63.18 with SMTP id l18mr167495wra;
        Thu, 01 Dec 2005 23:12:35 -0800 (PST)
Received: by 10.54.129.5 with HTTP; Thu, 1 Dec 2005 23:12:35 -0800 (PST)
Message-ID: <50c9a2250512012312u47bbe09eh9e4f6b8edb0d0d9d@mail.gmail.com>
Date:	Fri, 2 Dec 2005 15:12:35 +0800
From:	zhuzhenhua <zzh.hust@gmail.com>
To:	linux-mips@linux-mips.org
Subject: where to set the BEV to normal of status in kernel source?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <zzh.hust@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9574
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zzh.hust@gmail.com
Precedence: bulk
X-list: linux-mips

i don't find it in load_mmu(), who can point out for me?
thanks!
is that must be set in bootloader?


Best regards


zhuzhenhua
