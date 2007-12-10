Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Dec 2007 01:18:57 +0000 (GMT)
Received: from wa-out-1112.google.com ([209.85.146.179]:1330 "EHLO
	wa-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S28573961AbXLJBSs (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 10 Dec 2007 01:18:48 +0000
Received: by wa-out-1112.google.com with SMTP id m16so2811366waf
        for <linux-mips@linux-mips.org>; Sun, 09 Dec 2007 17:18:36 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type;
        bh=ebO27moLBa1oNB1gSNylEf+MWlRlgnCHDFVPUzVeSko=;
        b=G8YKt6IqT0St6fOqb8oIGISiYFjTBHlN3YnxNftJYhpkE/JDY2StoTXyxMo4turrxV0J3E9HX5ZFZoyn/uzHeghzrwhmKeCTl1tWf+K+vLUT3rgbjIWH81w6umOh9E9kA7w7mNS6njgbZLQi/+rYi5ewfn8bW4lFOI9Ffz0HdP4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type;
        b=uehru+YnxPTZQU5J0CjF7ttd/LUpe+4JVIGP3aD/y4NFdF/Hkx/imCTsKhjB9qXfIoiC4oDeisV6Aaur5/1xqGcOQVAoimdUXfD2bWNNcRpvtE9i0DFM6EIb64bKpo8+aZR2C511jhEyOv+Q6ku7pzp/mSxx+K8ndASv0aN50ME=
Received: by 10.115.78.1 with SMTP id f1mr6226353wal.1197249515952;
        Sun, 09 Dec 2007 17:18:35 -0800 (PST)
Received: by 10.114.168.15 with HTTP; Sun, 9 Dec 2007 17:18:35 -0800 (PST)
Message-ID: <50c9a2250712091718l75455353v1b86851a011eb4fe@mail.gmail.com>
Date:	Mon, 10 Dec 2007 09:18:35 +0800
From:	zhuzhenhua <zzh.hust@gmail.com>
To:	linux-mips <linux-mips@linux-mips.org>
Subject: is there a standard high res timer patch for mips?
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_22432_8761073.1197249515950"
Return-Path: <zzh.hust@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17747
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zzh.hust@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_22432_8761073.1197249515950
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hello, all
           i want to add the high res timer support for my kernel(version
2.6.14),and i found there are some patches:
 high-res-timers at sourceforge.net/projects/high-res-timers/high-res-timers
Jun Sun's patch at
http://linux.junsun.net/patches/oss.sgi.com/experimental/<http://linux.junsun.net/patches/oss.sgi.com/experimental/040419.a-cpu-timer.patch>
Thomas Gleixner's patch at http://www.tglx.de/projects/hrtimers/
     is there a standard high res timer patch for mips now?
     thanks for any hints


Best Regards

zzh

------=_Part_22432_8761073.1197249515950
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hello, all<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i want to
add the high res timer support for my kernel(version 2.6.14),and i
found there are some patches: <br>
&nbsp;high-res-timers at <a href="http://sourceforge.net/projects/high-res-timers/high-res-timers">sourceforge.net/projects/high-res-timers/high-res-timers</a><br>
Jun Sun&#39;s patch at <a href="http://linux.junsun.net/patches/oss.sgi.com/experimental/">http://linux.junsun.net/patches/oss.sgi.com/experimental/</a><a rel="nofollow" href="http://linux.junsun.net/patches/oss.sgi.com/experimental/040419.a-cpu-timer.patch">
</a><br>
Thomas Gleixner&#39;s patch at <a href="http://www.tglx.de/projects/hrtimers/">http://www.tglx.de/projects/hrtimers/</a><br>
&nbsp;&nbsp;&nbsp;&nbsp; is there a standard high res timer patch for mips now?<br>
&nbsp;&nbsp;&nbsp;&nbsp; thanks for any hints<br>
<br>
<br>
Best Regards<br>
<br>
zzh<br>
<br>
<br>

------=_Part_22432_8761073.1197249515950--
