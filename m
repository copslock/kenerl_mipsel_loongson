Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3U62lo29350
	for linux-mips-outgoing; Sun, 29 Apr 2001 23:02:47 -0700
Received: from arianne.in.ishoni.com ([164.164.83.132])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3U62hM29345
	for <linux-mips@oss.sgi.com>; Sun, 29 Apr 2001 23:02:43 -0700
Received: from deepak ([192.168.1.240])
	by arianne.in.ishoni.com (8.11.2/8.11.2) with SMTP id f3U65Ib11051
	for <linux-mips@oss.sgi.com>; Mon, 30 Apr 2001 11:35:20 +0530
Reply-To: <deepak@ishoni.com>
From: "Deepak Shenoy" <deepak@ishoni.com>
To: <linux-mips@oss.sgi.com>
Subject: user accessing kernel physical pages?
Date: Mon, 30 Apr 2001 11:35:00 +0530
Message-ID: <E0FDC90A9031D511915D00C04F0CCD256765@leonoid.in.ishoni.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

I am new to MIPS MMU architecture. I wanted to know if a user application be
able to access physical pages of the kerenel; if appropriate page table
entries are setup?. Is it possible?

Thanks and Regards,
deepak
