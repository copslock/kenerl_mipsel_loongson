Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Mar 2007 16:33:42 +0000 (GMT)
Received: from ug-out-1314.google.com ([66.249.92.175]:13829 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20021482AbXCUQdl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 21 Mar 2007 16:33:41 +0000
Received: by ug-out-1314.google.com with SMTP id 40so419209uga
        for <linux-mips@linux-mips.org>; Wed, 21 Mar 2007 09:32:40 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=Fz0/nuEXnDUWFz3box1W/hC2f/laRZ1mC7e6W9tbFUmhfnP1qc2EnwDM0gbPaHRyvAIK2sj5FQAUSjHIkWc6hCghA79BJMgKjnGRAC6gSKUtpPTjrqvK1GN/09pK5oWbdsE17qGu9ov7nugPfyVjgpZiVb3xgYUrxCNrvc/WcCc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=UKnmlQXuPu+JFZDZw77roRSKNWLomMMWa+voZ5sOj8Jfeg7yJL4hmvbzkKdbBrw5HWIUnmdPyYoc7bMRWNQjMXLQxFRWYjZSkTxy+CpJkAg+U4YWnEgof2xB/jbm7c6E++pU5hbYWSTRX4sb2CR0K0KBwPsfypWZPuLzjEc4A/g=
Received: by 10.114.27.20 with SMTP id a20mr226674waa.1174494759236;
        Wed, 21 Mar 2007 09:32:39 -0700 (PDT)
Received: by 10.114.159.16 with HTTP; Wed, 21 Mar 2007 09:32:39 -0700 (PDT)
Message-ID: <d459bb380703210932ycb5ec66xc1e090bd3a1da8fd@mail.gmail.com>
Date:	Wed, 21 Mar 2007 17:32:39 +0100
From:	"Marco Braga" <marco.braga@gmail.com>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Subject: RE: PCI troubles on Alchemy AU1550 in 2.6.20 (and 2.6.19.1)
Cc:	clem.taylor@gmail.com
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_213816_20384840.1174494759184"
Return-Path: <marco.braga@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14610
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marco.braga@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_213816_20384840.1174494759184
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Clem,

I am experiencing exactly the same problems with PCI peripherials on Au1500
with kernel 2.6.20.1, now I am trying 2.6.20.3 but I have few hopes. Kernel
version 2.6.17.14 instead seems to be ok.

Perhaps sometime someone with better knowloedge than me will fix this issue,
since I am truly a newbie.

I am also trying to make out Sil3512 work with sata_sil, in kernel
2.6.17.14it hangs when probing the dis. Exactly which Sil controller
are you using?
Do you have an EPROM on your controller? It is present in the PCI reference
card but our engineer decided to go without it. I am not sure it has been a
good idea..

------=_Part_213816_20384840.1174494759184
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Clem,<br><br>I am experiencing exactly the same problems with PCI peripherials on Au1500 with kernel <a href="http://2.6.20.1">2.6.20.1</a>, now I am trying <a href="http://2.6.20.3">2.6.20.3</a> but I have few hopes. Kernel version 
<a href="http://2.6.17.14">2.6.17.14</a> instead seems to be ok.<br><br>Perhaps sometime someone with better knowloedge than me will fix this issue, since I am truly a newbie.<br><br>I am also trying to make out Sil3512 work with sata_sil, in kernel 
<a href="http://2.6.17.14">2.6.17.14</a> it hangs when probing the dis. Exactly which Sil controller are you using? Do you have an EPROM on your controller? It is present in the PCI reference card but our engineer decided to go without it. I am not sure it has been a good idea..
<br><br>

------=_Part_213816_20384840.1174494759184--
