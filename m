Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Dec 2006 03:50:14 +0000 (GMT)
Received: from nf-out-0910.google.com ([64.233.182.185]:35426 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20039461AbWLKDuK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 11 Dec 2006 03:50:10 +0000
Received: by nf-out-0910.google.com with SMTP id l24so1778693nfc
        for <linux-mips@linux-mips.org>; Sun, 10 Dec 2006 19:50:10 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=B9AVPPEbXg6pI/uvESmlf+6QaIbddbBlXS47A6Qsfatrs/G6VqWCdlXChxyhao/58DcdRPaljg4bufK9cwmUiOD8kWXp3e0z2bbiIIpcIgXmmGlb7DXZ3Xue6lTz87N1gR6MlJwHowD1ruL1eUHXuueYGkbmzgsLppaFfP8F4fo=
Received: by 10.82.114.3 with SMTP id m3mr524478buc.1165809010040;
        Sun, 10 Dec 2006 19:50:10 -0800 (PST)
Received: by 10.82.179.13 with HTTP; Sun, 10 Dec 2006 19:50:10 -0800 (PST)
Message-ID: <50c9a2250612101950s20e3f71cs7c6726be43685b26@mail.gmail.com>
Date:	Mon, 11 Dec 2006 11:50:10 +0800
From:	zhuzhenhua <zzh.hust@gmail.com>
To:	linux-mips <linux-mips@linux-mips.org>
Subject: hwo to improve a video decoder program's timeslice
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <zzh.hust@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13424
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zzh.hust@gmail.com
Precedence: bulk
X-list: linux-mips

 i have a video decoder program run as aplication
and i now have change the HZ from 1000 to 100, set the decoder program
priority as 99.
if i want to the video decoder program to get more time to run, is
there any other way to improve it ?

thanks for any hints

Best Regards

zhuzhenhua
