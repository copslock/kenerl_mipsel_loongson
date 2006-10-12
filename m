Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Oct 2006 17:06:08 +0100 (BST)
Received: from mail95.messagelabs.com ([216.82.241.67]:18330 "HELO
	mail95.messagelabs.com") by ftp.linux-mips.org with SMTP
	id S20038329AbWJLQGE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 12 Oct 2006 17:06:04 +0100
X-VirusChecked:	Checked
X-Env-Sender: madhvesh.s@ap.sony.com
X-Msg-Ref: server-2.tower-95.messagelabs.com!1160669113!40547900!1
X-StarScan-Version: 5.5.10.7; banners=-,-,-
X-Originating-IP: [202.42.154.167]
Received: (qmail 31786 invoked from network); 12 Oct 2006 16:05:14 -0000
Received: from inetmg1.sony.com.sg (HELO inetmg1.sony.com.sg) (202.42.154.167)
  by server-2.tower-95.messagelabs.com with SMTP; 12 Oct 2006 16:05:14 -0000
Received: from avgw02c.sony.com.sg (avgw02c [43.68.8.33])
	by inetmg1.sony.com.sg (8.11.7+Sun/8.11.6) with SMTP id k9CG5KQ06678
	for <linux-mips@linux-mips.org>; Fri, 13 Oct 2006 00:05:20 +0800 (SGT)
Received: from (seagw.sony.com.sg [43.68.8.1]) by avgw02c.sony.com.sg with smtp
	 id 6d43_710e8702_5a0b_11db_8ddc_001143d917f1;
	Fri, 13 Oct 2006 00:05:12 +0800
Received: from sgapxbh04.ap.sony.com ([43.68.15.49])
	by seagw01.sony.com.sg (8.11.6+Sun/8.11.6) with ESMTP id k9CG5Ca12450
	for <linux-mips@linux-mips.org>; Fri, 13 Oct 2006 00:05:12 +0800 (SGT)
Received: from insardxms01.ap.sony.com ([43.88.102.10]) by sgapxbh04.ap.sony.com with Microsoft SMTPSVC(6.0.3790.1830); Fri, 13 Oct 2006 00:05:08 +0800
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: KProbes Support for MIPS
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.2757
Date:	Thu, 12 Oct 2006 21:34:40 +0530
Message-ID: <7CC0A4CCB789A841944E316301AD153817FDED@insardxms01.ap.sony.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: KProbes Support for MIPS
thread-index: AcbuGB+bzDtKUL9USw6nQES2FBE/xw==
Priority: normal
From:	"Madhvesh Sulibhavi" <madhvesh.s@ap.sony.com>
Importance: normal
To:	<linux-mips@linux-mips.org>
X-OriginalArrivalTime: 12 Oct 2006 16:05:08.0673 (UTC) FILETIME=[307C8310:01C6EE18]
Return-Path: <madhvesh.s@ap.sony.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12919
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: madhvesh.s@ap.sony.com
Precedence: bulk
X-list: linux-mips

Hi All,

The mainline kernel 2.6.16  (and later) had KProbes support
for x86, Alpha and PPC64 architectures. In this patch we provide
an implementation of KProbe for the MIPS arch. It is targetted
at the 2.6.16-24 kernel and tested on the Toshiba TX49 reference
platform. The patch is available in the below CELF wiki page 

http://tree.celinuxforum.org/CelfPubWiki/PatchArchive

The patch can be downloaded from here
http://tree.celinuxforum.org/CelfPubWiki/PatchArchive?action=AttachFile&
do=get&target=kprobes-mips-patches-2.6.16.24.tgz

Please see the documentation for usage and limitations.

Look forward to any feedback.
Thank you

Regards
Madhvesh

=============================
Madhvesh Sulibhavi
Sony India Software Centre
Bangalore
=============================



-------------------------------------------------------------------
This email is confidential and intended only for the use of the individual or entity named above and may contain information that is privileged. If you are not the intended recipient, you are notified that any dissemination, distribution or copying of this email is strictly prohibited. If you have received this email in error, please notify us immediately by return email or telephone and destroy the original message. - This mail is sent via Sony Asia Pacific Mail Gateway.
-------------------------------------------------------------------
