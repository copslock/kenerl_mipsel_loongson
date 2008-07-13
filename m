Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Jul 2008 15:53:29 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.185]:31898 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20037046AbYGMOx1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 13 Jul 2008 15:53:27 +0100
Received: by nf-out-0910.google.com with SMTP id h3so1195328nfh.14
        for <linux-mips@linux-mips.org>; Sun, 13 Jul 2008 07:53:26 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type;
        bh=48JWKRe8dDL+PLf05G6l8JwK1/FR6lYTWzJBrZ0O89s=;
        b=RqDtHaLzrf2L/kcoiw8LOhQQnQjmWStzomnMLpeO5pKIhtsXa9u1eaZ0R5iHNscKuH
         utQGyBJ7ezUacW9eqVQXX4ZdqV1yqeMxsh85jepngChW4NfoOmkiNInFt4HDSFYaVLEO
         +CSUL/Fz/zUwhsN7p8wvnOwx5S3KjlHsLZNaU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type;
        b=pDM4+JfDTN6zDxQu0c2m1QSXRuTRnEWy1rPLL4j9iYSoDmbOVd/nxYLvfumDYkdpUC
         amBgI7py6o2kc6yAUg8EUKMx0/FjjkhS7tAyl1mKNt3l1Gy/BGrhZQ0GuH8LBy4VUQCR
         SvBdBkepNyEC+QbvOXwnvEwkv3RKqJcJYKkbM=
Received: by 10.210.62.12 with SMTP id k12mr8193456eba.166.1215960806083;
        Sun, 13 Jul 2008 07:53:26 -0700 (PDT)
Received: by 10.210.28.18 with HTTP; Sun, 13 Jul 2008 07:53:26 -0700 (PDT)
Message-ID: <4ac2955e0807130753ydaf0d10n9d95d4d51baf660b@mail.gmail.com>
Date:	Sun, 13 Jul 2008 20:23:26 +0530
From:	"mahendra varman" <mahendravarman15@gmail.com>
To:	linuxppc-embedded@ozlabs.org., linux-kernel@vger.kernel.org, 
	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: rtc integration with hwclock
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_27287_27720679.1215960806080"
Return-Path: <mahendravarman15@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19812
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mahendravarman15@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_27287_27720679.1215960806080
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi

Help me to solve the below point

Hi have wrote a simple i2c based driver for rtc chip (x1226) in linux 2.6
with inbuilt i2c routines.

In the get_rtc_time routine i can able to read the values from the rtc chip
and store it in variables

I need to know how to update those values into the rtc structure so that if
i put hwclock it should display the read value....


Any example code depicting the above point is also welcome


Thanks in advance

------=_Part_27287_27720679.1215960806080
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi<br><br>Help me to solve the below point<br><br>Hi have wrote a simple i2c based driver for rtc chip (x1226) in linux 2.6 with inbuilt i2c routines.<br><br>In the get_rtc_time routine i can able to read the values from the rtc chip and store it in variables<br>
<br>I need to know how to update those values into the rtc structure so that if i put hwclock it should display the read value....<br><br><br>Any example code depicting the above point is also welcome<br><br><br>Thanks in advance<br>

------=_Part_27287_27720679.1215960806080--
