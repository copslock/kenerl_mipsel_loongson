Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2003 17:51:19 +0100 (BST)
Received: from mail.stellartec.com ([IPv6:::ffff:65.107.16.99]:55823 "EHLO
	nt_server.stellartec.com") by linux-mips.org with ESMTP
	id <S8225455AbTJGQvD>; Tue, 7 Oct 2003 17:51:03 +0100
Received: from wsyash ([192.168.1.109]) by nt_server.stellartec.com
          (Post.Office MTA v3.1.2 release (PO205-101c)
          ID# 568-43562U100L2S100) with SMTP id AAA356
          for <linux-mips@linux-mips.org>; Tue, 7 Oct 2003 09:50:50 -0700
Reply-To: <yshitoot@stellartec.com>
From: yshitoot@stellartec.com (Yashwant Shitoot)
To: <linux-mips@linux-mips.org>
Subject: touch panel
Date: Tue, 7 Oct 2003 09:50:17 -0700
Message-ID: <002e01c38cf3$16cea990$6d01a8c0@wsyash>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Return-Path: <yshitoot@stellartec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3371
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yshitoot@stellartec.com
Precedence: bulk
X-list: linux-mips

Hello,

About 10% of the time as I lift my finger up the x or the y value changes
e.g.
from my printf statement

status=fffc0000, x=135, y=46
(similar numbers repeated a few times)
status=fffc0000, x=136, y=47
status=fffc0000, x=74, y=113
status=0.x=0,y=0

Have others seen this problem ? any suggestions ? (yes I can always through
away the
line before status changes)

thanks

yash
