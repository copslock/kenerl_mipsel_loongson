Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Mar 2008 03:31:44 +0000 (GMT)
Received: from py-out-1112.google.com ([64.233.166.182]:43728 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S28644041AbYCXDbm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 24 Mar 2008 03:31:42 +0000
Received: by py-out-1112.google.com with SMTP id d32so3064482pye.22
        for <linux-mips@linux-mips.org>; Sun, 23 Mar 2008 20:31:41 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type;
        bh=PEX87JKfVOQTTly2Sh/18FJgeFaN6KEHMPYpIeTyVzA=;
        b=TnwMhtujcXn2vSa8knQVqC1fFH7GpuhNw4GSaJ4tPr78Gs6OPzOt+7WNCqFHuNqeFokentS7NB6ZAlKwlmUiIiv9xl6JEMqPCuzpcD5FrldhsjRIbrpYUXgILQln5eGbKwreIoCYL5zTrGXi0cPVsENdOD2Kf/hsHty+bQDgBsM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:mime-version:content-type;
        b=cR1BZNPFts/a3VOM3h32dgyR3uv8DpyntQoBPsfTeuizeI1tpK+l5AKPoyeLzYaD1eXa08MSYo57bOrL8FXYjJEyjdnOQNgseYFbQAfpIfS911WCunCEvZft/CjDYwN4y+0dQg5JYN5VfP2ulXRsmT22H+A+O+qXd792BfBQWrc=
Received: by 10.35.102.1 with SMTP id e1mr7485236pym.61.1206329501161;
        Sun, 23 Mar 2008 20:31:41 -0700 (PDT)
Received: by 10.35.16.3 with HTTP; Sun, 23 Mar 2008 20:31:41 -0700 (PDT)
Message-ID: <50c9a2250803232031o5033ce15o5ab843a9181e4e12@mail.gmail.com>
Date:	Mon, 24 Mar 2008 11:31:41 +0800
From:	zhuzhenhua <zzh.hust@gmail.com>
To:	linux-mips <linux-mips@linux-mips.org>
Subject: is uClibc-nptl stable for MIPS now?
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_4695_32279597.1206329501152"
Return-Path: <zzh.hust@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18470
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zzh.hust@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_4695_32279597.1206329501152
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hello,all
         recently, i want to switch my toolchain from glibc to uClibc,. and
with buildroot, i succeed in toolchain with pthread_old.
         i try to build a uClibc-nptl toolchain, but failed( i have used the
gcc-4.2.1 and binutils-2.17 version). i wonder whether there
         is a stable version for uClibc-nptl on MIPS.   if someone get it
work, please give some info about the version.
         thanks for any hints.


Best Regards



zzh

------=_Part_4695_32279597.1206329501152
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hello,all<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; recently, i want to
switch my toolchain from glibc to uClibc,. and with buildroot, i
succeed in toolchain with pthread_old. <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i try to build a
uClibc-nptl toolchain, but failed( i have used the gcc-4.2.1 and
binutils-2.17 version). i wonder whether there<br>
&nbsp; &nbsp; &nbsp; &nbsp;&nbsp; is a stable version for uClibc-nptl
on MIPS.&nbsp;&nbsp; if someone get it work, please give some info
about the version.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; thanks for any hints.<br>
<br>
<br>
Best Regards<br>
<br>
<br>
<br>
zzh<br>

------=_Part_4695_32279597.1206329501152--
