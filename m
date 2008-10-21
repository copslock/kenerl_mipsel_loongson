Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Oct 2008 02:00:30 +0100 (BST)
Received: from fg-out-1718.google.com ([72.14.220.158]:45591 "EHLO
	fg-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S21949422AbYJUBA1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 21 Oct 2008 02:00:27 +0100
Received: by fg-out-1718.google.com with SMTP id d23so1627183fga.32
        for <linux-mips@linux-mips.org>; Mon, 20 Oct 2008 18:00:27 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=jeg01U1jRQzl37mUKaVafUN8sIkwzCCqHV1Q7xRx75I=;
        b=jP0o5r7W8QGT/sWad0iL0i17E+BSakshbBUTSG+Ym15xjfXu+M1/B5zY9P2+T/OVMq
         vJFPMrdPU2o4y/JWJlPe/6+8qLnXB/S55d/ppmE74If7zAD4KlpE9EuyQeGOvh/XW3Yu
         5BAjHrZZAdVZd7nYUdRQ0ZcaBOrD3fc2uZhAE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=UnN4tK28PuRBqCsXewtgxWGmnC3kC+l59KRO1gdg60k/mr1R4jCgOd3IM5EhX8yh2o
         sIcSt+vxn6idRVbCvMC6dqiPobH3zcweNR/3oNIddlV2sjPHrE/HDNvHTLXE/3sIc7Tf
         On4QKXV/Lk8C/aw6M6KthO8BfvA24CJCXCWyc=
Received: by 10.86.4.2 with SMTP id 2mr7378503fgd.21.1224550827000;
        Mon, 20 Oct 2008 18:00:27 -0700 (PDT)
Received: by 10.86.9.6 with HTTP; Mon, 20 Oct 2008 18:00:26 -0700 (PDT)
Message-ID: <c62985530810201800r3ddfbb99s1a0809f2eba45cdf@mail.gmail.com>
Date:	Tue, 21 Oct 2008 03:00:26 +0200
From:	"=?ISO-8859-1?Q?Fr=E9d=E9ric_Weisbecker?=" <fweisbec@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Support for ftrace in MIPS
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <fweisbec@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20825
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fweisbec@gmail.com
Precedence: bulk
X-list: linux-mips

Hello everyone,

I saw that there is no implementation of ftrace in mips currently and
I would like to know if someone is currently working on it. If not I
would be glad
to work on patches for that.

Thanks...
