Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Feb 2006 06:33:48 +0000 (GMT)
Received: from nproxy.gmail.com ([64.233.182.193]:46731 "EHLO nproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8126552AbWB0Gdf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 27 Feb 2006 06:33:35 +0000
Received: by nproxy.gmail.com with SMTP id a27so514440nfc
        for <linux-mips@linux-mips.org>; Sun, 26 Feb 2006 22:41:12 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ibtl8E7S9gtmjyVI4c/DKDjTIUPiVwo8fLwrJgkFfhPRhyhbQ+nLsZXLzsnjRh7t4xlgDGoQ1dbQ9f46I9/Fed5PB+vvODnuFLin/LUbNfPVlXvhrBwZgoSJgptszFYK3f7ajouVkKhWF0w90tGII805WGuLu5AFyBKKYfI1x7c=
Received: by 10.48.225.15 with SMTP id x15mr32176nfg;
        Sun, 26 Feb 2006 22:41:11 -0800 (PST)
Received: by 10.48.249.14 with HTTP; Sun, 26 Feb 2006 22:41:11 -0800 (PST)
Message-ID: <50c9a2250602262241n4ba31d4fm2ac55ded4619b355@mail.gmail.com>
Date:	Mon, 27 Feb 2006 14:41:11 +0800
From:	zhuzhenhua <zzh.hust@gmail.com>
To:	linux-mips <linux-mips@linux-mips.org>
Subject: about the ioport_resource and iomem_resource setting
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <zzh.hust@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10653
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zzh.hust@gmail.com
Precedence: bulk
X-list: linux-mips

if i have not the PCI system, need i set the ioport_resource and
iomem_resource start and end in my board setup function?

Best Regards

zhuzhenhua
