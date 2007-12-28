Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Dec 2007 05:24:54 +0000 (GMT)
Received: from py-out-1112.google.com ([64.233.166.183]:39622 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20022717AbXL1FYp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 28 Dec 2007 05:24:45 +0000
Received: by py-out-1112.google.com with SMTP id p76so8480573pyb.5
        for <linux-mips@linux-mips.org>; Thu, 27 Dec 2007 21:24:34 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type;
        bh=u7JdXJoen1pQKPXeaEtSII4+Zqh5ICSuLGJNrHSNu/g=;
        b=Jf21DsVhcqZ2ryrhDxC4End0ewJ3sY7ZGaa/wtn6CMNw8WZfpsAEc7Fbm6joXEbSsXHDGF6vW+5WYLJiwUYfPleDdHq0yKQFLKNT44YM/bISDWssVmOl0yTBaT8JH1yCI1n1MgjX+lD34EeBXiOfTjGd4m/1rTx8wa9CRcgFwhI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type;
        b=XLJxT1K7ZDSMlAJXMNq5Od2B1noWfRPFaaboEou6aSDRBrBML9fMkmGUMM34Op3G/F55YmXxAAPhoehuqFQttBvFFGXfcu5Brqb7cJRGAPMziUA1bcSE2PWornvXlCPdSokI2wltIpHWHHUshGqDJpRZqGQPO0/2CPGGW8ZrARQ=
Received: by 10.35.90.1 with SMTP id s1mr10514102pyl.53.1198819474163;
        Thu, 27 Dec 2007 21:24:34 -0800 (PST)
Received: by 10.35.103.8 with HTTP; Thu, 27 Dec 2007 21:24:34 -0800 (PST)
Message-ID: <50c9a2250712272124y13037169w7a85ad10d8eb4c61@mail.gmail.com>
Date:	Fri, 28 Dec 2007 13:24:34 +0800
From:	zhuzhenhua <zzh.hust@gmail.com>
To:	linux-mips <linux-mips@linux-mips.org>
Subject: is CONFIG_CPU_MIPS32_R2 workable for linux-2.6.14?
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_8322_6751167.1198819474160"
Return-Path: <zzh.hust@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17895
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zzh.hust@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_8322_6751167.1198819474160
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hello, all
            i work at linux-2.6.14, it  support CONFIG_CPU_MIPS32_R2,  and i
use CONFIG_CPU_MIPS32_R1 well.
but the kernel img compiled with my toolchain(gcc 3.4.4 + binutils2.15) is
not workable. after search the maillist and other resource,
i found someone said need to patch gcc, others said to patch binutils, and i
even found a patch for kernel itself.
is there a correct way to make  CONFIG_CPU_MIPS32_R2 workable? patch gcc or
binutils?
thanks for any hints.
Best Regards

zzh

------=_Part_8322_6751167.1198819474160
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hello, all<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i
work at linux-2.6.14, it&nbsp; support CONFIG_CPU_MIPS32_R2,&nbsp; and
i use CONFIG_CPU_MIPS32_R1 well.<br>
but the kernel img compiled with my toolchain(gcc 3.4.4 + binutils2.15)
is not workable. after search the maillist and other resource,<br>
i found someone said need to patch gcc, others said to patch binutils, and i even found a patch for kernel itself.<br>
is there a correct way to make&nbsp; CONFIG_CPU_MIPS32_R2 workable? patch gcc or binutils?<br>
thanks for any hints.<br>
Best Regards<br>
<br>
zzh &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  <span style="text-decoration: underline;"><br>
</span>

------=_Part_8322_6751167.1198819474160--
