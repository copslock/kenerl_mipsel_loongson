Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3BFZMN07162
	for linux-mips-outgoing; Wed, 11 Apr 2001 08:35:22 -0700
Received: from arianne.in.ishoni.com ([164.164.83.132])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3BFZIM07157
	for <linux-mips@oss.sgi.com>; Wed, 11 Apr 2001 08:35:19 -0700
Received: from deepak ([192.168.1.240])
	by arianne.in.ishoni.com (8.11.2/8.11.2) with SMTP id f3BFb0o21657
	for <linux-mips@oss.sgi.com>; Wed, 11 Apr 2001 21:07:02 +0530
Reply-To: <deepak@ishoni.com>
From: "Deepak Shenoy" <deepak@ishoni.com>
To: <linux-mips@oss.sgi.com>
Subject: floating point libarary for mips
Date: Wed, 11 Apr 2001 21:07:53 +0530
Message-ID: <7019982E6729D511914E00C04F0CCD250B44A4@leonoid.in.ishoni.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Importance: Normal
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

Our MIPS processor does not have a floating point unit. But when I build the
kernel with "soft-float" option I would get many undefined references. So I
guess I would need to include the soft floating point library. Where can i
get this? Any pointers would help me.

Thanks in advance.

Regards,
deepak
