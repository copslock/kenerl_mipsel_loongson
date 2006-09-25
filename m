Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Sep 2006 01:41:24 +0100 (BST)
Received: from ali.ali.com.tw ([202.3.177.34]:1480 "HELO ali.ali.com.tw")
	by ftp.linux-mips.org with SMTP id S20037887AbWIYAlW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 25 Sep 2006 01:41:22 +0100
Received: (qmail 13062 invoked by uid 0); 25 Sep 2006 00:40:51 -0000
Received: from william_lei@ali.com.tw by mx.ali.com.tw by uid 502 with qmail-scanner-1.15 
 (iscan: v3.1/v6.810-1005/783/76729.  Clear:. 
 Processed in 27.27126 secs); 25 Sep 2006 00:40:51 -0000
Received: from unknown (HELO TWALINS2) ([202.3.177.54]) (envelope-sender <william_lei@ali.com.tw>)
          by ali.ali.com.tw (qmail-ldap-1.03) with SMTP
          for <linux-mips@linux-mips.org>; 25 Sep 2006 00:40:23 -0000
Subject: How to emulate lw/sw instruction by lb/sb instruction
To:	linux-mips@linux-mips.org
X-Mailer: Lotus Notes Release 6.0 September 26, 2002
Message-ID: <OF041A6F77.FC0AA7D2-ON482571F4.00036CCB-482571F4.0003EC56@LocalDomain>
From:	william_lei@ali.com.tw
Date:	Mon, 25 Sep 2006 08:41:53 +0800
X-MIMETrack: Serialize by Router on TWALINS2/ALI_TPE/ACER(Release 5.0.11  |July 24, 2002) at
 2006/09/25 08:40:25 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Return-Path: <william_lei@ali.com.tw>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12643
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: william_lei@ali.com.tw
Precedence: bulk
X-list: linux-mips

Dear all
      Could someone tell me how to modify GCC as titled?because we have met
problem while porting some middleware,which will generate some lw/sw
instruction to unaligned address,so I would modify GCC to not generate
lw/sw instructions for this pieces code.
Regards
William Lei

************* Email Confidentiality Notice ********************

The information contained in this e-mail message (including any
attachments) may be confidential, proprietary, privileged, or otherwise
exempt from disclosure under applicable laws. It is intended to be conveyed
only to the designated recipient(s). Any use, dissemination, distribution,
printing, retaining or copying of this e-mail (including its attachments)
by unintended recipient(s) is strictly prohibited and may be unlawful. If
you are not an intended recipient of this e-mail, or believe that you have
received this e-mail in error, please notify the sender immediately (by
replying to this e-mail), delete any and all copies of this e-mail
(including any attachments) from your system, and do not disclose the
content of this e-mail to any other person. Thank you!
